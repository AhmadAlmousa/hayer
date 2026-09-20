import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';

import '../features/discover/discover_screen.dart';
import '../features/intent/intent_category_screen.dart';
import '../features/intent/intent_location_screen.dart';
import '../features/intent/intent_next_screen.dart';
import '../features/join/join_screen.dart';
import '../features/lobby/lobby_screen.dart';
import '../features/privacy/data_and_privacy_screen.dart';
import '../features/results/results_screen.dart';
import '../features/saved/saved_places_screen.dart';
import '../features/scan/scan_screen.dart';
import '../features/swipe/swipe_screen.dart';

GoRouter createAppRouter({String? initialLocation}) => GoRouter(
  initialLocation: initialLocation,
  redirect: (context, state) {
    final path = state.uri.path;
    if (path == '/app') return '/';
    if (path.startsWith('/app/')) {
      return state.uri.replace(path: path.substring(4)).toString();
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IntentCategoryScreen(),
      routes: [
        // Under home, so that `go` to a Discover link always leaves home
        // beneath it, and so that every committed query change keeps the same
        // page, map and results rather than stacking a new screen.
        GoRoute(
          path: 'discover',
          builder: (context, state) => DiscoverScreen(uri: state.uri),
        ),
      ],
    ),
    GoRoute(path: '/setup', redirect: (context, state) => '/'),
    GoRoute(
      path: '/where',
      builder: (context, state) => const IntentLocationScreen(),
    ),
    GoRoute(
      path: '/next',
      builder: (context, state) => const IntentNextScreen(),
    ),
    GoRoute(path: '/scan', builder: (context, state) => const ScanScreen()),
    GoRoute(
      path: '/data',
      builder: (context, state) => const DataAndPrivacyScreen(),
    ),
    GoRoute(
      path: '/saved',
      builder: (context, state) => const SavedPlacesScreen(),
      routes: [GoRoute(path: 'start', redirect: (context, state) => '/saved')],
    ),
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
