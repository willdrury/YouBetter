import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:you_better/models/enforcement.dart';

class SelectEnformcementScreen extends StatefulWidget {
  const SelectEnformcementScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SelectEnformcementScreenState();
  }
}

class _SelectEnformcementScreenState extends State<SelectEnformcementScreen> {
  EnforcementType? _selectedEnforcementType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Choose Enforcement', style: TextStyle(color: Colors.white),),
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