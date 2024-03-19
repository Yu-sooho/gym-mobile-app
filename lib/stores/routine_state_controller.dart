import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_calendar/models/routine_models.dart';
import 'package:gym_calendar/stores/localization/localization_controller.dart';
import 'package:gym_calendar/utils/package_util.dart';

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

  int countRoutinesBetweenDates(
      DateTime startDate, DateTime endDate, List<List<dynamic>> routineCycles) {
    int count = 0;

    for (DateTime date = startDate;
        date.isBefore(endDate.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      int weekNumber = ((date.difference(startDate).inDays) / 7).floor();
      List<dynamic> weekCycle =
          routineCycles[weekNumber % routineCycles.length];

      if (weekCycle.contains(date.weekday - 1)) {
        count++;
      }
    }

    return count;
  }

  List<Routine> findRoutinesForSelectedDay(DateTime selectedDay) {
    final List<Routine>? routines =
        calendarRoutineList['${selectedDay.year}']?.list;

    if (routines == null) return [];

    List<Routine> routinesForSelectedDay = [];

    for (var routine in routines) {
      if (routine.routineCycle == null || routine.startDate == null) continue;

      final startDate = routine.startDate!.toDate();
      final DateTime? endDate =
          routine.endDate != null ? routine.endDate!.toDate() : null;
      final List<List<int?>> cycleArray =
          Math().convertedRecycle(routine.routineCycle!);

      if (cycleArray.isEmpty) continue;

      DateTime weekStart =
          startDate.subtract(Duration(days: startDate.weekday - 1));
      if (cycleArray[0].first! < startDate.weekday - 1) {
        weekStart = weekStart.add(Duration(days: 7));
      }

      int weeksSinceStart =
          ((selectedDay.difference(weekStart).inDays) / 7).floor();
      if (weeksSinceStart < 0 ||
          (endDate != null && selectedDay.isAfter(endDate))) continue;

      int cycleWeekIndex = weeksSinceStart % cycleArray.length;
      int dayOfWeekIndex = selectedDay.weekday - 1;

      if (cycleArray[cycleWeekIndex].contains(dayOfWeekIndex)) {
        routinesForSelectedDay.add(routine);
      }
    }

    return routinesForSelectedDay;
  }
}
