
import 'package:you_better/models/user.dart';

enum GoalType {
  checkbox,
  minTime,
  maxTime,
}

enum ReportingType {
  self,
  partner,
  auto,
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
}