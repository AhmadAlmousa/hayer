import 'dart:async';
import 'dart:io';

import 'package:watcher/watcher.dart';

Future<void> main() async {
  Process? child;
  Timer? debounce;
  final done = Completer<void>();
  var stopping = false;
  var restarting = false;

  Future<void> start() async {
    final launched = child = await Process.start(
      Platform.resolvedExecutable,
      const [
        'bin/main.dart',
        '--mode=production',
        '--server-id=default',
        '--logging=normal',
        '--role=monolith',
        '--apply-migrations',
      ],
      mode: ProcessStartMode.inheritStdio,
    );
    unawaited(
      launched.exitCode.then((code) async {
        if (!stopping && !restarting && identical(child, launched)) {
          stderr.writeln(
            'Server exited with $code; restarting in two seconds.',
          );
          await Future<void>.delayed(const Duration(seconds: 2));
          if (!stopping) {
            await start();
          }
        }
      }),
    );
  }

  Future<void> restart() async {
    if (restarting || stopping) return;
    restarting = true;
    final current = child;
    if (current != null) {
      current.kill(ProcessSignal.sigterm);
      await current.exitCode.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          current.kill(ProcessSignal.sigkill);
          return -1;
        },
      );
    }
    if (!stopping) {
      await start();
    }
    restarting = false;
  }

  for (final signal in [ProcessSignal.sigterm, ProcessSignal.sigint]) {
    signal.watch().listen((_) async {
      stopping = true;
      debounce?.cancel();
      child?.kill(ProcessSignal.sigterm);
      await child?.exitCode;
      if (!done.isCompleted) {
        done.complete();
      }
    });
  }

  await start();
  final subscriptions = <StreamSubscription<WatchEvent>>[];
  for (final path in const ['lib', 'bin', 'config']) {
    subscriptions.add(
      DirectoryWatcher(path).events.listen((event) {
        if (event.path.endsWith('.log') ||
            event.path.endsWith('passwords.yaml')) {
          return;
        }
        debounce?.cancel();
        debounce = Timer(const Duration(milliseconds: 750), restart);
      }),
    );
  }
  await done.future;
  for (final subscription in subscriptions) {
    await subscription.cancel();
  }
}
