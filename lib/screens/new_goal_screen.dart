import 'package:flutter/material.dart';
import 'package:you_better/models/goal.dart';

class NewGoalScreen extends StatefulWidget {
  NewGoalScreen({super.key, required this.onSaveGoal});

  void Function(Goal goal) onSaveGoal;

  @override
  State<NewGoalScreen> createState() => _NewGoalScreenState();
}

class _NewGoalScreenState extends State<NewGoalScreen> {
  final form = GlobalKey<FormState>();

  GoalType _selectedGoalType = GoalType.checkbox;
  ReportingType _selectedReportingType = ReportingType.auto;
  String _enteredName = '';

  void _submitForm() {
    if (form.currentState!.validate()) {
      form.currentState!.save();
      widget.onSaveGoal(Goal(
          name: _enteredName,
          type: _selectedGoalType,
          reportingType: _selectedReportingType
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Goal', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: form,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return ('Enter a valid name');
                  }
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
                onTapOutside: (pointer) {
                  FocusScope.of(context).unfocus();
                },
              ),
              DropdownButtonFormField(
                value: _selectedGoalType,
                items: [
                  for (final type in GoalType.values)
                    DropdownMenuItem(
                        value: type,
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(type.name),
                          ],
                        )),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedGoalType = value!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                value: _selectedReportingType,
                items: [
                  for (final type in ReportingType.values)
                    DropdownMenuItem(
                        value: type,
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(type.name),
                          ],
                        )),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedReportingType = value!;
                  });
                },
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
