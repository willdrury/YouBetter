import 'package:flutter/cupertino.dart';

class StatsScreen extends StatefulWidget {

  const StatsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StatsScreenState();
  }
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Uh... You\'re doing great!'),
        ],
      ),
    );
  }
}