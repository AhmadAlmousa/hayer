import '../generated/protocol.dart';
import 'consensus.dart';

class DestinationChoices {
  static DestinationChoiceState summarize({
    required HayerSessionRow room,
    required List<ParticipantRow> participants,
    required List<SwipeRow> swipes,
    required List<String> deckPlaceIds,
    required String userId,
    required DateTime now,
  }) {
    final eligible = deckPlaceIds.where((placeId) {
      final votes = swipes.where((swipe) => swipe.placeId == placeId);
      return Consensus.isMatch(
        room.consensusRule,
        VoteTally(
          likes: votes.where((vote) => vote.liked).length,
          voters: votes.length,
        ),
      );
    }).toList();
    final counts = {for (final id in eligible) id: 0};
    final self = participants.singleWhere((person) => person.userId == userId);
    String? hostChoice;
    for (final person in participants) {
      final choice = person.destinationPlaceId;
      if (choice != null && counts.containsKey(choice)) {
        counts[choice] = counts[choice]! + 1;
        if (person.isHost) hostChoice = choice;
      }
    }
    final ready =
        room.status == SessionStatus.completed ||
        room.matchedPlaceId != null ||
        participants.every((person) => person.hasCompleted);
    final canChoose =
        room.mode == SessionMode.multiplayer &&
        room.status != SessionStatus.expired &&
        now.isBefore(room.expiresAt) &&
        ready;
    final chosen = counts.values.fold(0, (sum, count) => sum + count);
    final highest = counts.values.fold(
      0,
      (max, count) => count > max ? count : max,
    );
    final leaders = highest == 0
        ? <String>[]
        : counts.keys.where((id) => counts[id] == highest).toList();
    final hostBrokeTie = leaders.length > 1 && leaders.contains(hostChoice);
    // Likes, card rank and host authority never substitute for a choice.
    final winner = !ready
        ? null
        : leaders.length == 1
        ? leaders.single
        : hostBrokeTie
        ? hostChoice
        : null;
    return DestinationChoiceState(
      eligiblePlaceIds: eligible,
      counts: counts,
      myPlaceId: counts.containsKey(self.destinationPlaceId)
          ? self.destinationPlaceId
          : null,
      myRevision: self.destinationChoiceRevision,
      winnerPlaceId: winner,
      tiedPlaceIds: leaders.length > 1 ? leaders : [],
      chosenCount: chosen,
      participantCount: participants.length,
      canChoose: canChoose,
      isComplete: ready && chosen == participants.length && winner != null,
      hostBrokeTie: ready && hostBrokeTie,
    );
  }
}
