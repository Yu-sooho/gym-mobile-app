import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_calendar/models/routine_models.dart';
import 'package:gym_calendar/stores/localization/localization_controller.dart';

class RoutineStateController extends GetxController {
  final LocalizationController localizationController =
      Get.put(LocalizationController());

  RxList<Routine> routineList = RxList<Routine>.empty();
  QueryDocumentSnapshot<Object?>? startAfterRoutine;
  bool endRoutineList = false;

  RxMap<String, RoutineList> calendarRoutineList = RxMap<String, RoutineList>();

  late RxList<String> routineSortMethod = [
    localizationController.localiztionComponentButton().latest,
    localizationController.localiztionComponentButton().oldest,
    localizationController.localiztionComponentButton().name,
    localizationController.localiztionComponentButton().startDatest,
    localizationController.localiztionComponentButton().endDatest,
  ].obs;
  RxInt routineSort = 0.obs;
}
