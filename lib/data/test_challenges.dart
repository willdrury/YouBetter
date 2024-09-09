import 'package:you_better/models/challenge.dart';
import 'package:you_better/models/goal.dart';
import 'package:you_better/models/enforcement.dart';
import 'package:you_better/models/user.dart';

Challenge climbingChallenge = Challenge(
    userId: '3',
    name: 'Climb Harder',
    description: 'Start climbing harder. End goal is V8',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    enforcementId: '2',
    goals: ['1']
);

Challenge screenTimeChallenge = Challenge(
    userId: '2',
    name: 'Reduce Screen Time',
    description: 'Use my phone less',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    enforcementId: '1',
    goals: ['1']
);

Challenge runningChallenge = Challenge(
    userId: '1',
    name: 'Running',
    description: 'Run more every day',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    enforcementId: '1',
    goals: ['1']
);