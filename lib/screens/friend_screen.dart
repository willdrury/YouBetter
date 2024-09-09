import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:you_better/models/user.dart';
import 'package:you_better/widgets/friends_list.dart';
import 'package:you_better/widgets/posts_list.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FriendsScreenState();
  }
}

class _FriendsScreenState extends State<FriendsScreen> with SingleTickerProviderStateMixin {

  late List<User> friends;

  final List<Tab> _tabs = const [
    Tab(text: 'Posts', icon: Icon(Icons.public),),
    Tab(text: 'Friends', icon: Icon(Icons.group),),
  ];

  late TabController _tabController;

  void _getFriends() async {
    final User currentUser = await getUser();
    final db = FirebaseFirestore.instance;
    final snapshot = await db.collection("users").where("id", whereIn: currentUser.friends).get();
    if (snapshot.docs.isNotEmpty) {
      friends = snapshot.docs.map((item) => User.fromJson(item.data())).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _getFriends();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 60,
          child: TabBar(
            controller: _tabController,
            tabs: _tabs,
          ),
        ),
        Container(
          height: 650,
          child: TabBarView(
              controller: _tabController,
              children: [
                const PostsList(),
                FriendsList(friends: friends),
              ]
          ),
        ),
      ],
    );
  }
}