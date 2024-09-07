class User {
  final String name;
  final String id;
  final List<User> friends;

  User({
    required this.name,
  })  : id = '1',
        friends = [];
}

List<User> getFriends() {
  return [
    User(name: 'Jack'),
    User(name: 'James'),
    User(name: 'Jake'),
    User(name: 'Jacob'),
    User(name: 'Jimmy'),
  ];
}
