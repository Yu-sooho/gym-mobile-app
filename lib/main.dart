import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screens/package_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'firebase_options.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await firebaseLoginCheck();
  await firebaseMessagingInit();
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
        '/profile': (context) => ProfileScreen(),
        '/profile_edit': (context) => ProfileEditScreen(),
        '/setting': (context) => SettingScreen(),
        '/theme': (context) => ThemeScreen(),
        '/inquriy': (context) => InquiryScreen(),
      },
    );
  }
}

Future<bool> firebaseLoginCheck() async {
  final FirebaseAuthController controller = Get.put(FirebaseAuthController());
  controller.addAuthEventListener();
  return true;
}

Future<bool> firebaseMessagingInit() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  return true;
}
