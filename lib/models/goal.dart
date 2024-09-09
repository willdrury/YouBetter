import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:you_better/models/challenge.dart';
import 'package:you_better/models/user.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum GoalType {
  checkbox,
  minTime,
  maxTime,
}

GoalType getGoalTypeFromString(String value) {
  if (value == 'checkbox') {
    return GoalType.checkbox;
  } else if (value == 'minTime') {
    return GoalType.minTime;
  } else {
    return GoalType.maxTime;
  }
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

ReportingType getReportingTypeFromString(String value) {
  if (value == 'self') {
    return ReportingType.self;
  } else if (value == 'partner') {
    return ReportingType.partner;
  } else {
    return ReportingType.auto;
  }
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

class GoalEntry {
  final bool? isCompleted;
  final Duration? elapsedTime;
  final DateTime createdAt;
  final String id;

  GoalEntry({
    this.isCompleted,
    this.elapsedTime,
  }) : createdAt = DateTime.now(),
        id = uuid.v4();

  GoalEntry.fromJson(Map<String, dynamic> json)
      : isCompleted = json['isCompleted'] as bool,
        elapsedTime = json['elapsedTime'] as Duration,
        createdAt = json['createdAt'] as DateTime,
        id = json['id'] as String;

  Map<String, dynamic> toJson() => {
    'isCompleted': isCompleted,
    'elapsedTime': elapsedTime,
    'createdAt': createdAt,
    'id': id,
  };

  Future<String?> upload() async {
    try {
      await FirebaseFirestore.instance.collection('goalEntries').doc(id).set(toJson());
    } catch (error) {
      return error.toString();
    }
  }
}

class Goal {
  final String name;
  final String id;
  final String ownerId;
  final GoalType type;
  final ReportingType reportingType;
  bool completed = false; // May eventually want to be percent completed
  Duration? elapsedTime;
  Duration? maxTime;
  Duration? minTime;
  List<String> entries;

  Goal({
    required this.name,
    required this.ownerId,
    required this.type,
    required this.reportingType,
  }) :  id = uuid.v4(),
        entries = [];

  IconData get goalTypeIcon {
    return getGoalTypeIcon(type);
  }

  String get goalTypeLabel {
    return getGoalTypeLabel(type);
  }

  Goal.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        id = json['id'] as String,
        ownerId = json['ownerId'] as String,
        type = getGoalTypeFromString(['type'] as String),
        reportingType = getReportingTypeFromString(json['reportingType'] as String),
        completed = json['completed'] as bool,
        elapsedTime = json['elapsedTime'] as Duration,
        maxTime = json['maxTime'] as Duration,
        minTime = json['minTime'] as Duration,
        entries = json['entries'] as List<String>;

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'ownerId': ownerId,
    'type': type.name,
    'reportingType': reportingType.name,
    'completed': completed,
    'elapsedTime': elapsedTime,
    'maxTime': maxTime,
    'minTime': minTime,
    'entries': entries,
  };

  Future<String?> upload() async {
    try {
      await FirebaseFirestore.instance.collection('goals').doc(id).set(toJson());
    } catch (error) {
      return error.toString();
    }
  }
}

Future<List<Goal>> getGoalsFromChallenge(Challenge challenge) async {
  final snapshot = await FirebaseFirestore.instance.collection('goals').where("id", whereIn: challenge.goals).get();
  return snapshot.docs.map((goal) => Goal.fromJson(goal.data())).toList();
}