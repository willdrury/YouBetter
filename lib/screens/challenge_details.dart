import 'package:flutter/material.dart';
import 'package:you_better/models/challenge.dart';

class ChallengeDetails extends StatelessWidget {

  const ChallengeDetails({super.key, required this.challenge});
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(challenge.name),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(challenge.description == null ? 'No description set' : challenge.description!),
          ],
        ),
      ),
    );
  }
}