import '../generated/protocol.dart';

class SessionMapper {
  const SessionMapper._();

  static SessionView session(HayerSessionRow row) => SessionView(
    sessionId: row.sessionId,
    code: row.code,
    mode: row.mode,
    categoryId: row.categoryId,
    subcategoryIds: row.subcategoryIds,
    priceLevel: row.priceLevel,
    anchorLatitude: row.anchorLatitude,
    anchorLongitude: row.anchorLongitude,
    anchorAddress: row.anchorAddress,
    countryCode: row.countryCode,
    radiusMeters: row.radiusMeters,
    deckSizeRequested: row.deckSizeRequested,
    deckSizeActual: row.deckSizeActual,
    consensusRule: row.consensusRule,
    matchingTiming: row.matchingTiming,
    status: row.status,
    matchedPlaceId: row.matchedPlaceId,
    revision: row.revision,
    createdAt: row.createdAt,
    expiresAt: row.expiresAt,
    freshnessWarning: row.freshnessWarning,
  );

  static ParticipantView participant(ParticipantRow row) => ParticipantView(
    participantId: row.participantId,
    displayName: row.displayName,
    isHost: row.isHost,
    currentIndex: row.currentIndex,
    hasCompleted: row.hasCompleted,
    lastSeenAt: row.lastSeenAt,
  );
}
