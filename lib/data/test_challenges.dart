import 'package:you_better/models/challenge.dart';
import 'package:you_better/models/goal.dart';
import 'package:you_better/models/enforcement.dart';

Challenge climbingChallenge = Challenge(
    name: 'Climb Harder',
    description: 'Start climbing harder. End goal is V8',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    enforcement: Enforcement(
      type: EnforcementType.monetary,
      onFailure: () => {},
      onSuccess: () => {},
      value: EnforcementValue(),
    ),
    goals: [
      Goal(
          name: 'Show up at the gym',
          type: GoalType.checkbox,
          reportingType: ReportingType.partner
      )
    ]
);

Challenge screenTimeChallenge = Challenge(
    name: 'Reduce Screen Time',
    description: 'Use my phone less',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    enforcement: Enforcement(
      type: EnforcementType.social,
      onFailure: () => {},
      onSuccess: () => {},
      value: EnforcementValue(),
    ),
    goals: [
      Goal(
          name: 'Reduce Chrome usage',
          type: GoalType.maxTime,
          reportingType: ReportingType.auto
      ),
      Goal(
          name: 'Increase Reading usage',
          type: GoalType.minTime,
          reportingType: ReportingType.auto
      )
    ]
);

Challenge runningChallenge = Challenge(
    name: 'Running',
    description: 'Run more every day',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    enforcement: Enforcement(
      type: EnforcementType.monetary,
      onFailure: () => {},
      onSuccess: () => {},
      value: EnforcementValue(),
    ),
    goals: [
      Goal(
          name: 'Run 10 miles this week',
          type: GoalType.minTime,
          reportingType: ReportingType.auto
      ),
    ]
);