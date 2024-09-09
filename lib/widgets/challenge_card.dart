import 'package:flutter/material.dart';
import 'package:you_better/models/challenge.dart';
import 'package:you_better/screens/challenge_details.dart';

class ChallengeCard extends StatefulWidget {
  bool isOpen;
  Challenge challenge;

  ChallengeCard({
    super.key,
    this.isOpen = false,
    required this.challenge,
  });

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {

  void _navigateToChallengeDetails(BuildContext context, Challenge challenge) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => ChallengeDetails(challenge: challenge!))
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToChallengeDetails(context, widget.challenge);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(widget.challenge.name),
              subtitle: Text(
                '${widget.challenge.endDate.day - DateTime.now().day} day(s) remaining',
              ),
            ),
          ],
        ),
      ),
    );
  }
}