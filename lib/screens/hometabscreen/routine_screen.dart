import 'package:flutter/material.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineScreen extends StatefulWidget {
  RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return (TabAreaView(paddingTop: 24, children: [RoutineAddItem()]));
  }
}
