import '../generated/protocol.dart';

class VoteTally {
  const VoteTally({required this.likes, required this.voters});
  final int likes;
  final int voters;
}

class Consensus {
  const Consensus._();

  static bool isMatch(ConsensusRule rule, VoteTally tally) {
    if (tally.voters <= 0 || tally.likes <= 0) return false;
    return switch (rule) {
      ConsensusRule.majority => tally.likes > tally.voters / 2,
      ConsensusRule.unanimous => tally.likes == tally.voters,
    };
  }
}
