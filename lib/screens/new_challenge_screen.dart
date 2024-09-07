import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:you_better/models/goal.dart';
import 'package:you_better/screens/new_goal_screen.dart';
import 'package:flutter/services.dart';
import 'package:you_better/screens/select_enforcement_screen.dart';
import 'package:you_better/widgets/goal_card.dart';

final formatter = DateFormat('EEE, MMM d', 'en_US');

class NewChallengeScreen extends StatefulWidget {
  const NewChallengeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewChallengeScreenState();
  }
}

class _NewChallengeScreenState extends State<NewChallengeScreen> {

  DateTime? _selectedEndDate;
  DateTime? _selectedStartDate;
  String? _enteredName;
  String? _enteredDescription;
  List<Goal> _selectedGoals = [];
  final form = GlobalKey<FormState>();

  void _addGoal(Goal goal) {
    setState(() {
      _selectedGoals.add(goal);
    });
  }

  void _presentDatePicker() async {
    DateTime now = DateTime.now();
    DateTime maxEndDate = DateTime(now.year, now.month + 1, now.day);
    final pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: _selectedStartDate ?? now,
      lastDate: maxEndDate,
    );
    setState(() {
      if (pickedDateRange !=  null) {
        _selectedStartDate = pickedDateRange!.start;
        _selectedEndDate = pickedDateRange!.end;
      }
    });
  }

  void _submitForm(BuildContext context) {
    if (form.currentState!.validate() && _selectedEndDate != null && _selectedGoals.isNotEmpty) {
      form.currentState!.save();
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const SelectEnformcementScreen()));
    }
    if (_selectedGoals.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You must have at least one goal to continue')));
    }
  }

  void _navigateToNewGoalScreen (BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return NewGoalScreen(onSaveGoal: _addGoal,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('New Challenge', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {
              _submitForm(context);
            },
            child: Text('Next', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return ('Enter a valid name');
                  }
                },
                onSaved: (value) {
                  _enteredName = value;
                },
                onTapOutside: (pointer) {
                  FocusScope.of(context).unfocus();
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return ('Enter a valid description');
                  }
                },
                onSaved: (value) {
                  _enteredDescription = value;
                },
                onTapOutside: (pointer) {
                  FocusScope.of(context).unfocus();
                },
              ),
              GestureDetector(
                onTap: _presentDatePicker,
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Text(_selectedStartDate != null
                          ? '${formatter.format(_selectedStartDate!)} - ${formatter.format(_selectedEndDate!)}'
                          : 'Select a start and end date',
                        style: const TextStyle(color: Colors.black, fontSize: 16)),
                      const Spacer(),
                      const Icon(Icons.calendar_month),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 450,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_selectedGoals.isNotEmpty)
                        for (Goal goal in _selectedGoals)
                          SizedBox(
                            width: double.infinity,
                              child: GoalCard(goal: goal, onSaveGoal: _addGoal,)
                          ),
                      if (_selectedGoals.isEmpty)
                        const SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {
                          _navigateToNewGoalScreen(context);
                        },
                        child: const Icon(Icons.add),
                      ),
                      if (_selectedGoals.isEmpty)
                        Text(
                          'Create your first goal to get started!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ]
                  ),
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}