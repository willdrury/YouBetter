enum EnforcementType {
  monetary,
  social,
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