import 'package:you_better/models/enforcement.dart';
import 'package:you_better/models/goal.dart';
import 'package:you_better/data/test_challenges.dart';

class Challenge {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final Enforcement enforcement;
  final List<Goal> goals;
  int progressPercentage = 0;
  String? description;

  Challenge ({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.enforcement,
    required this.goals,
    this.description,
  });
}

// TODO: query local storage or db for active challenges
List<Challenge> getActiveChallenges() {
  return [
    climbingChallenge,
    screenTimeChallenge,
    runningChallenge,
  ];
}

//TODO: take input
Challenge createChallenge() {
  return runningChallenge;
}