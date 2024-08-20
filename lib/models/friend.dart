class Friend {
  final String name;

  Friend ({
    required this.name,
  });
}

List<Friend> getFriends() {
  return [
    Friend(name: 'Jack'),
    Friend(name: 'James'),
    Friend(name: 'Jake'),
    Friend(name: 'Jacob'),
    Friend(name: 'Jimmy'),
  ];
}