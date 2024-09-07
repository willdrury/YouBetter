import 'package:flutter/material.dart';
import 'package:you_better/models/user.dart';
import 'package:you_better/widgets/friends_list.dart';

class FriendsScreen extends StatefulWidget {
  List<User> friends;
  FriendsScreen({super.key}) :
        friends = getFriends();

  @override
  State<StatefulWidget> createState() {
    return _FriendsScreenState();
  }
}

class _FriendsScreenState extends State<FriendsScreen> with SingleTickerProviderStateMixin {

  final List<Tab> _tabs = const [
    Tab(text: 'Posts', icon: Icon(Icons.public),),
    Tab(text: 'Friends', icon: Icon(Icons.group),),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
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
                const Text('first item'),
                FriendsList(friends: widget.friends),
              ]
          ),
        ),
      ],
    );
  }
}