import 'package:cloud_firestore/cloud_firestore.dart';

class Muscles {
  int id;
  String name;
  String? imageURL;
  Muscles({required this.id, required this.name, required this.imageURL});
}

class Exercise {
  String uid;
  String name;
  List<dynamic> musclesId;
  Timestamp createdAt;
  Exercise(
      {required this.uid,
      required this.name,
      required this.musclesId,
      required this.createdAt});
}

class ExerciseList {
  List<Exercise> list;
  QueryDocumentSnapshot<Object?>? lastDoc;
  int length;

  ExerciseList({this.lastDoc, required this.list, required this.length});
}
