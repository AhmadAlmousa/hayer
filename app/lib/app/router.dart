import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';

import '../features/home/home_screen.dart';
import '../features/join/join_screen.dart';
import '../features/lobby/lobby_screen.dart';
import '../features/results/results_screen.dart';
import '../features/scan/scan_screen.dart';
import '../features/setup/setup_screen.dart';
import '../features/swipe/swipe_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/setup', builder: (context, state) => const SetupScreen()),
    GoRoute(path: '/scan', builder: (context, state) => const ScanScreen()),
    GoRoute(
      path: '/join',
      builder: (context, state) => const JoinScreen(),
      routes: [
        GoRoute(
          path: ':code',
          builder: (context, state) =>
              JoinScreen(initialCode: state.pathParameters['code']),
        ),
      ],
    ),
    GoRoute(
      path: '/lobby/:sessionId',
      builder: (context, state) => LobbyScreen(
        sessionId: state.pathParameters['sessionId']!,
        initialBundle: state.extra as SessionBundle?,
      ),
    ),
    GoRoute(
      path: '/swipe/:sessionId',
      builder: (context, state) => SwipeScreen(
        sessionId: state.pathParameters['sessionId']!,
        initialBundle: state.extra as SessionBundle?,
      ),
    ),
    GoRoute(
      path: '/results/:sessionId',
      builder: (context, state) =>
          ResultsScreen(sessionId: state.pathParameters['sessionId']!),
    ),
  ],
);
