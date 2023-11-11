import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screen/package_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(GetMaterialApp(home: Main()));
  firebaseInit();
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GymCalendar",
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/setting': (context) => SettingScreen()
      },
    );
  }
}

void firebaseInit() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
