import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:you_better/data/test_challenges.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const uuid = Uuid();

class Challenge {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String enforcementId;
  final List<String> goals;
  final String userId;
  final String id;
  int progressPercentage = 0;
  String? description;

  Challenge ({
    required this.userId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.enforcementId,
    required this.goals,
    this.description,
  }) : id = uuid.v4();

  Challenge.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        userId = json['userId'] as String,
        startDate = DateTime.fromMicrosecondsSinceEpoch((json['startDate'] as Timestamp).microsecondsSinceEpoch),
        endDate = DateTime.fromMicrosecondsSinceEpoch((json['endDate'] as Timestamp).microsecondsSinceEpoch),
        goals = List<String>.from(json['goals'] as List<dynamic>),
        description = json['description'] as String?,
        enforcementId = json['enforcementId'] as String,
        id = json['id'] as String;

  Map<String, dynamic> toJson() => {
    'name': name,
    'userId': userId,
    'startDate': startDate,
    'endDate': endDate,
    'goals': goals,
    'description': description,
    'enforcementId': enforcementId,
    'id': id,
  };

  Future<String?> upload() async {
    try {
      await FirebaseFirestore.instance.collection('challenges').doc(id).set(toJson());
    } catch (error) {
      return error.toString();
    }
  }
}

final challengeProvider = StreamProvider<List<dynamic>>((ref) {
    var user = FirebaseAuth.instance.currentUser!;

    var docRef = FirebaseFirestore.instance.collection('challenges').where("userId", isEqualTo: user.uid);
    return docRef.snapshots().map((doc) => doc.docs);
  },
);
