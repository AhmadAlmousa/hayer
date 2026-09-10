import 'package:hayer_client/hayer_client.dart';

/// Rebuilds the per-place result rows from an immutable deck and fresh tallies.
///
/// `sessions.results` and `sessions.progress` count the same swipes over the
/// same deck, so a room that is still being voted on does not need the server
/// to resend fifty place snapshots to move three integers per place. [deck]
/// supplies the snapshots, [tallies] the current counts, and [previous] only
/// contributes rows this client already built for the same place.
///
/// The `rank` returned here is the order the tallies arrived in. The results
/// screen sorts what it shows by the reader's chosen order and numbers the
/// rows it draws, so no caller depends on server ranking; a caller that ever
/// does must read it from `sessions.results` instead.
List<SessionResult> applyResultTallies({
  required List<PlaceSnapshot> deck,
  required List<SessionResultTally> tallies,
  List<SessionResult> previous = const [],
}) {
  final places = {for (final place in deck) place.placeId: place};
  final known = {for (final result in previous) result.place.placeId: result};
  final rebuilt = <SessionResult>[];
  for (final tally in tallies) {
    final place = known[tally.placeId]?.place ?? places[tally.placeId];
    // A tally for a place outside this deck cannot be drawn, and dropping it
    // is safer than inventing a snapshot for it.
    if (place == null) continue;
    rebuilt.add(
      SessionResult(
        place: place,
        likeCount: tally.likeCount,
        voterCount: tally.voterCount,
        match: tally.match,
        rank: rebuilt.length + 1,
      ),
    );
  }
  return rebuilt;
}
