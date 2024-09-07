import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:you_better/models/challenge.dart';


class ChallengeProvider extends StateNotifier<List<Challenge>> {
  ChallengeProvider() : super([]);

  void addChallenge(Challenge challenge) {
    state = [...state, challenge];
  }
}

final challengeProvider = StateNotifierProvider<ChallengeProvider, List<Challenge>>((ref) {
  return ChallengeProvider();
});