import 'package:flutter/cupertino.dart';
import 'package:you_better/models/friend.dart';
import 'package:you_better/friend_card.dart';

class FriendsScreen extends StatefulWidget {
  List<Friend> friends;
  FriendsScreen({super.key}) :
        friends = getFriends();

  @override
  State<StatefulWidget> createState() {
    return _FriendsScreenState();
  }
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: widget.friends.length,
            itemBuilder: (context, index) {
              return FriendCard(friend: widget.friends[index]);
            },
          )
        ],
      ),
    );
  }
}