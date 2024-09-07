import 'package:flutter/material.dart';
import 'package:you_better/models/user.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({super.key, required this.friends});

  final List<User> friends;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: friends.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 15,
                      backgroundImage: friends[index].profileImageUrl != null
                          ? NetworkImage(friends[index].profileImageUrl!)
                          : null,
                      backgroundColor: friends[index].profileImageUrl != null
                          ? null
                          : Theme.of(context).primaryColor,
                      child: friends[index].profileImageUrl == null
                          ? Text(friends[index].name[0].toUpperCase())
                          : null
                  ),
                  const SizedBox(width: 10,),
                  Text(friends[index].name),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}