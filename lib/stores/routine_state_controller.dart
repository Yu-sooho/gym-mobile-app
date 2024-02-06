import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_calendar/models/routine_models.dart';

class RoutineStateController extends GetxController {
  RxList<Routine> routineList = RxList<Routine>.empty();
  QueryDocumentSnapshot<Object?>? startAfterRoutine;
  bool endRoutineList = false;
}
