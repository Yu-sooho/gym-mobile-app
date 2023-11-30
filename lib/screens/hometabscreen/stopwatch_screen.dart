import 'package:flutter/material.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class StopWatchScreen extends StatefulWidget {
  StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  @override
  Widget build(BuildContext context) {
    return (TabAreaView(paddingTop: 24, children: []));
  }
}
