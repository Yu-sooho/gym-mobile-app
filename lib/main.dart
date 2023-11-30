import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  await themeCheck();
  await firebaseLoginCheck();
  await firebaseMessagingInit();
  KakaoSdk.init(nativeAppKey: 'd3c9e4923a1864904073b797a2de34d1');
  runApp(GetMaterialApp(home: Main()));
}

class Main extends StatelessWidget {
  final Stores stores = Get.put(Stores());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: "GymCalendar",
      initialRoute:
          stores.firebaseAuthController.uid != null ? '/home' : '/login',
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

Future<bool> themeCheck() async {
  final storage = FlutterSecureStorage();

  final Stores stores = Get.put(Stores());

  String? colorType = await storage.read(key: 'colorType');
  String? fontType = await storage.read(key: 'fontType');
  String? language = await storage.read(key: 'language');

  if (language != null) {
    stores.localizationController.changeLanguage(int.parse(language));
  } else {
    stores.localizationController.changeLanguage(1);
  }
  if (fontType != null) {
    stores.fontController.changeFontMode(int.parse(fontType));
  } else {
    stores.fontController.changeFontMode(1);
  }
  if (colorType != null) {
    stores.colorController.changeColorMode(int.parse(colorType));
  } else {
    stores.colorController.changeColorMode(1);
  }

  return true;
}

Future<bool> firebaseLoginCheck() async {
  final Stores stores = Get.put(Stores());
  stores.firebaseAuthController.addAuthEventListener();
  return true;
}

Future<bool> firebaseMessagingInit() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  return true;
}
