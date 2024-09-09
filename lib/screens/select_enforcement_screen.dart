import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:you_better/models/challenge.dart';
import 'package:you_better/models/enforcement.dart';
import 'package:you_better/models/goal.dart';

class SelectEnforcementScreen extends ConsumerStatefulWidget {
  SelectEnforcementScreen({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.challengeName,
    required this.goals,
    this.challengeDescription,
  });

  final DateTime startDate;
  final DateTime endDate;
  final String challengeName;
  final List<Goal> goals;
  String? challengeDescription;

  @override
  ConsumerState<SelectEnforcementScreen> createState() {
    return _SelectEnforcementScreenState();
  }
}

class _SelectEnforcementScreenState extends ConsumerState<SelectEnforcementScreen> {
  EnforcementType? _selectedEnforcementType;

  void _submitChallenge() async {
    try {
      if (_selectedEnforcementType == null) {
        return;
      }

      String? error;

      Enforcement newEnforcement = Enforcement(
          type: _selectedEnforcementType!,
      );

      error = await newEnforcement.upload();
      if (error != null) {
        throw Exception(error);
      }

      for (Goal goal in widget.goals) {
        error = await goal.upload();
        if (error != null) {
          throw Exception(error);
        }
      }

      Challenge challenge = Challenge(
          userId: FirebaseAuth.instance.currentUser!.uid,
          name: widget.challengeName,
          description: widget.challengeDescription,
          startDate: widget.startDate,
          endDate: widget.endDate,
          enforcementId: newEnforcement.id!,
          goals: widget.goals.map((goal) => goal.id!).toList()
      );

      error = await challenge.upload();
      if (error != null) {
        throw Exception(error);
      }

      Navigator.of(context).popUntil((route) => route.isFirst);

    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Choose Enforcement', style: TextStyle(color: Colors.white),),
        actions: [
          TextButton(
            onPressed: _submitChallenge,
            child: Text('Next', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButton<EnforcementType>(
              value: _selectedEnforcementType,
              isExpanded: true,
              hint: const Text('Select an enforcement type'),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              focusColor: Colors.pink,
              items: EnforcementType.values.map<DropdownMenuItem<EnforcementType>>((enforcementType) {
                return DropdownMenuItem(
                    value: enforcementType,
                    child: Row(
                      children: [
                        Icon(getEnforcementTypeIcon(enforcementType)),
                        const SizedBox(width: 10,),
                        Text(enforcementType.name[0].toUpperCase() + enforcementType.name.substring(1)),
                      ],
                    ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedEnforcementType = value!;
                });
              }
            ),
            const SizedBox(height: 20,),
            if (_selectedEnforcementType !=  null && _selectedEnforcementType == EnforcementType.monetary)
              const Text('Set up payment'),
            if (_selectedEnforcementType !=  null && _selectedEnforcementType == EnforcementType.social)
              const Text('Set up social repercussions'),
          ],
        ),
      ),
    );
  }
}