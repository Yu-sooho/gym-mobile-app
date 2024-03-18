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

  void addRoutineInMap(Routine newRoutine) {
    String yearKey =
        '${newRoutine.startDate?.toDate().year ?? DateTime.now().year}';
    if (!calendarRoutineList.containsKey(yearKey)) {
      calendarRoutineList[yearKey] = RoutineList(list: [newRoutine], length: 1);
    } else {
      var existingList = calendarRoutineList[yearKey];
      if (!existingList!.list.any((routine) => routine.id == newRoutine.id)) {
        existingList.list.add(newRoutine);
        existingList.length++;
        calendarRoutineList[yearKey] = existingList;
      }
    }

    if (!routineList.any((routine) => routine.id == newRoutine.id)) {
      routineList.add(newRoutine);
    }
  }

  void updateRoutineInMap(Routine routineToUpdate) {
    for (String key in calendarRoutineList.keys) {
      var routineList = calendarRoutineList[key];
      var index = routineList?.list
          .indexWhere((routine) => routine.id == routineToUpdate.id);
      if (index != null && index != -1) {
        routineList?.list[index] = routineToUpdate;
        if (routineList != null) {
          calendarRoutineList[key] = routineList;
        }
      }
    }

    int routineListIndex =
        routineList.indexWhere((routine) => routine.id == routineToUpdate.id);
    if (routineListIndex != -1) {
      routineList[routineListIndex] = routineToUpdate;
    }
  }

  void deleteRoutineFromMap(
      RxMap<String, RoutineList> routineMap, Routine routineToDelete) {
    for (String key in routineMap.keys) {
      var routineList = routineMap[key];
      routineList?.list
          .removeWhere((routine) => routine.id == routineToDelete.id);
      if (routineList != null) {
        routineMap[key] = routineList;
      }
    }

    routineList.removeWhere((routine) => routine.id == routineToDelete.id);
  }
}
