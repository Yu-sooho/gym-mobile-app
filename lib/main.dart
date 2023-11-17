import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screens/package_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'firebase_options.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await firebaseLoginCheck();
  KakaoSdk.init(nativeAppKey: 'd3c9e4923a1864904073b797a2de34d1');
  runApp(GetMaterialApp(home: Main()));
}

class Main extends StatelessWidget {
  final FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());
  final AppStateController appStateController = Get.put(AppStateController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GymCalendar",
      initialRoute:
          firebaseAuthController.currentUser != null ? '/home' : '/login',
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
