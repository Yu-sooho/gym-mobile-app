import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screen/package_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_calendar/store/package_stores.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await firebaseLoginCheck();
  runApp(GetMaterialApp(home: Main()));
}

class Main extends StatelessWidget {
  final FirebaseAuthController controller = Get.put(FirebaseAuthController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GymCalendar",
      initialRoute: controller.authState != null ? '/home' : '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/setting': (context) => SettingScreen()
      },
    );
  }
}

Future<bool> firebaseLoginCheck() async {
  final FirebaseAuthController controller = Get.put(FirebaseAuthController());
  controller.addAuthEventListener();
  return true;
}
