import 'package:flutter/material.dart';
import 'package:you_better/models/goal.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(goal.name),
            Text('(${goal.reportingType.name})'),
          ],
        ),
      )
    );
  }
}