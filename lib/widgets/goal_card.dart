import 'package:flutter/material.dart';
import 'package:you_better/models/goal.dart';
import 'package:you_better/screens/new_goal_screen.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({super.key, required this.goal, required this.onSaveGoal});

  final Goal goal;
  final Function(Goal) onSaveGoal;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, right: 10),
            width: double.infinity,
              color: Colors.black,
              child: Row(
                children: [
                  Text(
                    goal.name,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => NewGoalScreen(onSaveGoal: onSaveGoal, goal: goal,)));
                      },
                      icon: const Icon(Icons.edit, color: Colors.white, size: 20,),
                  ),
                ],
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Type: ${getGoalTypeLabel(goal.type)}'),
                    const Spacer(),
                    Icon(getGoalTypeIcon(goal.type)),
                  ],
                ),
                Row(
                  children: [
                  Text('Reporting: ${goal.reportingType.name}'),
                  const Spacer(),
                  Icon(getReportingTypeIcon(goal.reportingType)),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}