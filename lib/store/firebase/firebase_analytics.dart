///clickEvent name:eventName, parameters:{screenName , buttonName}

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class FirebaseAnalyticsController extends GetxController {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  clickEvent({
    required String name,
    required Map<String, Object?>? parameters,
  }) async {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: name,
        parameters: parameters,
      );
      return true;
    } catch (error) {
      print('firebase_analytics clickEvent error: $error');
      return false;
    }
  }
}
