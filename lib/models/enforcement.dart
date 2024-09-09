import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum EnforcementType {
  monetary,
  social,
}

IconData getEnforcementTypeIcon(EnforcementType type) {
  switch (type) {
    case EnforcementType.monetary :
      return Icons.money;
    case EnforcementType.social :
      return Icons.groups;
  }
}

EnforcementType getEnforcementTypeFromString(String label) {
  if (label == 'monetary') {
    return EnforcementType.monetary;
  }
  else {
    return EnforcementType.social;
  }
}

class EnforcementValue {

}

class Enforcement {
  final EnforcementType type;
  final String id;
  double? moneyValue; // TODO: allow for other enforcement values
  // final Function onFailure;
  // final Function onSuccess;

  Enforcement({
    required this.type,
    this.moneyValue,
    // required this.onFailure,
    // required this.onSuccess,
  }) : id = uuid.v4();

  Enforcement.fromJson(Map<String, dynamic> json)
      : type = getEnforcementTypeFromString(['type'] as String),
        moneyValue = json['moneyValue'] as double,
        id = json['id'] as String;

  Map<String, dynamic> toJson() => {
      'type': type.toString(),
      'moneyValue': moneyValue,
      'id': id,
  };

  Future<String?> upload() async {
    try {
      await FirebaseFirestore.instance.collection('enforcements').doc(id).set(toJson());
    } catch (error) {
      return error.toString();
    }
  }
}