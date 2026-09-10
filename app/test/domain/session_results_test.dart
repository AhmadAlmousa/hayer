import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/domain/session_results.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test('tallies update the rows without re-fetching the deck', () async {
    // Behavior under test: results are a join of an immutable deck and the
    // votes cast so far. Only the votes change, so a refresh must be able to
    // move the counts without the server resending every place snapshot.
    // Arrange
    final deck = [_place(0), _place(1)];
    final previous = [
      _result(_place(0), likes: 0, voters: 0, match: false),
      _result(_place(1), likes: 0, voters: 0, match: false),
    ];

    // Act
    final rebuilt = applyResultTallies(
      deck: deck,
      previous: previous,
      tallies: [
        _tally('place-0', likes: 3, voters: 4, match: true),
        _tally('place-1', likes: 1, voters: 4, match: false),
      ],
    );

    // Assert
    expect(rebuilt.map((row) => row.place.name), ['Place 0', 'Place 1']);
    expect(rebuilt.first.likeCount, 3);
    expect(rebuilt.first.voterCount, 4);
    expect(rebuilt.first.match, isTrue);
    expect(rebuilt.last.match, isFalse);
  });

  test('a place this client has never held is not invented', () async {
    // Behavior under test: a tally that names a place outside the deck cannot
    // be drawn, and guessing a snapshot for it would put a made-up place in
    // front of a user.
    // Arrange & Act
    final rebuilt = applyResultTallies(
      deck: [_place(0)],
      tallies: [
        _tally('place-0', likes: 1, voters: 1, match: true),
        _tally('place-9', likes: 5, voters: 5, match: true),
      ],
    );

    // Assert
    expect(rebuilt.map((row) => row.place.placeId), ['place-0']);
  });
}

PlaceSnapshot _place(int index) => PlaceSnapshot(
  placeId: 'place-$index',
  name: 'Place $index',
  categoryIds: const ['restaurant'],
  hours: const [],
  distanceMeters: 1000 + index,
  latitude: 24.7,
  longitude: 46.6,
  photoUrls: const [],
  attributions: const ['Google Maps'],
  sourceCheckedAt: DateTime.utc(2026),
  isStale: false,
  isOpen: true,
);

SessionResult _result(
  PlaceSnapshot place, {
  required int likes,
  required int voters,
  required bool match,
}) => SessionResult(
  place: place,
  likeCount: likes,
  voterCount: voters,
  match: match,
  rank: 1,
);

SessionResultTally _tally(
  String placeId, {
  required int likes,
  required int voters,
  required bool match,
}) => SessionResultTally(
  placeId: placeId,
  likeCount: likes,
  voterCount: voters,
  match: match,
);
