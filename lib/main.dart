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
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: "GymCalendar",
      navigatorKey: navigatorKey,
      navigatorObservers: [CommonRouteObserver()],
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
        '/exerciseAdd': (context) => ExerciseAddScreen(),
        '/routineAdd': (context) => RoutineAddScreen(),
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
  String? fontSize = await storage.read(key: 'fontSize');

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
  if (fontSize != null) {
    stores.appStateController.changeFontSize(double.parse(fontSize));
  } else {
    stores.appStateController.changeFontSize(0.0);
  }

  return true;
}

Future<bool> firebaseLoginCheck() async {
  final Stores stores = Get.put(Stores());
  stores.firebaseAuthController.addAuthEventListener();
  return true;
}

Future<bool> firebaseMessagingInit() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  return true;
}

class CommonRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _saveScreenView(
      {PageRoute<dynamic>? oldRoute,
      PageRoute<dynamic>? newRoute,
      String? routeType}) {
    debugPrint(
        '[track] screen old : ${oldRoute?.settings.name}, new : ${newRoute?.settings.name}');
  }

  PageRoute? checkPageRoute(Route<dynamic>? route) {
    return (route is PageRoute) ? route : null;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _saveScreenView(
      newRoute: checkPageRoute(route),
      oldRoute: checkPageRoute(previousRoute),
      routeType: 'push',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _saveScreenView(
      newRoute: checkPageRoute(newRoute),
      oldRoute: checkPageRoute(oldRoute),
      routeType: 'replace',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _saveScreenView(
      newRoute: checkPageRoute(previousRoute),
      oldRoute: checkPageRoute(route),
      routeType: 'pop',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _saveScreenView(
      newRoute: checkPageRoute(route),
      oldRoute: checkPageRoute(previousRoute),
      routeType: 'remove',
    );
  }
}
