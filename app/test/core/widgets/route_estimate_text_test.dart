import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/core/widgets/route_estimate_text.dart';
import 'package:hayer_app/data/location_warmup.dart';
import 'package:hayer_app/data/route_estimate_repository.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  testWidgets('provider failure keeps distance based on the guest location', (
    tester,
  ) async {
    final repository = _Repository(_Location(_position));
    await tester.pumpWidget(
      _app(repository, _place('first'), RouteOriginMode.participantLocation),
    );
    repository.requests['first']!.completeError(StateError('Unavailable'));
    await tester.pumpAndSettle();

    expect(find.text('1.1 km'), findsOneWidget);
    expect(find.text('9 km'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('missing guest location never displays the host distance', (
    tester,
  ) async {
    final repository = _Repository(_Location(null));
    await tester.pumpWidget(
      _app(repository, _place('first'), RouteOriginMode.participantLocation),
    );
    repository.requests['first']!.completeError(StateError('No location'));
    await tester.pumpAndSettle();

    expect(find.text('Distance unavailable'), findsOneWidget);
    expect(find.text('9 km'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('changing places clears the previous route while loading', (
    tester,
  ) async {
    final repository = _Repository(_Location(null));
    await tester.pumpWidget(
      _app(repository, _place('first'), RouteOriginMode.sessionAnchor),
    );
    repository.requests['first']!.complete(
      RouteEstimate(
        distanceMeters: 2000,
        durationSeconds: 600,
        trafficAware: true,
        checkedAt: DateTime.utc(2026, 9, 8),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('~10 min · 2 km'), findsOneWidget);

    await tester.pumpWidget(
      _app(repository, _place('second'), RouteOriginMode.sessionAnchor),
    );
    await tester.pump();

    expect(find.text('~10 min · 2 km'), findsNothing);
    expect(find.text('9 km'), findsOneWidget);
    repository.requests['second']!.completeError(StateError('Unavailable'));
    await tester.pumpAndSettle();
    expect(find.text('9 km'), findsOneWidget);
  });
}

Widget _app(
  RouteEstimateRepository repository,
  PlaceSnapshot place,
  RouteOriginMode origin,
) => ProviderScope(
  overrides: [routeEstimateRepositoryProvider.overrideWithValue(repository)],
  child: MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: RouteEstimateText(
        sessionId: 'session',
        place: place,
        origin: origin,
        enabled: true,
      ),
    ),
  ),
);

class _Repository extends RouteEstimateRepository {
  _Repository(LocationWarmup location)
    : super(client: Client('http://localhost/'), location: location);

  final requests = <String, Completer<RouteEstimate>>{};

  @override
  Future<RouteEstimate> estimate({
    required String sessionId,
    required String placeId,
    required RouteOriginMode origin,
  }) => (requests[placeId] = Completer<RouteEstimate>()).future;
}

class _Location implements LocationWarmup {
  _Location(this.latest);

  @override
  final Position? latest;

  @override
  Future<Position?> get ready async => latest;

  @override
  Future<Position?> locate({
    bool requestPermission = false,
    bool refresh = false,
  }) async => latest;
}

final _position = Position(
  latitude: 0,
  longitude: 0,
  timestamp: DateTime.utc(2026, 9, 8),
  accuracy: 10,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

PlaceSnapshot _place(String id) => PlaceSnapshot(
  placeId: id,
  name: id,
  categoryIds: const ['restaurant'],
  hours: const [],
  distanceMeters: 9000,
  latitude: 0,
  longitude: 0.01,
  photoUrls: const [],
  attributions: const ['Google Maps'],
  sourceCheckedAt: DateTime.utc(2026, 9, 8),
  isStale: false,
);
