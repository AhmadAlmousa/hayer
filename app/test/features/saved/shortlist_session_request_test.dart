import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/domain/saved_place.dart';
import 'package:hayer_app/domain/shortlist_draft.dart';
import 'package:hayer_app/features/saved/shortlist_session_request.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test('sends saved identities without private notes or cached snapshots', () {
    final draft = ShortlistDraft.fromSavedPlaces([
      _saved('place-a', note: 'Private anniversary plan'),
      _saved('place-b', note: 'Do not upload this note'),
    ]);

    final request = buildShortlistSessionRequest(
      draft: draft,
      mode: SessionMode.multiplayer,
      displayName: '  Ahmad  ',
      consensusRule: ConsensusRule.unanimous,
      matchingTiming: MatchingTiming.instant,
      includeFreshIdeas: true,
    );

    expect(request.shortlistPlaceIds, ['place-a', 'place-b']);
    expect(request.freshDiscoveryCount, 5);
    expect(request.deckSize, 10);
    expect(request.displayName, 'Ahmad');
    final encoded = jsonEncode(request.toJson());
    expect(encoded, isNot(contains('Private anniversary plan')));
    expect(encoded, isNot(contains('Do not upload this note')));
    expect(encoded, isNot(contains('Cached Place')));
  });

  test('saved-only solo request uses the compatibility deck bucket', () {
    final draft = ShortlistDraft.fromSavedPlaces([
      _saved('place-a'),
      _saved('place-b'),
    ]);

    final request = buildShortlistSessionRequest(
      draft: draft,
      mode: SessionMode.solo,
      displayName: '',
      consensusRule: ConsensusRule.majority,
      matchingTiming: MatchingTiming.afterDeck,
      includeFreshIdeas: false,
    );

    expect(request.freshDiscoveryCount, 0);
    expect(request.deckSize, 10);
    expect(request.displayName, 'Solo');
    expect(
      shortlistResponsePreservesSelection(request, [
        _saved('place-a').place,
        _saved('place-b').place,
      ]),
      isTrue,
    );
    expect(
      shortlistResponsePreservesSelection(request, [
        _saved('place-b').place,
        _saved('place-a').place,
      ]),
      isFalse,
    );
  });
}

SavedPlace _saved(String id, {String? note}) => SavedPlace(
  place: PlaceSnapshot(
    placeId: id,
    name: 'Cached Place $id',
    categoryIds: const ['restaurant'],
    hours: const [],
    distanceMeters: 100,
    latitude: id == 'place-a' ? 24.7136 : 24.7140,
    longitude: 46.6753,
    photoUrls: const ['https://example.invalid/private-cache.jpg'],
    attributions: const ['Provider'],
    sourceCheckedAt: DateTime.utc(2026, 9, 8),
    isStale: false,
  ),
  collection: SavedPlaceCollection.wantToTry,
  note: note,
  savedAt: DateTime.utc(2026, 9, 8),
  updatedAt: DateTime.utc(2026, 9, 8),
);
