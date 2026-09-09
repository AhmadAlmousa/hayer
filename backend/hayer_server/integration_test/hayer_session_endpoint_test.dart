import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hayer_server/src/admin/poi_issue_moderation_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/storage/catalog_pruner.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

const _anchorLatitude = 24.7136;
const _anchorLongitude = 46.6753;
const _calibrationVersion = 'hayer-google-web-18';

void main() {
  withServerpod(
    'HayerSessionEndpoint with PostGIS',
    (sessionBuilder, endpoints) {
      late TestSessionBuilder host;
      late TestSessionBuilder guest;
      late TestSessionBuilder outsider;

      setUp(() async {
        await _resetHayerTables(sessionBuilder);
        await _seedRestaurantCatalog(sessionBuilder);
        host = _authenticated(sessionBuilder, 'user-host');
        guest = _authenticated(sessionBuilder, 'user-guest');
        outsider = _authenticated(sessionBuilder, 'user-outsider');
      });

      tearDown(() => _resetHayerTables(sessionBuilder));

      Future<SessionBundle> readyChoiceRoom(String key) async {
        final room = await endpoints.hayerSession.create(
          host,
          request: _request(),
          idempotencyKey: key,
        );
        await endpoints.hayerSession.join(
          guest,
          code: room.session.code,
          displayName: 'Guest',
        );
        for (final member in [host, guest]) {
          for (var i = 0; i < room.deck.length; i++) {
            await endpoints.hayerSession.swipe(
              member,
              command: _swipe(
                room,
                index: i,
                liked: i < 3,
                suffix: member == host ? 'host' : 'guest',
              ),
            );
          }
        }
        return endpoints.hayerSession.load(
          host,
          sessionId: room.session.sessionId,
        );
      }

      test(
        'destination choices are one per member, retry safe and editable',
        () async {
          final room = await readyChoiceRoom('choice-editable');
          final id = room.session.sessionId;
          final a = room.deck[0].placeId;
          final b = room.deck[1].placeId;
          expect(room.destinationChoices!.canChoose, isTrue);
          expect(room.destinationChoices!.winnerPlaceId, isNull);
          final responses = await Future.wait([
            endpoints.hayerSession.chooseDestination(
              host,
              sessionId: id,
              placeId: a,
              expectedRevision: 0,
            ),
            endpoints.hayerSession.chooseDestination(
              host,
              sessionId: id,
              placeId: a,
              expectedRevision: 0,
            ),
          ]);
          for (final response in responses) {
            expect(response.destinationChoices!.myRevision, 1);
            expect(response.destinationChoices!.counts[a], 1);
          }
          await Future.wait([
            endpoints.hayerSession.chooseDestination(
              host,
              sessionId: id,
              placeId: b,
              expectedRevision: 1,
            ),
            ...List.generate(
              5,
              (_) => endpoints.hayerSession.load(host, sessionId: id),
            ),
          ]);
          await expectLater(
            endpoints.hayerSession.chooseDestination(
              host,
              sessionId: id,
              placeId: a,
              expectedRevision: 0,
            ),
            throwsA(_apiError('choice_conflict')),
          );
          final reloaded = await endpoints.hayerSession.load(
            host,
            sessionId: id,
          );
          expect(reloaded.destinationChoices!.counts[a], 0);
          expect(reloaded.destinationChoices!.counts[b], 1);
          expect(reloaded.destinationChoices!.myRevision, 2);
          expect(reloaded.selfParticipant.hasCompleted, isTrue);
        },
      );

      test(
        'simultaneous group choices use the host ballot only to break ties',
        () async {
          final room = await readyChoiceRoom('choice-concurrent');
          final id = room.session.sessionId;
          final a = room.deck[0].placeId;
          final b = room.deck[1].placeId;
          await Future.wait([
            endpoints.hayerSession.chooseDestination(
              host,
              sessionId: id,
              placeId: a,
              expectedRevision: 0,
            ),
            endpoints.hayerSession.chooseDestination(
              guest,
              sessionId: id,
              placeId: b,
              expectedRevision: 0,
            ),
          ]);
          final tied = await endpoints.hayerSession.load(guest, sessionId: id);
          expect(tied.destinationChoices!.winnerPlaceId, a);
          expect(tied.destinationChoices!.myPlaceId, b);
          expect(tied.destinationChoices!.hostBrokeTie, isTrue);
          expect(tied.destinationChoices!.isComplete, isTrue);
          expect(
            jsonEncode(
              tied.participants.map((person) => person.toJson()).toList(),
            ),
            isNot(contains('destinationPlaceId')),
          );
          final changed = await endpoints.hayerSession.chooseDestination(
            host,
            sessionId: id,
            placeId: b,
            expectedRevision: 1,
          );
          expect(changed.destinationChoices!.winnerPlaceId, b);
          expect(changed.destinationChoices!.counts[b], 2);
          expect(changed.destinationChoices!.hostBrokeTie, isFalse);
        },
      );

      test(
        'choice mutation enforces membership, matched candidates and expiry',
        () async {
          final room = await readyChoiceRoom('choice-validation');
          final id = room.session.sessionId;
          final a = room.deck.first.placeId;
          await expectLater(
            endpoints.hayerSession.chooseDestination(
              outsider,
              sessionId: id,
              placeId: a,
              expectedRevision: 0,
            ),
            throwsA(_apiError('forbidden')),
          );
          for (final invalid in ['foreign-place', room.deck.last.placeId]) {
            await expectLater(
              endpoints.hayerSession.chooseDestination(
                host,
                sessionId: id,
                placeId: invalid,
                expectedRevision: 0,
              ),
              throwsA(_apiError('bad_request')),
            );
          }
          final db = sessionBuilder.build();
          try {
            await HayerSessionRow.db.updateWhere(
              db,
              where: (table) => table.sessionId.equals(id),
              columnValues: (table) => [
                table.expiresAt(
                  DateTime.now().toUtc().subtract(const Duration(seconds: 1)),
                ),
              ],
            );
          } finally {
            await db.close();
          }
          await expectLater(
            endpoints.hayerSession.chooseDestination(
              host,
              sessionId: id,
              placeId: a,
              expectedRevision: 0,
            ),
            throwsA(_apiError('session_expired')),
          );
        },
      );

      test(
        'late participants pause choice voting while retaining earlier choices',
        () async {
          final room = await readyChoiceRoom('choice-late-join');
          final id = room.session.sessionId;
          final a = room.deck.first.placeId;
          await endpoints.hayerSession.chooseDestination(
            host,
            sessionId: id,
            placeId: a,
            expectedRevision: 0,
          );
          final late = await endpoints.hayerSession.join(
            outsider,
            code: room.session.code,
            displayName: 'Late',
          );
          expect(late.destinationChoices!.canChoose, isFalse);
          expect(late.destinationChoices!.counts[a], 1);
          expect(late.destinationChoices!.winnerPlaceId, isNull);
          await expectLater(
            endpoints.hayerSession.chooseDestination(
              guest,
              sessionId: id,
              placeId: a,
              expectedRevision: 0,
            ),
            throwsA(_apiError('choice_not_ready')),
          );
        },
      );

      test(
        'analytics deduplicates impressions and records explicit choice changes',
        () async {
          final context = _analyticsContext();
          final room = await readyChoiceRoom('choice-analytics');
          final place = room.deck.first;
          final impression = _clientEvent(
            context: context,
            eventName: 'card_impression',
            sessionId: room.session.sessionId,
            placeId: place.placeId,
            deckPosition: 0,
            visibleMilliseconds: 500,
          );
          await endpoints.hayerSession.recordClientAnalytics(
            host,
            event: impression,
          );
          await endpoints.hayerSession.recordClientAnalytics(
            host,
            event: impression.copyWith(eventId: _uuidFor(2)),
          );
          await expectLater(
            endpoints.hayerSession.recordClientAnalytics(
              outsider,
              event: impression.copyWith(eventId: _uuidFor(3)),
            ),
            throwsA(_apiError('forbidden')),
          );
          await expectLater(
            endpoints.hayerSession.recordClientAnalytics(
              host,
              event: impression.copyWith(
                eventId: _uuidFor(4),
                visibleMilliseconds: 499,
              ),
            ),
            throwsA(_apiError('bad_request')),
          );

          await endpoints.hayerSession.chooseDestination(
            host,
            sessionId: room.session.sessionId,
            placeId: place.placeId,
            expectedRevision: 0,
            analyticsContext: context,
          );
          await endpoints.hayerSession.chooseDestination(
            host,
            sessionId: room.session.sessionId,
            placeId: place.placeId,
            expectedRevision: 0,
            analyticsContext: context,
          );
          await endpoints.hayerSession.chooseDestination(
            host,
            sessionId: room.session.sessionId,
            placeId: room.deck[1].placeId,
            expectedRevision: 1,
            analyticsContext: context,
          );

          final events = await _analyticsEvents(sessionBuilder);
          expect(
            events.where((event) => event.metricName == 'deck_included'),
            hasLength(room.deck.length),
          );
          expect(
            events.where((event) => event.metricName == 'deck_exposure'),
            isEmpty,
          );
          expect(
            events.where((event) => event.metricName == 'card_impression'),
            hasLength(1),
          );
          expect(
            events.where((event) => event.metricName == 'choice_confirmed'),
            hasLength(1),
          );
          expect(
            events.where((event) => event.metricName == 'choice_changed'),
            hasLength(1),
          );
          final measured = events.singleWhere(
            (event) => event.metricName == 'card_impression',
          );
          expect(measured.journeyId, context.journeyId);
          expect(measured.origin, 'client');
          expect(measured.eventSchemaVersion, 1);
          expect(measured.deckPosition, 0);
          expect(measured.visibleMilliseconds, 500);
        },
      );

      test(
        'decision analytics separate no-match and actual matched places',
        () async {
          final noMatch = await endpoints.hayerSession.create(
            host,
            request: _request(
              mode: SessionMode.solo,
              analyticsContext: _analyticsContext(5),
            ),
            idempotencyKey: 'analytics-no-match',
          );
          for (var index = 0; index < noMatch.deck.length; index++) {
            await endpoints.hayerSession.swipe(
              host,
              command: _swipe(
                noMatch,
                index: index,
                liked: false,
                suffix: 'no-match',
                analyticsContext: _analyticsContext(5),
              ),
            );
          }

          final matched = await endpoints.hayerSession.create(
            guest,
            request: _request(
              mode: SessionMode.solo,
              analyticsContext: _analyticsContext(6),
            ),
            idempotencyKey: 'analytics-actual-match',
          );
          for (var index = 0; index < matched.deck.length; index++) {
            await endpoints.hayerSession.swipe(
              guest,
              command: _swipe(
                matched,
                index: index,
                liked: index == 0,
                suffix: 'actual-match',
                analyticsContext: _analyticsContext(6),
              ),
            );
          }

          final events = await _analyticsEvents(sessionBuilder);
          expect(
            events.where((event) => event.metricName == 'no_match_completed'),
            hasLength(1),
          );
          final sessionMatches = events.where(
            (event) => event.metricName == 'match_completed',
          );
          expect(sessionMatches, hasLength(1));
          expect(sessionMatches.single.placeId, isEmpty);
          final placeMatches = events.where(
            (event) => event.metricName == 'place_matched',
          );
          expect(placeMatches, hasLength(1));
          expect(placeMatches.single.placeId, matched.deck.first.placeId);
          expect(placeMatches.single.placeId, isNot(matched.deck.last.placeId));
        },
      );

      test(
        'saved-only shortlist preserves order and records reuse without underfill',
        () async {
          final created = await endpoints.hayerSession.create(
            host,
            request: _request(
              mode: SessionMode.solo,
              analyticsContext: _analyticsContext(7),
              shortlistPlaceIds: const ['place-4', 'place-1'],
              freshDiscoveryCount: 0,
            ),
            idempotencyKey: 'shortlist-saved-only',
          );

          expect(_placeIds(created), ['place-4', 'place-1']);
          expect(created.session.deckSizeRequested, 10);
          expect(created.session.deckSizeActual, 2);
          final events = await _analyticsEvents(sessionBuilder);
          final reuse = events.singleWhere(
            (event) => event.metricName == 'shortlist_used',
          );
          expect(reuse.value, 2);
          expect(reuse.sampleCount, 2);
          expect(reuse.outcomeCode, 'saved_only');
          expect(
            events.where((event) => event.metricName == 'underfilled_deck'),
            isEmpty,
          );
        },
      );

      test(
        'shortlist fresh mix excludes saved duplicates and stays bounded',
        () async {
          final created = await endpoints.hayerSession.create(
            host,
            request: _request(
              mode: SessionMode.solo,
              analyticsContext: _analyticsContext(8),
              shortlistPlaceIds: const ['place-0', 'place-1'],
              freshDiscoveryCount: 5,
            ),
            idempotencyKey: 'shortlist-with-fresh',
          );

          expect(created.deck, hasLength(7));
          expect(_placeIds(created).take(2), ['place-0', 'place-1']);
          expect(_placeIds(created).toSet(), hasLength(7));
          final reuse = (await _analyticsEvents(sessionBuilder)).singleWhere(
            (event) => event.metricName == 'shortlist_used',
          );
          expect(reuse.outcomeCode, 'with_discovery');
        },
      );

      test(
        'shortlist creation rejects malformed and unavailable identities',
        () async {
          await expectLater(
            endpoints.hayerSession.create(
              host,
              request: _request(
                mode: SessionMode.solo,
                shortlistPlaceIds: const ['place-0'],
                freshDiscoveryCount: 0,
              ),
              idempotencyKey: 'shortlist-too-small',
            ),
            throwsA(_apiError('bad_request')),
          );
          await expectLater(
            endpoints.hayerSession.create(
              host,
              request: _request(
                mode: SessionMode.solo,
                shortlistPlaceIds: const ['place-0', 'place-0'],
                freshDiscoveryCount: 0,
              ),
              idempotencyKey: 'shortlist-duplicate',
            ),
            throwsA(_apiError('bad_request')),
          );
          await expectLater(
            endpoints.hayerSession.create(
              host,
              request: _request(
                mode: SessionMode.solo,
                shortlistPlaceIds: const ['place-0', 'missing-place'],
                freshDiscoveryCount: 0,
              ),
              idempotencyKey: 'shortlist-unavailable',
            ),
            throwsA(_apiError('shortlist_unavailable')),
          );
        },
      );

      test('concurrent create retries persist one immutable session', () async {
        final request = _request();
        final bundles = await Future.wait([
          endpoints.hayerSession.create(
            host,
            request: request,
            idempotencyKey: 'create-retry-0001',
          ),
          endpoints.hayerSession.create(
            host,
            request: request,
            idempotencyKey: 'create-retry-0001',
          ),
        ]);

        expect(bundles[0].session.sessionId, bundles[1].session.sessionId);
        expect(_placeIds(bundles[0]), _placeIds(bundles[1]));
        expect(bundles[0].deck, hasLength(10));

        final counts = await _rowCounts(sessionBuilder);
        expect(counts.sessions, 1);
        expect(counts.participants, 1);
        expect(counts.sessionPlaces, 10);
        expect(counts.idempotencyKeys, 1);
        expect(counts.rateLimitRows, 1);
        expect(counts.createAttempts, 2);

        await expectLater(
          endpoints.hayerSession.create(
            host,
            request: _request(radiusMeters: 1000),
            idempotencyKey: 'create-retry-0001',
          ),
          throwsA(_apiError('conflict')),
        );
      });

      test('catalog pruning preserves places in immutable decks', () async {
        final created = await endpoints.hayerSession.create(
          host,
          request: _request(),
          idempotencyKey: 'create-prune-proof',
        );
        final session = sessionBuilder.build();
        try {
          final cutoff = DateTime.utc(2026, 1, 1);
          await PoiCatalogRow.db.updateWhere(
            session,
            where: (table) => table.provider.equals('google-web'),
            columnValues: (table) => [
              table.lastSeenAt(DateTime.utc(2025, 1, 1)),
            ],
          );

          final removed = await CatalogPruner.prune(session, cutoff: cutoff);
          final remaining = await PoiCatalogRow.db.find(session);
          final remainingIds = remaining
              .map((row) => row.providerPlaceId)
              .toSet();

          expect(removed, greaterThan(0));
          expect(
            remainingIds,
            containsAll(created.deck.map((place) => place.placeId)),
          );
          expect(remaining, hasLength(created.deck.length));
        } finally {
          await session.close();
        }
      });

      test(
        'late joins receive the original deck and no private votes',
        () async {
          final created = await endpoints.hayerSession.create(
            host,
            request: _request(),
            idempotencyKey: 'create-late-join',
          );
          final firstPlace = created.deck.first;
          await endpoints.hayerSession.swipe(
            host,
            command: _swipe(created, index: 0, liked: true, suffix: 'host'),
          );
          await _renameCatalogPlace(
            sessionBuilder,
            firstPlace.placeId,
            'Changed catalog name',
          );

          final joined = await endpoints.hayerSession.join(
            guest,
            code: created.session.code,
            displayName: 'Guest',
          );

          expect(_placeIds(joined), _placeIds(created));
          expect(joined.deck.first.name, firstPlace.name);
          expect(joined.participants, hasLength(2));
          expect(created.selfParticipant.isHost, isTrue);
          expect(joined.selfParticipant.isHost, isFalse);
          expect(joined.selfParticipant.displayName, 'Guest');
          expect(
            joined.participants.singleWhere((item) => item.isHost).currentIndex,
            1,
          );
          expect(
            joined.participants
                .singleWhere((item) => !item.isHost)
                .currentIndex,
            0,
          );

          await expectLater(
            endpoints.hayerSession.join(
              outsider,
              code: created.session.code,
              displayName: ' guest ',
            ),
            throwsA(_apiError('name_taken')),
          );
          await expectLater(
            endpoints.hayerSession.results(
              outsider,
              sessionId: created.session.sessionId,
            ),
            throwsA(_apiError('forbidden')),
          );
        },
      );

      test('concurrent reads never revert committed swipe progress', () async {
        final created = await endpoints.hayerSession.create(
          host,
          request: _request(),
          idempotencyKey: 'create-read-swipe-race',
        );

        for (var index = 0; index < created.deck.length; index++) {
          await Future.wait([
            endpoints.hayerSession.load(
              host,
              sessionId: created.session.sessionId,
            ),
            endpoints.hayerSession.swipe(
              host,
              command: _swipe(
                created,
                index: index,
                liked: index.isEven,
                suffix: 'read-race',
              ),
            ),
          ]);
          final loaded = await endpoints.hayerSession.load(
            host,
            sessionId: created.session.sessionId,
          );
          expect(loaded.selfParticipant.currentIndex, index + 1);
        }
      });

      test(
        'progress returns mutable state without the immutable deck',
        () async {
          final created = await endpoints.hayerSession.create(
            host,
            request: _request(),
            idempotencyKey: 'create-lightweight-progress',
          );
          await endpoints.hayerSession.join(
            guest,
            code: created.session.code,
            displayName: 'Guest',
          );
          await endpoints.hayerSession.swipe(
            host,
            command: _swipe(
              created,
              index: 0,
              liked: true,
              suffix: 'progress',
            ),
          );

          final progress = await endpoints.hayerSession.progress(
            guest,
            sessionId: created.session.sessionId,
          );

          expect(progress.session.revision, 3);
          expect(progress.participants, hasLength(2));
          expect(progress.selfParticipant.displayName, 'Guest');
          expect(progress.resultTallies, hasLength(created.deck.length));
          expect(
            progress.resultTallies.first,
            isA<SessionResultTally>()
                .having(
                  (value) => value.placeId,
                  'placeId',
                  created.deck[0].placeId,
                )
                .having((value) => value.likeCount, 'likeCount', 1)
                .having((value) => value.voterCount, 'voterCount', 1),
          );
          expect(
            jsonEncode(progress.toJson()),
            isNot(contains(created.deck[0].name)),
          );
          await expectLater(
            endpoints.hayerSession.progress(
              outsider,
              sessionId: created.session.sessionId,
            ),
            throwsA(_apiError('forbidden')),
          );
        },
      );

      test('join attempts share a resolved-client budget', () async {
        for (var index = 0; index < 120; index++) {
          final rotatingIdentity = _authenticated(
            sessionBuilder,
            'join-client-$index',
          );
          await expectLater(
            endpoints.hayerSession.join(
              rotatingIdentity,
              code: 'AAA000',
              displayName: 'Guest',
            ),
            throwsA(_apiError('invalid_code')),
          );
        }

        await expectLater(
          endpoints.hayerSession.join(
            _authenticated(sessionBuilder, 'join-client-over-limit'),
            code: 'AAA000',
            displayName: 'Guest',
          ),
          throwsA(_apiError('rate_limited')),
        );

        final session = sessionBuilder.build();
        try {
          final clientBudget = await RateLimitRow.db.findFirstRow(
            session,
            where: (table) =>
                table.counterKey.equals('session-join-client:peer:unknown'),
          );
          expect(clientBudget, isNotNull);
          expect(clientBudget!.attemptCount, 120);
        } finally {
          await session.close();
        }
      });

      test(
        'duplicate swipes advance once and the latest choice can be revised',
        () async {
          final created = await endpoints.hayerSession.create(
            host,
            request: _request(mode: SessionMode.solo),
            idempotencyKey: 'create-swipe-retry',
          );
          final command = _swipe(
            created,
            index: 0,
            liked: true,
            suffix: 'same-command',
          );

          final bundles = await Future.wait([
            endpoints.hayerSession.swipe(host, command: command),
            endpoints.hayerSession.swipe(host, command: command),
          ]);

          for (final bundle in bundles) {
            expect(bundle.participants.single.currentIndex, 1);
            expect(bundle.session.revision, 2);
          }
          final counts = await _rowCounts(sessionBuilder);
          expect(counts.swipes, 1);

          final revised = await endpoints.hayerSession.swipe(
            host,
            command: _swipe(
              created,
              index: 0,
              liked: false,
              suffix: 'revised',
            ),
          );
          expect(revised.participants.single.currentIndex, 1);
          final results = await endpoints.hayerSession.results(
            host,
            sessionId: created.session.sessionId,
          );
          expect(
            results
                .singleWhere(
                  (item) => item.place.placeId == created.deck.first.placeId,
                )
                .likeCount,
            0,
          );

          await endpoints.hayerSession.swipe(
            host,
            command: _swipe(created, index: 1, liked: true, suffix: 'next'),
          );
          await expectLater(
            endpoints.hayerSession.swipe(
              host,
              command: _swipe(
                created,
                index: 0,
                liked: true,
                suffix: 'too-old',
              ),
            ),
            throwsA(_apiError('conflict')),
          );
        },
      );

      test('after-deck majority remains joinable for late guests', () async {
        final created = await endpoints.hayerSession.create(
          host,
          request: _request(),
          idempotencyKey: 'create-after-deck',
        );
        await endpoints.hayerSession.join(
          guest,
          code: created.session.code,
          displayName: 'Guest',
        );

        for (var index = 0; index < created.deck.length; index++) {
          await endpoints.hayerSession.swipe(
            host,
            command: _swipe(
              created,
              index: index,
              liked: index <= 1,
              suffix: 'host',
            ),
          );
          final guestBundle = await endpoints.hayerSession.swipe(
            guest,
            command: _swipe(
              created,
              index: index,
              liked: index == 0,
              suffix: 'guest',
            ),
          );
          if (index == created.deck.length - 1) {
            expect(guestBundle.session.status, SessionStatus.active);
          }
        }

        final lateGuest = await endpoints.hayerSession.join(
          outsider,
          code: created.session.code,
          displayName: 'Late guest',
        );
        expect(lateGuest.session.status, SessionStatus.active);
        expect(lateGuest.participants, hasLength(3));

        for (var index = 0; index < lateGuest.deck.length; index++) {
          await endpoints.hayerSession.swipe(
            outsider,
            command: _swipe(
              lateGuest,
              index: index,
              liked: index == 0,
              suffix: 'late-guest',
            ),
          );
        }

        final hostResults = await endpoints.hayerSession.results(
          host,
          sessionId: created.session.sessionId,
        );
        final guestResults = await endpoints.hayerSession.results(
          guest,
          sessionId: created.session.sessionId,
        );
        expect(_resultSummary(hostResults), _resultSummary(guestResults));

        final unanimousPlace = hostResults.singleWhere(
          (item) => item.place.placeId == created.deck[0].placeId,
        );
        expect(unanimousPlace.likeCount, 3);
        expect(unanimousPlace.voterCount, 3);
        expect(unanimousPlace.match, isTrue);

        final splitPlace = hostResults.singleWhere(
          (item) => item.place.placeId == created.deck[1].placeId,
        );
        expect(splitPlace.likeCount, 1);
        expect(splitPlace.voterCount, 3);
        expect(splitPlace.match, isFalse);
      });

      test('instant unanimous waits for two voters before matching', () async {
        final created = await endpoints.hayerSession.create(
          host,
          request: _request(
            consensusRule: ConsensusRule.unanimous,
            matchingTiming: MatchingTiming.instant,
          ),
          idempotencyKey: 'create-instant',
        );
        await endpoints.hayerSession.join(
          guest,
          code: created.session.code,
          displayName: 'Guest',
        );

        final hostVote = await endpoints.hayerSession.swipe(
          host,
          command: _swipe(created, index: 0, liked: true, suffix: 'host'),
        );
        expect(hostVote.session.status, SessionStatus.active);

        final guestVote = await endpoints.hayerSession.swipe(
          guest,
          command: _swipe(created, index: 0, liked: true, suffix: 'guest'),
        );
        expect(guestVote.session.status, SessionStatus.completed);
        expect(guestVote.session.matchedPlaceId, created.deck.first.placeId);
      });

      test(
        'abandon permanently deletes only a host-owned solo session',
        () async {
          final solo = await endpoints.hayerSession.create(
            host,
            request: _request(mode: SessionMode.solo),
            idempotencyKey: 'create-abandon-solo',
          );
          await endpoints.hayerSession.swipe(
            host,
            command: _swipe(solo, index: 0, liked: true, suffix: 'abandon'),
          );

          await endpoints.hayerSession.abandon(
            host,
            sessionId: solo.session.sessionId,
          );

          final counts = await _rowCounts(sessionBuilder);
          expect(counts.sessions, 0);
          expect(counts.participants, 0);
          expect(counts.sessionPlaces, 0);
          expect(counts.swipes, 0);
          expect(counts.idempotencyKeys, 0);
          await expectLater(
            endpoints.hayerSession.load(
              host,
              sessionId: solo.session.sessionId,
            ),
            throwsA(_apiError('not_found')),
          );

          final multiplayer = await endpoints.hayerSession.create(
            host,
            request: _request(),
            idempotencyKey: 'create-abandon-multiplayer',
          );
          await expectLater(
            endpoints.hayerSession.abandon(
              host,
              sessionId: multiplayer.session.sessionId,
            ),
            throwsA(_apiError('forbidden')),
          );
        },
      );

      test('expiry is persisted and blocks subsequent writes', () async {
        final created = await endpoints.hayerSession.create(
          host,
          request: _request(mode: SessionMode.solo),
          idempotencyKey: 'create-expiry',
        );
        await _expireSession(sessionBuilder, created.session.sessionId);

        final loaded = await endpoints.hayerSession.load(
          host,
          sessionId: created.session.sessionId,
        );
        expect(loaded.session.status, SessionStatus.expired);

        await expectLater(
          endpoints.hayerSession.swipe(
            host,
            command: _swipe(
              created,
              index: 0,
              liked: true,
              suffix: 'expired',
            ),
          ),
          throwsA(_apiError('session_expired')),
        );
        expect(
          await _sessionStatus(sessionBuilder, created.session.sessionId),
          SessionStatus.expired,
        );
      });

      test(
        'POI reports are membership-bound, retry safe and catalog inert',
        () async {
          final room = await endpoints.hayerSession.create(
            host,
            request: _request(mode: SessionMode.solo),
            idempotencyKey: 'create-report-room',
          );
          final place = room.deck.first;
          final concurrent = await Future.wait([
            endpoints.place.reportIssue(
              host,
              sessionId: room.session.sessionId,
              placeId: place.placeId,
              issueType: PoiIssueType.wrongLocation,
              details: 'Pin is across the street.',
              idempotencyKey: 'report-retry-key',
            ),
            endpoints.place.reportIssue(
              host,
              sessionId: room.session.sessionId,
              placeId: place.placeId,
              issueType: PoiIssueType.wrongLocation,
              details: 'Pin is across the street.',
              idempotencyKey: 'report-concurrent-key',
            ),
          ]);
          expect(concurrent.toSet(), hasLength(1));
          final reportId = concurrent.first;
          expect(
            await endpoints.place.reportIssue(
              host,
              sessionId: room.session.sessionId,
              placeId: place.placeId,
              issueType: PoiIssueType.wrongLocation,
              details: 'Pin is across the street.',
              idempotencyKey: 'report-retry-key',
            ),
            reportId,
          );
          expect(
            await endpoints.place.reportIssue(
              host,
              sessionId: room.session.sessionId,
              placeId: place.placeId,
              issueType: PoiIssueType.wrongLocation,
              details: 'Pin is across the street.',
              idempotencyKey: 'report-dedupe-key',
            ),
            reportId,
          );
          await expectLater(
            endpoints.place.reportIssue(
              host,
              sessionId: room.session.sessionId,
              placeId: place.placeId,
              issueType: PoiIssueType.wrongLocation,
              details: 'A different request body.',
              idempotencyKey: 'report-retry-key',
            ),
            throwsA(_apiError('conflict')),
          );
          await expectLater(
            endpoints.place.reportIssue(
              outsider,
              sessionId: room.session.sessionId,
              placeId: place.placeId,
              issueType: PoiIssueType.closed,
              idempotencyKey: 'outsider-report-key',
            ),
            throwsA(_apiError('forbidden')),
          );
          await expectLater(
            endpoints.place.reportIssue(
              host,
              sessionId: room.session.sessionId,
              placeId: 'not-in-deck',
              issueType: PoiIssueType.closed,
              idempotencyKey: 'missing-place-key',
            ),
            throwsA(_apiError('not_found')),
          );

          final reports = await _issueReports(sessionBuilder);
          expect(reports, hasLength(1));
          expect(reports.single.reportId, reportId);
          expect(reports.single.reporterHash, isNot(contains('user-host')));
          expect(reports.single.reporterHash, hasLength(64));
          expect(reports.single.status, PoiIssueStatus.open);
          expect(reports.single.activeDedupeKey, hasLength(64));
          expect(reports.single.reportedSnapshot.name, place.name);
          final reportKeys = await _reportIdempotencyRows(sessionBuilder);
          expect(reportKeys, hasLength(3));
          expect(
            reportKeys.map((row) => row.userId),
            everyElement(hasLength(64)),
          );
          expect(
            reportKeys.map((row) => row.userId),
            isNot(contains('user-host')),
          );
          expect(await _catalogQuarantineCount(sessionBuilder), 0);
        },
      );

      test(
        'POI report moderation is owned, evidenced, audited and reversible',
        () async {
          final room = await endpoints.hayerSession.create(
            host,
            request: _request(mode: SessionMode.solo),
            idempotencyKey: 'create-moderation-room',
          );
          final reportId = await endpoints.place.reportIssue(
            host,
            sessionId: room.session.sessionId,
            placeId: room.deck.first.placeId,
            issueType: PoiIssueType.wrongCategory,
            details: 'This appears to be a bakery.',
            idempotencyKey: 'moderation-report-key',
          );
          final session = sessionBuilder.build();
          try {
            await expectLater(
              PoiIssueModerationService.mutate(
                session,
                operatorName: 'operator',
                reportId: reportId,
                action: PoiIssueModerationAction.resolve,
                reason: 'Corrected provider mapping.',
                sourceEvidence: 'Provider page and storefront agree.',
              ),
              throwsA(_apiError('conflict')),
            );
            await PoiIssueModerationService.mutate(
              session,
              operatorName: 'operator',
              reportId: reportId,
              action: PoiIssueModerationAction.claim,
              reason: 'Claimed for review.',
            );
            await expectLater(
              PoiIssueModerationService.mutate(
                session,
                operatorName: 'another.operator',
                reportId: reportId,
                action: PoiIssueModerationAction.dismiss,
                reason: 'Report is not reproducible.',
                sourceEvidence: 'Provider page still shows the same category.',
              ),
              throwsA(_apiError('conflict')),
            );
            await PoiIssueModerationService.mutate(
              session,
              operatorName: 'operator',
              reportId: reportId,
              action: PoiIssueModerationAction.resolve,
              reason: 'Corrected provider mapping.',
              sourceEvidence: 'Provider page and storefront agree.',
            );
            var report = (await PoiIssueReportRow.db.find(
              session,
            )).single;
            expect(report.status, PoiIssueStatus.resolved);
            expect(report.activeDedupeKey, isNull);
            expect(report.sourceEvidence, isNotNull);
            expect(await _catalogQuarantineCount(sessionBuilder), 0);

            await PoiIssueModerationService.mutate(
              session,
              operatorName: 'operator',
              reportId: reportId,
              action: PoiIssueModerationAction.reopen,
              reason: 'New source evidence needs review.',
            );
            report = (await PoiIssueReportRow.db.find(session)).single;
            expect(report.status, PoiIssueStatus.open);
            expect(report.ownerName, isNull);
            expect(report.activeDedupeKey, isNotNull);
            expect(report.sourceEvidence, isNull);

            final audit = await AdminAuditRow.db.find(
              session,
              orderBy: (table) => table.occurredAt,
            );
            expect(
              audit.map((entry) => entry.action),
              [
                'poi_issue.claim',
                'poi_issue.resolve',
                'poi_issue.reopen',
              ],
            );
            expect(audit.last.beforeData?['status'], 'resolved');
            expect(audit.last.afterData?['status'], 'open');
          } finally {
            await session.close();
          }
        },
      );

      test('POI report hourly budget stops anonymous flooding', () async {
        final room = await endpoints.hayerSession.create(
          host,
          request: _request(mode: SessionMode.solo),
          idempotencyKey: 'create-report-budget-room',
        );
        for (var index = 0; index < 6; index++) {
          await endpoints.place.reportIssue(
            host,
            sessionId: room.session.sessionId,
            placeId: room.deck[index].placeId,
            issueType: PoiIssueType.closed,
            idempotencyKey: 'budget-report-$index',
          );
        }
        await expectLater(
          endpoints.place.reportIssue(
            host,
            sessionId: room.session.sessionId,
            placeId: room.deck[6].placeId,
            issueType: PoiIssueType.closed,
            idempotencyKey: 'budget-report-6',
          ),
          throwsA(_apiError('rate_limited')),
        );

        expect(await _issueReports(sessionBuilder), hasLength(6));
        final reportLimits = await _reportRateLimits(sessionBuilder);
        expect(reportLimits, hasLength(2));
        expect(reportLimits.map((row) => row.attemptCount), everyElement(6));
        expect(await _catalogQuarantineCount(sessionBuilder), 0);
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
    serverpodStartTimeout: const Duration(minutes: 2),
  );
}

TestSessionBuilder _authenticated(
  TestSessionBuilder sessionBuilder,
  String userIdentifier,
) => sessionBuilder.copyWith(
  authentication: AuthenticationOverride.authenticationInfo(
    userIdentifier,
    const <Scope>{},
  ),
);

CreateSessionRequest _request({
  SessionMode mode = SessionMode.multiplayer,
  int radiusMeters = 500,
  ConsensusRule consensusRule = ConsensusRule.majority,
  MatchingTiming matchingTiming = MatchingTiming.afterDeck,
  ClientAnalyticsContext? analyticsContext,
  List<String>? shortlistPlaceIds,
  int? freshDiscoveryCount,
}) => CreateSessionRequest(
  mode: mode,
  categoryId: 'restaurant',
  subcategoryIds: const [],
  anchorLatitude: _anchorLatitude,
  anchorLongitude: _anchorLongitude,
  anchorAddress: 'Riyadh',
  radiusMeters: radiusMeters,
  deckSize: 10,
  displayName: 'Host',
  consensusRule: consensusRule,
  matchingTiming: matchingTiming,
  analyticsContext: analyticsContext,
  shortlistPlaceIds: shortlistPlaceIds,
  freshDiscoveryCount: freshDiscoveryCount,
);

SwipeCommand _swipe(
  SessionBundle bundle, {
  required int index,
  required bool liked,
  required String suffix,
  ClientAnalyticsContext? analyticsContext,
}) => SwipeCommand(
  sessionId: bundle.session.sessionId,
  placeId: bundle.deck[index].placeId,
  liked: liked,
  swipeIndex: index,
  clientSwipedAt: DateTime.utc(2026, 9, 2, 12, 0, index),
  idempotencyKey: '${bundle.session.sessionId}-$suffix-$index',
  analyticsContext: analyticsContext,
);

ClientAnalyticsContext _analyticsContext([int suffix = 1]) =>
    ClientAnalyticsContext(
      journeyId: _uuidFor(suffix),
      schemaVersion: 1,
      appBuild: 7,
      platform: 'android',
      language: 'en',
    );

ClientAnalyticsEvent _clientEvent({
  required ClientAnalyticsContext context,
  required String eventName,
  required String sessionId,
  String? placeId,
  int? deckPosition,
  int? visibleMilliseconds,
}) => ClientAnalyticsEvent(
  eventId: _uuidFor(1),
  eventName: eventName,
  occurredAt: DateTime.now().toUtc(),
  context: context,
  sessionId: sessionId,
  placeId: placeId,
  deckPosition: deckPosition,
  visibleMilliseconds: visibleMilliseconds,
);

String _uuidFor(int suffix) =>
    '01991ed0-38ab-7d18-9f25-${suffix.toString().padLeft(12, '0')}';

Matcher _apiError(String code) => isA<ApiException>().having(
  (error) => error.code,
  'code',
  code,
);

List<String> _placeIds(SessionBundle bundle) =>
    bundle.deck.map((place) => place.placeId).toList(growable: false);

List<(String, int, int, bool, int)> _resultSummary(
  List<SessionResult> results,
) => results
    .map(
      (result) => (
        result.place.placeId,
        result.likeCount,
        result.voterCount,
        result.match,
        result.rank,
      ),
    )
    .toList(growable: false);

Future<void> _seedRestaurantCatalog(
  TestSessionBuilder sessionBuilder,
) async {
  final session = sessionBuilder.build();
  try {
    final now = DateTime.now().toUtc();
    final places = [
      for (var index = 0; index < 10; index++) _place(index, checkedAt: now),
    ];
    await PoiCatalogRow.db.insert(
      session,
      [
        for (final place in places)
          PoiCatalogRow(
            provider: 'google-web',
            providerPlaceId: place.placeId,
            featureId: place.featureId,
            normalizedName: place.name.toLowerCase(),
            name: place.name,
            countryCode: 'SA',
            latitude: place.latitude,
            longitude: place.longitude,
            categoryIds: const ['restaurant'],
            snapshot: place,
            calibrationVersion: _calibrationVersion,
            sourceCheckedAt: now,
            firstSeenAt: now,
            lastSeenAt: now,
          ),
      ],
    );
    await PoiCoverageRow.db.insertRow(
      session,
      PoiCoverageRow(
        coverageKey: _coverageKey(
          categoryIds: const ['restaurant'],
          countryCode: 'SA',
          latitude: _anchorLatitude,
          longitude: _anchorLongitude,
          radiusMeters: 500,
        ),
        queryKey: 'restaurant',
        language: 'en',
        countryCode: 'SA',
        anchorLatitude: _anchorLatitude,
        anchorLongitude: _anchorLongitude,
        radiusMeters: 500,
        calibrationVersion: _calibrationVersion,
        resultCount: places.length,
        refreshedAt: now,
        expiresAt: now.add(const Duration(hours: 1)),
      ),
    );
  } finally {
    await session.close();
  }
}

PlaceSnapshot _place(int index, {required DateTime checkedAt}) {
  final offset = index * 0.00005;
  return PlaceSnapshot(
    placeId: 'place-$index',
    featureId: 'feature-$index',
    name: 'Restaurant $index',
    primaryType: 'Restaurant',
    categoryIds: const ['restaurant'],
    rating: 4.8 - (index * 0.05),
    reviewCount: 1000 - index,
    priceLevel: 2,
    priceText: r'$$',
    isOpen: true,
    statusText: 'Open',
    hours: const [],
    distanceMeters: 0,
    latitude: _anchorLatitude + offset,
    longitude: _anchorLongitude + offset,
    formattedAddress: 'Riyadh, Saudi Arabia',
    mapsUrl: 'https://www.google.com/maps/place/place-$index',
    photoUrls: const [],
    attributions: const ['Google Maps'],
    sourceCheckedAt: checkedAt,
    isStale: false,
  );
}

String _coverageKey({
  required List<String> categoryIds,
  required String countryCode,
  required double latitude,
  required double longitude,
  required int radiusMeters,
}) => sha256
    .convert(
      utf8.encode(
        '${countryCode}_${latitude.toStringAsFixed(3)}_'
        '${longitude.toStringAsFixed(3)}_${radiusMeters}_'
        '${categoryIds.join(',')}',
      ),
    )
    .toString();

Future<void> _resetHayerTables(TestSessionBuilder sessionBuilder) async {
  final session = sessionBuilder.build();
  try {
    await session.db.unsafeExecute('''
TRUNCATE TABLE
  "hayer_admin_audit",
  "hayer_poi_issue_report",
  "hayer_product_analytics_hour",
  "hayer_product_analytics_event",
  "hayer_swipe",
  "hayer_session_place",
  "hayer_participant",
  "hayer_session",
  "hayer_idempotency",
  "hayer_rate_limit",
  "hayer_operational_metric",
  "hayer_poi_category",
  "hayer_poi_coverage",
  "hayer_poi_catalog"
CASCADE
''');
  } finally {
    await session.close();
  }
}

Future<List<PoiIssueReportRow>> _issueReports(
  TestSessionBuilder sessionBuilder,
) async {
  final session = sessionBuilder.build();
  try {
    return await PoiIssueReportRow.db.find(
      session,
      orderBy: (table) => table.createdAt,
    );
  } finally {
    await session.close();
  }
}

Future<List<RateLimitRow>> _reportRateLimits(
  TestSessionBuilder sessionBuilder,
) async {
  final session = sessionBuilder.build();
  try {
    final rows = await RateLimitRow.db.find(session);
    return rows
        .where((row) => row.counterKey.startsWith('poi-issue-report-'))
        .toList(growable: false);
  } finally {
    await session.close();
  }
}

Future<List<IdempotencyRow>> _reportIdempotencyRows(
  TestSessionBuilder sessionBuilder,
) async {
  final session = sessionBuilder.build();
  try {
    return await IdempotencyRow.db.find(
      session,
      where: (table) => table.scope.equals('poi-issue-report'),
    );
  } finally {
    await session.close();
  }
}

Future<int> _catalogQuarantineCount(
  TestSessionBuilder sessionBuilder,
) async {
  final session = sessionBuilder.build();
  try {
    return await PoiCatalogRow.db.count(
      session,
      where: (table) => table.quarantinedAt.notEquals(null),
    );
  } finally {
    await session.close();
  }
}

Future<List<ProductAnalyticsEventRow>> _analyticsEvents(
  TestSessionBuilder sessionBuilder,
) async {
  final session = sessionBuilder.build();
  try {
    return await ProductAnalyticsEventRow.db.find(
      session,
      orderBy: (table) => table.occurredAt,
    );
  } finally {
    await session.close();
  }
}

Future<void> _renameCatalogPlace(
  TestSessionBuilder sessionBuilder,
  String placeId,
  String name,
) async {
  final session = sessionBuilder.build();
  try {
    final row = await PoiCatalogRow.db.findFirstRow(
      session,
      where: (table) => table.providerPlaceId.equals(placeId),
    );
    if (row == null) throw StateError('Seeded catalog place was not found.');
    row.name = name;
    row.normalizedName = name.toLowerCase();
    row.snapshot = row.snapshot.copyWith(name: name);
    await PoiCatalogRow.db.updateRow(session, row);
  } finally {
    await session.close();
  }
}

Future<void> _expireSession(
  TestSessionBuilder sessionBuilder,
  String sessionId,
) async {
  final session = sessionBuilder.build();
  try {
    final row = await HayerSessionRow.db.findFirstRow(
      session,
      where: (table) => table.sessionId.equals(sessionId),
    );
    if (row == null) throw StateError('Created session was not found.');
    row.expiresAt = DateTime.now().toUtc().subtract(const Duration(minutes: 1));
    await HayerSessionRow.db.updateRow(session, row);
  } finally {
    await session.close();
  }
}

Future<SessionStatus?> _sessionStatus(
  TestSessionBuilder sessionBuilder,
  String sessionId,
) async {
  final session = sessionBuilder.build();
  try {
    return (await HayerSessionRow.db.findFirstRow(
      session,
      where: (table) => table.sessionId.equals(sessionId),
    ))?.status;
  } finally {
    await session.close();
  }
}

Future<
  ({
    int sessions,
    int participants,
    int sessionPlaces,
    int idempotencyKeys,
    int swipes,
    int rateLimitRows,
    int createAttempts,
  })
>
_rowCounts(TestSessionBuilder sessionBuilder) async {
  final session = sessionBuilder.build();
  try {
    final createLimit = await RateLimitRow.db.findFirstRow(
      session,
      where: (table) => table.counterKey.equals('session-create:user-host'),
    );
    return (
      sessions: await HayerSessionRow.db.count(session),
      participants: await ParticipantRow.db.count(session),
      sessionPlaces: await SessionPlaceRow.db.count(session),
      idempotencyKeys: await IdempotencyRow.db.count(session),
      swipes: await SwipeRow.db.count(session),
      rateLimitRows: await RateLimitRow.db.count(session),
      createAttempts: createLimit?.attemptCount ?? 0,
    );
  } finally {
    await session.close();
  }
}
