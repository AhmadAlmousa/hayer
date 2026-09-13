import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';

import '../features/discover/discover_screen.dart';
import '../features/home/home_screen.dart';
import '../features/join/join_screen.dart';
import '../features/lobby/lobby_screen.dart';
import '../features/privacy/data_and_privacy_screen.dart';
import '../features/results/results_screen.dart';
import '../features/saved/saved_places_screen.dart';
import '../features/saved/shortlist_setup_screen.dart';
import '../features/scan/scan_screen.dart';
import '../features/setup/setup_screen.dart';
import '../features/swipe/swipe_screen.dart';
import '../domain/shortlist_draft.dart';

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
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/setup', builder: (context, state) => const SetupScreen()),
    GoRoute(
      path: '/discover',
      builder: (context, state) => const DiscoverScreen(),
    ),
    GoRoute(path: '/scan', builder: (context, state) => const ScanScreen()),
    GoRoute(
      path: '/data',
      builder: (context, state) => const DataAndPrivacyScreen(),
    ),
    GoRoute(
      path: '/saved',
      builder: (context, state) => const SavedPlacesScreen(),
      routes: [
        GoRoute(
          path: 'start',
          builder: (context, state) => switch (state.extra) {
            final ShortlistDraft draft => ShortlistSetupScreen(draft: draft),
            _ => const SavedPlacesScreen(),
          },
        ),
      ],
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

final appRouter = createAppRouter();
