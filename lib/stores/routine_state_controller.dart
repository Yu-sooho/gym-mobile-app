import 'package:get/get.dart';

enum CycleType { day, week, month }

class RoutineStateController extends GetxController {
  RxMap cycle = <CycleType, String>{
    CycleType.day: 'day',
    CycleType.week: 'week',
    CycleType.month: 'month'
  }.obs;
}
