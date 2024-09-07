import 'package:flutter/material.dart';
import 'package:you_better/models/challenge.dart';
import 'package:you_better/screens/new_challenge_screen.dart';
import 'package:you_better/widgets/challenge_card.dart';

class ChallengeList extends StatefulWidget {
  List<Challenge> challenges;
  ChallengeList({super.key, required this.challenges});

  @override
  State<StatefulWidget> createState() {
    return _ChallengeListState();
  }
}

class _ChallengeListState extends State<ChallengeList> {
  void _navigateToCreateNewChallenge(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const NewChallengeScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
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
          itemCount: widget.challenges.length,
          itemBuilder: (context, index) {
            return ChallengeCard(challenge: widget.challenges[index]);
          },
        )
      ],
    );
  }
}