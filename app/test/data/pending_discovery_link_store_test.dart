import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/data/pending_discovery_link_store.dart';

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test('keeps a link and forgets it on clear', () async {
    const store = SecurePendingDiscoveryLinkStore();

    await store.write('/discover?v=1&sort=top_rated');
    expect(await store.read(), '/discover?v=1&sort=top_rated');

    await store.clear();
    expect(await store.read(), isNull);
  });

  test('reads a kept link back in canonical form', () async {
    FlutterSecureStorage.setMockInitialValues({
      SecurePendingDiscoveryLinkStore.storageKey:
          '/discover?sort=top_rated&v=1&cat=cafes,bakeries',
    });

    expect(
      await const SecurePendingDiscoveryLinkStore().read(),
      '/discover?v=1&sort=top_rated&cat=bakeries,cafes',
    );
  });

  test('ignores a kept value that is not a discovery link', () async {
    FlutterSecureStorage.setMockInitialValues({
      SecurePendingDiscoveryLinkStore.storageKey: '/join/ABC123',
    });

    expect(await const SecurePendingDiscoveryLinkStore().read(), isNull);
  });
}
