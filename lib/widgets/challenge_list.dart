import 'package:flutter/material.dart';
import 'package:you_better/models/challenge.dart';
import 'package:you_better/screens/new_challenge_screen.dart';
import 'package:you_better/widgets/challenge_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChallengeList extends ConsumerStatefulWidget {
  ChallengeList({super.key});

  @override
  ConsumerState<ChallengeList> createState() {
    return _ChallengeListState();
  }
}

class _ChallengeListState extends ConsumerState<ChallengeList> {

  void _navigateToCreateNewChallenge(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const NewChallengeScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = ref.watch(challengeProvider);

    return data.when(
      data: (challengeListData) {
        var challenges = challengeListData!.toList().map((challengeData) => Challenge.fromJson(challengeData.data() as Map<String, dynamic>)).toList();
        return Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () => _navigateToCreateNewChallenge(context),
                label: const Text('Create a new challenge', style: TextStyle(color: Colors.white),),
                icon: const Icon(Icons.edit, color: Colors.white,),
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                return ChallengeCard(challenge: challenges[index]);
              },
            )
          ],
        );
      },
      error: (error, stackTrace) {
        return const Text('error');
      },
      loading: () {
        return const Text('loading');
      },
    );
  }
}