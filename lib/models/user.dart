class User {
  final String name;
  final String id;
  final List<User> friends;
  String? profileImageUrl;

  User({
    required this.name, this.profileImageUrl
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
