import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';

class ExerciseStateController extends GetxController {
  RxList<Muscles> muscles = RxList<Muscles>.empty();
  RxList<Muscles> muscleList = RxList<Muscles>.empty();
  QueryDocumentSnapshot<Object?>? startAfterMuscle;
  bool endMuscleList = false;

  RxList<Exercise> exerciseList = RxList<Exercise>.empty();
  QueryDocumentSnapshot<Object?>? startAfter;
  bool endExerciseList = false;
}
