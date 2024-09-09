import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Text('Nothing here... Try making friends first'),
        ),
      ),
    );
  }
}