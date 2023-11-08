import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screen/package_screen.dart';

void main() {
  runApp(GetMaterialApp(home: Main()));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GymCalendar",
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen()
      },
    );
  }
}
