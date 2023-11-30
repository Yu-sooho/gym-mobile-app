import 'package:get/get.dart';
import 'localization/localization_controller.dart';
import 'app_state_controller.dart';
import 'auth_state_controller.dart';
import 'routine_state_controller.dart';
import 'exercise_state_controller.dart';
import 'firebase/package_firebase.dart';
import 'styles/color_controller.dart';
import 'styles/font_controller.dart';

class Stores extends GetxController {
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final AuthStateController authStateController =
      Get.put(AuthStateController());
  final RoutineStateController routineStateController =
      Get.put(RoutineStateController());
  final ExerciseStateController exerciseStateController =
      Get.put(ExerciseStateController());
  final AppStateController appStateController = Get.put(AppStateController());
  final CustomFontController fontController = Get.put(CustomFontController());
  final CustomColorController colorController =
      Get.put(CustomColorController());

  final FirebaseAnalyticsController firebaseAnalyticsController =
      Get.put(FirebaseAnalyticsController());
  final FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());
  final FirebaseStorageController firebaseStorageController =
      Get.put(FirebaseStorageController());
  final FirebaseController firebaseController = Get.put(FirebaseController());
}
