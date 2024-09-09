import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class User {
  final String name;
  String id;
  List<String> friends;
  String? profileImageUrl;

  User({
    required this.name,
    required this.id,
    this.profileImageUrl
  })  : friends = [];

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        id = json['id'] as String,
        profileImageUrl = json['image_url'] as String?,
        friends = json['friends'] as List<String>;

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'image_url': profileImageUrl,
    'friends': friends
  };

  Future<String?> updateUserProfileImage (File profileImage) async {
    final storageRef = FirebaseStorage.instance.ref().child('user_images').child('$id/.jpg');
    await storageRef.putFile(profileImage!);
    final String imageUrl = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'image_url': imageUrl,
    });
  }
}

Future<User> getUser() async {
  final authenticatedUser = FirebaseAuth.instance.currentUser!;
  final userData = await FirebaseFirestore.instance.collection('users').doc(authenticatedUser.uid).get();
  return User.fromJson(userData.data()!);
}


