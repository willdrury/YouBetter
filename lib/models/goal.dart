import 'package:flutter/material.dart';
import 'package:you_better/models/user.dart';

enum GoalType {
  checkbox,
  minTime,
  maxTime,
}

IconData getGoalTypeIcon(GoalType type) {
  switch (type) {
    case GoalType.checkbox :
      return Icons.check_box;
    case GoalType.minTime :
      return Icons.arrow_upward;
    case GoalType.maxTime :
      return Icons.arrow_downward;
  }
}

String getGoalTypeLabel(GoalType type) {
  switch (type) {
    case GoalType.checkbox :
      return 'Check box';
    case GoalType.minTime :
      return 'Build new habit';
    case GoalType.maxTime :
      return 'Limit bad habit';
  }
}

enum ReportingType {
  self,
  partner,
  auto,
}

IconData getReportingTypeIcon(ReportingType type) {
  switch (type) {
    case ReportingType.self :
      return Icons.person;
    case ReportingType.partner :
      return Icons.group;
    case ReportingType.auto :
      return Icons.settings;
  }
}

class Goal {
  final String name;
  final ReportingType reportingType;
  GoalType type;
  bool completed = false; // May eventually want to be percent completed
  Duration? elapsedTime;
  Duration? maxTime;
  Duration? minTime;
  User? owner;

  Goal({
    required this.name,
    required this.type,
    required this.reportingType,
  });

  IconData get goalTypeIcon {
    return getGoalTypeIcon(type);
  }

  String get goalTypeLabel {
    return getGoalTypeLabel(type);
  }
}