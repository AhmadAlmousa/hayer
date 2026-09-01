import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/sessions/consensus.dart';
import 'package:test/test.dart';

void main() {
  test('zero votes never match', () {
    expect(
      Consensus.isMatch(
        ConsensusRule.unanimous,
        const VoteTally(likes: 0, voters: 0),
      ),
      isFalse,
    );
  });

  test('majority is strict and unanimous requires every voter', () {
    expect(
      Consensus.isMatch(
        ConsensusRule.majority,
        const VoteTally(likes: 2, voters: 3),
      ),
      isTrue,
    );
    expect(
      Consensus.isMatch(
        ConsensusRule.majority,
        const VoteTally(likes: 1, voters: 2),
      ),
      isFalse,
    );
    expect(
      Consensus.isMatch(
        ConsensusRule.unanimous,
        const VoteTally(likes: 2, voters: 3),
      ),
      isFalse,
    );
  });
}
