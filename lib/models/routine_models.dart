import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_calendar/models/package_models.dart';

class Routine {
  String uid;
  String id;
  String name;
  int cycle;
  int divisionCount;
  int weight;
  List<Exercise> exercises;
  Timestamp createdAt;
  Routine(
      {required this.id,
      required this.uid,
      required this.name,
      required this.cycle,
      required this.divisionCount,
      required this.weight,
      required this.exercises,
      required this.createdAt});
}