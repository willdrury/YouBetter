
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

class GoalValue {

}

class Goal {
  final String name;
  final ReportingType reportingType;
  GoalType type;
  bool completed = false; // May eventually want to be percent completed
  GoalValue? value;
  GoalValue? maxValue;
  GoalValue? minValue;

  Goal({
    required this.name,
    required this.type,
    required this.reportingType,
  });
}