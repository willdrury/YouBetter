import 'package:flutter/cupertino.dart';
import 'package:you_better/models/challenge.dart';
import 'package:you_better/challenge_card.dart';

class ChallengeList extends StatefulWidget {
  List<Challenge> challenges;
  ChallengeList({super.key, required this.challenges});

  @override
  State<StatefulWidget> createState() {
    return _ChallengeListState();
  }
}

class _ChallengeListState extends State<ChallengeList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
      ),
    );
  }
}