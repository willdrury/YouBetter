import 'package:flutter/material.dart';
import 'package:you_better/models/user.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundImage: user.profileImageUrl != null
                      ? NetworkImage(user.profileImageUrl!)
                      : null,
                  backgroundColor: user.profileImageUrl != null
                      ? null
                      : Theme.of(context).primaryColor,
                  child: user.profileImageUrl == null
                      ? Text(user.name[0].toUpperCase(), style: const TextStyle(fontSize: 40),)
                      : null
              ),
              const SizedBox(width: 20,),
              Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: Theme.of(context).textTheme.titleLarge,),
                      const SizedBox(height: 20,),
                      Text('Bio: ', style: Theme.of(context).textTheme.titleMedium,),
                    ],
                  )
              )
            ],
          ),
          const SizedBox(height: 20,),
          const Divider(),
          const SizedBox(height: 20,),
          const Text('Saved payment methods'),
          const Text('other settings...'),
        ],
      ),
    );
  }
}