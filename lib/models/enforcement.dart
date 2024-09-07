import 'package:flutter/material.dart';

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

class EnforcementValue {

}

class Enforcement {
  final EnforcementType type;
  final Function onFailure;
  final Function onSuccess;
  final EnforcementValue value;

  Enforcement({
    required this.type,
    required this.onFailure,
    required this.onSuccess,
    required this.value,
  });
}