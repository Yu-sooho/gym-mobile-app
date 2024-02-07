import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/localization/localization_controller.dart';

class ExerciseStateController extends GetxController {
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  RxList<Muscles> muscles = RxList<Muscles>.empty();
  RxList<Muscles> muscleList = RxList<Muscles>.empty();
  QueryDocumentSnapshot<Object?>? startAfterMuscle;
  bool endMuscleList = false;

  RxList<Exercise> exerciseList = RxList<Exercise>.empty();
  QueryDocumentSnapshot<Object?>? startAfter;
  bool endExerciseList = false;
  late RxList<String> exerciseSortMethod = [
    localizationController.localiztionComponentButton().latest,
    localizationController.localiztionComponentButton().oldest,
    localizationController.localiztionComponentButton().name,
  ].obs;
  RxInt exerciseSort = 0.obs;
}
