import 'dart:convert';
import 'dart:io';

import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/sessions/destination_choices.dart';
import 'package:test/test.dart';

final _now = DateTime.utc(2026, 9, 8);

void main() {
  group('destination election', () {
    test('likes and completed decks alone do not select a destination', () {
      final state = _state([null, null]);
      expect(state.counts, {'a': 0, 'b': 0, 'c': 0});
      expect(state.winnerPlaceId, isNull);
      expect(state.tiedPlaceIds, isEmpty);
      expect(state.isComplete, isFalse);
    });

    test('highest count wins even when the host prefers another place', () {
      final state = _state(['a', 'b', 'b']);
      expect(state.winnerPlaceId, 'b');
      expect(state.counts, {'a': 1, 'b': 2, 'c': 0});
      expect(state.isComplete, isTrue);
      expect(state.hostBrokeTie, isFalse);
    });

    test('host vote decides two-way and multi-way ties', () {
      for (final votes in [
        ['b', 'a'],
        ['c', 'a', 'b'],
      ]) {
        final state = _state(votes);
        expect(state.winnerPlaceId, votes.first);
        expect(state.hostBrokeTie, isTrue);
      }
    });

    test('host outside the leading tie or not voting leaves it unresolved', () {
      for (final host in ['c', null]) {
        final state = _state([host, 'a', 'b', 'a', 'b']);
        expect(state.winnerPlaceId, isNull);
        expect(state.tiedPlaceIds, ['a', 'b']);
        expect(state.isComplete, isFalse);
        expect(state.hostBrokeTie, isFalse);
      }
    });

    test(
      'an incomplete election has a leader, not a completed group choice',
      () {
        final state = _state(['a', null, null]);
        expect(state.winnerPlaceId, 'a');
        expect(state.chosenCount, 1);
        expect(state.participantCount, 3);
        expect(state.isComplete, isFalse);
      },
    );

    test('changing a ballot moves its vote instead of adding another', () {
      final before = _state(['a', 'b']);
      final after = _state(['b', 'b']);
      expect(before.counts['a'], 1);
      expect(after.counts['a'], 0);
      expect(after.counts['b'], 2);
      expect(after.chosenCount, before.chosenCount);
    });

    test('late join pauses choices without erasing stored ballots', () {
      final state = _state(['a', 'b', null], pending: true);
      expect(state.canChoose, isFalse);
      expect(state.myPlaceId, 'a');
      expect(state.winnerPlaceId, isNull);
      expect(state.chosenCount, 2);
    });

    test('instant matches allow choices without finishing the deck', () {
      final state = _state(
        ['a', 'a'],
        pending: true,
        status: SessionStatus.completed,
      );
      expect(state.canChoose, isTrue);
      expect(state.winnerPlaceId, 'a');
    });

    test('expired sessions are read-only and preserve saved counts', () {
      final state = _state(['a', 'a'], expired: true);
      expect(state.canChoose, isFalse);
      expect(state.counts['a'], 2);
    });

    test(
      'expiry preserves an instant room winner despite unfinished decks',
      () {
        final state = _state(
          ['a', 'a'],
          pending: true,
          expired: true,
          status: SessionStatus.expired,
          matchedPlaceId: 'a',
        );
        expect(state.canChoose, isFalse);
        expect(state.winnerPlaceId, 'a');
        expect(state.isComplete, isTrue);
      },
    );

    test(
      'unmatched or foreign places cannot receive effective choice votes',
      () {
        final state = _state(['foreign', 'rejected']);
        expect(state.myPlaceId, isNull);
        expect(state.counts.keys, isNot(contains('rejected')));
        expect(state.counts.keys, isNot(contains('foreign')));
        expect(state.chosenCount, 0);
      },
    );

    test('only the caller ballot and aggregate counts are serialized', () {
      final state = _state(['a', 'b']);
      expect(state.myPlaceId, 'a');
      final json = jsonEncode(state.toJson());
      expect(json, isNot(contains('private-user')));
      expect(json, isNot(contains('private-name')));
    });
  });

  test(
    'choice migration is additive and retains fresh database protections',
    () async {
      const id = '20260908061228738-destination-choices';
      final sql = await File('migrations/$id/migration.sql').readAsString();
      final definition = await File('migrations/$id/definition.sql')
          .readAsString();
      expect(sql, contains('ADD COLUMN "destinationPlaceId" text'));
      expect(
        sql,
        contains(
          'ADD COLUMN "destinationChoiceRevision" bigint NOT NULL DEFAULT 0',
        ),
      );
      expect(sql, isNot(contains('DROP ')));
      expect(definition, contains('CREATE EXTENSION IF NOT EXISTS postgis;'));
      expect(definition, contains('hayer_cache_policy_valid'));
      expect(definition, contains('hayer_participant_session_fk'));
    },
  );
}

DestinationChoiceState _state(
  List<String?> ballots, {
  bool pending = false,
  bool expired = false,
  SessionStatus status = SessionStatus.active,
  String? matchedPlaceId,
}) {
  final participants = [
    for (var i = 0; i < ballots.length; i++)
      ParticipantRow(
        participantId: 'person-$i',
        sessionId: 'room',
        userId: 'private-user-$i',
        displayName: 'private-name-$i',
        normalizedName: 'name-$i',
        isHost: i == 0,
        currentIndex: 4,
        hasCompleted: !pending,
        lastSeenAt: _now,
        destinationPlaceId: ballots[i],
        destinationChoiceRevision: ballots[i] == null ? 0 : 1,
      ),
  ];
  return DestinationChoices.summarize(
    room: HayerSessionRow(
      sessionId: 'room',
      code: 'ABC234',
      hostUserId: 'private-user-0',
      mode: SessionMode.multiplayer,
      categoryId: 'restaurant',
      subcategoryIds: [],
      anchorLatitude: 24.7,
      anchorLongitude: 46.6,
      countryCode: 'SA',
      radiusMeters: 1500,
      deckSizeRequested: 10,
      deckSizeActual: 4,
      consensusRule: ConsensusRule.majority,
      matchingTiming: MatchingTiming.afterDeck,
      status: status,
      matchedPlaceId: matchedPlaceId,
      revision: 1,
      createdAt: _now,
      expiresAt: expired ? _now : _now.add(const Duration(hours: 24)),
    ),
    participants: participants,
    swipes: [
      for (final person in participants)
        for (final id in ['a', 'b', 'c', 'rejected'])
          SwipeRow(
            sessionId: 'room',
            userId: person.userId,
            placeId: id,
            liked: id != 'rejected',
            swipeIndex: 0,
            clientSwipedAt: _now,
            serverReceivedAt: _now,
            idempotencyKey: '${person.userId}-$id',
          ),
    ],
    deckPlaceIds: ['a', 'b', 'c', 'rejected'],
    userId: 'private-user-0',
    now: _now,
  );
}
