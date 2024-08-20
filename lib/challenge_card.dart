import 'package:flutter/material.dart';
import 'package:you_better/models/challenge.dart';

class ChallengeCard extends StatefulWidget {
  bool isOpen;
  Challenge challenge;

  ChallengeCard({
    super.key,
    this.isOpen = false,
    required this.challenge,
  });

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  @override
  void initState() {
    super.initState();
  }

  void _toggle() {
    setState(() {
      widget.isOpen = !widget.isOpen;
    });
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
            title: Text(widget.challenge.name),
            subtitle: Text(
              '${widget.challenge.endDate.day - DateTime.now().day} day(s) remaining',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.challenge.description ?? '',
            ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Perform some action
                },
                child: const Text('View'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}