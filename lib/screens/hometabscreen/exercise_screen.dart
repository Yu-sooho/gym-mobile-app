import 'package:flutter/material.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return (TabAreaView(paddingTop: 24, children: []));
  }
}
