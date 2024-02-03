import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';

class ExerciseStateController extends GetxController {
  RxList<Muscles>? muscles;
  RxList<Exercise>? exerciseList;
  QueryDocumentSnapshot<Object?>? startAfter;
  bool endExerciseList = false;
}
