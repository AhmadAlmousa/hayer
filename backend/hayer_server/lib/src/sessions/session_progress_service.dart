import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'consensus.dart';
import 'destination_choices.dart';
import 'session_mapper.dart';

/// Reads the room fields that can change after its immutable deck is loaded.
abstract final class SessionProgressService {
  static const _presenceWriteInterval = Duration(seconds: 30);

  static Future<SessionProgress> load(
    Session session, {
    required String sessionId,
    required String userId,
  }) async {
    final now = DateTime.now().toUtc();
    await _expireIfAuthorized(
      session,
      sessionId: sessionId,
      userId: userId,
      now: now,
    );
    return session.db.transaction((transaction) async {
      final room = await HayerSessionRow.db.findFirstRow(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        transaction: transaction,
        lockMode: LockMode.forShare,
      );
      if (room == null) {
        throw ApiException(code: 'not_found', message: 'Session not found.');
      }
      final self = await ParticipantRow.db.findFirstRow(
        session,
        where: (table) =>
            table.sessionId.equals(sessionId) & table.userId.equals(userId),
        transaction: transaction,
      );
      if (self == null) {
        throw ApiException(
          code: 'forbidden',
          message: 'You are not a member of this session.',
        );
      }
      if (now.difference(self.lastSeenAt) >= _presenceWriteInterval) {
        self.lastSeenAt = now;
        await ParticipantRow.db.updateRow(
          session,
          self,
          columns: (table) => [table.lastSeenAt],
          transaction: transaction,
        );
      }
      final participants = await ParticipantRow.db.find(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        orderBy: (table) => table.isHost.desc(),
        transaction: transaction,
      );
      final swipes = await SwipeRow.db.find(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        transaction: transaction,
      );
      final placeIds = await _placeIds(
        session,
        sessionId: sessionId,
        transaction: transaction,
      );
      final talliesByPlace = _talliesByPlace(swipes);
      final participantViews = participants
          .map(SessionMapper.participant)
          .toList(growable: false);
      return SessionProgress(
        session: SessionMapper.session(room),
        participants: participantViews,
        selfParticipant: participantViews.singleWhere(
          (participant) => participant.participantId == self.participantId,
        ),
        resultTallies: [
          for (final placeId in placeIds)
            SessionResultTally(
              placeId: placeId,
              likeCount: talliesByPlace[placeId]?.likes ?? 0,
              voterCount: talliesByPlace[placeId]?.voters ?? 0,
              match: Consensus.isMatch(
                room.consensusRule,
                talliesByPlace[placeId] ?? const VoteTally(likes: 0, voters: 0),
              ),
            ),
        ],
        destinationChoices: room.mode == SessionMode.multiplayer
            ? DestinationChoices.summarize(
                room: room,
                participants: participants,
                swipes: swipes,
                deckPlaceIds: placeIds,
                userId: userId,
                now: now,
              )
            : null,
      );
    });
  }

  static Future<void> _expireIfAuthorized(
    Session session, {
    required String sessionId,
    required String userId,
    required DateTime now,
  }) async {
    await session.db.unsafeExecute(
      '''
UPDATE "hayer_session" AS room
SET "status" = @expired,
    "revision" = room."revision" + 1
WHERE room."sessionId" = @sessionId
  AND room."expiresAt" <= @now
  AND room."status" <> @expired
  AND EXISTS (
    SELECT 1
    FROM "hayer_participant" AS participant
    WHERE participant."sessionId" = room."sessionId"
      AND participant."userId" = @userId
  )
''',
      parameters: QueryParameters.named({
        'expired': SessionStatus.expired.toJson(),
        'sessionId': sessionId,
        'now': now,
        'userId': userId,
      }),
    );
  }

  static Future<List<String>> _placeIds(
    Session session, {
    required String sessionId,
    required Transaction transaction,
  }) async {
    final rows = await session.db.unsafeQuery(
      '''
SELECT "placeId"
FROM "hayer_session_place"
WHERE "sessionId" = @sessionId
ORDER BY "deckOrder"
''',
      transaction: transaction,
      parameters: QueryParameters.named({'sessionId': sessionId}),
    );
    return [
      for (final row in rows) row.toColumnMap()['placeId']! as String,
    ];
  }

  static Map<String, VoteTally> _talliesByPlace(List<SwipeRow> swipes) {
    final likes = <String, int>{};
    final voters = <String, int>{};
    for (final swipe in swipes) {
      voters.update(swipe.placeId, (count) => count + 1, ifAbsent: () => 1);
      if (swipe.liked) {
        likes.update(swipe.placeId, (count) => count + 1, ifAbsent: () => 1);
      }
    }
    return {
      for (final entry in voters.entries)
        entry.key: VoteTally(
          likes: likes[entry.key] ?? 0,
          voters: entry.value,
        ),
    };
  }
}
