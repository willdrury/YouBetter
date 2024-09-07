import 'package:flutter/material.dart';
import 'package:you_better/models/goal.dart';

class NewGoalScreen extends StatefulWidget {
  NewGoalScreen({super.key, required this.onSaveGoal, this.goal});

  void Function(Goal goal) onSaveGoal;
  Goal? goal;

  @override
  State<NewGoalScreen> createState() => _NewGoalScreenState();
}

class _NewGoalScreenState extends State<NewGoalScreen> {
  final form = GlobalKey<FormState>();

  late GoalType _selectedGoalType;
  late ReportingType _selectedReportingType;
  late String _enteredName = '';

  @override
  void initState() {
    super.initState();
    _enteredName = widget.goal != null
        ? widget.goal!.name
        : '';
    _selectedGoalType = widget.goal != null
        ? widget.goal!.type
        : GoalType.checkbox;
    _selectedReportingType = widget.goal != null
        ? widget.goal!.reportingType
        : ReportingType.auto;
  }

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
                            Icon(getGoalTypeIcon(type)),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(getGoalTypeLabel(type)),
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
                            Icon(getReportingTypeIcon(type)),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(type.name[0].toUpperCase() + type.name.substring(1)),
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
              if (_selectedReportingType == ReportingType.partner)
                const Text('TODO Select partner from your friends'),
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
