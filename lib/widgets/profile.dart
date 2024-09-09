import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_better/models/user.dart' as youBetter;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {

  late youBetter.User user;

  void _getUser() async {
    user = await youBetter.getUser();
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
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
            Text('Saved Payment Methods: ', style: Theme.of(context).textTheme.bodyLarge,),
            const SizedBox(height: 30,),
            Text('Connected Accounts: ', style: Theme.of(context).textTheme.bodyLarge,),
            const SizedBox(height: 30,),
            Text('Manage Account: ', style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}