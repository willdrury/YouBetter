import 'package:flutter/material.dart';
import 'package:you_better/models/friend.dart';

class FriendCard extends StatefulWidget {
  Friend friend;
  FriendCard({super.key, required this.friend});

  @override
  State<FriendCard> createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(widget.friend.name),
          ),
        ],
      ),
    );
  }
}