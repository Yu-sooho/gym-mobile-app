import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_calendar/models/package_models.dart';

class Routine {
  String id;
  String uid;
  String name;
  String? startDate;
  String? endDate;
  int? executionCount;
  int? allCount;
  String? routineCycle;
  List<Exercise> exercises;
  Timestamp createdAt;
  Routine({
    required this.id,
    required this.uid,
    required this.name,
    required this.exercises,
    required this.createdAt,
    this.executionCount,
    this.routineCycle,
    this.allCount,
    this.startDate,
    this.endDate,
  });
}

class RoutineList {
  List<Routine> list;
  QueryDocumentSnapshot<Object?>? lastDoc;
  int length;

  RoutineList({this.lastDoc, required this.list, required this.length});
}
