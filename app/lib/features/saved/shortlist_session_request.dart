import 'package:hayer_client/hayer_client.dart';

import '../../domain/shortlist_draft.dart';

CreateSessionRequest buildShortlistSessionRequest({
  required ShortlistDraft draft,
  required SessionMode mode,
  required String displayName,
  required ConsensusRule consensusRule,
  required MatchingTiming matchingTiming,
  required bool includeFreshIdeas,
}) {
  final categoryId = draft.categoryId;
  if (categoryId == null) {
    throw ArgumentError.value(
      draft,
      'draft',
      'The shortlist needs a supported category.',
    );
  }
  final freshDiscoveryCount = includeFreshIdeas ? 5 : 0;
  final requestedCount = draft.places.length + freshDiscoveryCount;
  return CreateSessionRequest(
    mode: mode,
    categoryId: categoryId,
    subcategoryIds: const [],
    anchorLatitude: draft.anchorLatitude,
    anchorLongitude: draft.anchorLongitude,
    radiusMeters: draft.radiusMeters,
    deckSize: supportedShortlistDeckSize(requestedCount),
    displayName: mode == SessionMode.multiplayer ? displayName.trim() : 'Solo',
    consensusRule: consensusRule,
    matchingTiming: matchingTiming,
    shortlistPlaceIds: [
      for (final saved in draft.places) saved.place.placeId,
    ],
    freshDiscoveryCount: freshDiscoveryCount,
  );
}

int supportedShortlistDeckSize(int count) => switch (count) {
  <= 10 => 10,
  <= 20 => 20,
  <= 30 => 30,
  <= 40 => 40,
  _ => 50,
};

bool shortlistResponsePreservesSelection(
  CreateSessionRequest request,
  List<PlaceSnapshot> deck,
) {
  final selectedIds = request.shortlistPlaceIds ?? const <String>[];
  if (deck.length < selectedIds.length) return false;
  for (var index = 0; index < selectedIds.length; index++) {
    if (deck[index].placeId != selectedIds[index]) return false;
  }
  return true;
}
