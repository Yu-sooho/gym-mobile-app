import 'package:get/get.dart';
import 'package:gym_calendar/models/routine_models.dart';

class RoutineStateController extends GetxController {
  RxMap cycle = <CycleType, String>{
    CycleType.day: 'day',
    CycleType.week: 'week',
    CycleType.month: 'month'
  }.obs;
}
