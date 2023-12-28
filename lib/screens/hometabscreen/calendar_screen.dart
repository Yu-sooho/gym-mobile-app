import 'package:flutter/material.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return (TabAreaView(paddingTop: 24, children: [HomeCalendar()]));
  }
}
