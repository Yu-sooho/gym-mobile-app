import 'package:cloud_firestore/cloud_firestore.dart';

// [
//   {'name': '어깨', 'imageURL': null, 'id': 0},
//   {'name': '승모', 'imageURL': null, 'id': 1},
//   {'name': '가슴', 'imageURL': null, 'id': 2},
//   {'name': '이두', 'imageURL': null, 'id': 3},
//   {'name': '삼두', 'imageURL': null, 'id': 4},
//   {'name': '전완근', 'imageURL': null, 'id': 5},
//   {'name': '복부', 'imageURL': null, 'id': 6},
//   {'name': '등', 'imageURL': null, 'id': 7},
//   {'name': '허리', 'imageURL': null, 'id': 8},
//   {'name': '둔부', 'imageURL': null, 'id': 9},
//   {'name': '대퇴', 'imageURL': null, 'id': 10},
//   {'name': '햄스트링', 'imageURL': null, 'id': 11},
//   {'name': '종아리', 'imageURL': null, 'id': 12},
// ];

class Muscles {
  String id;
  String? uid;
  Timestamp? createdAt;
  String name;
  String? imageURL;
  Muscles(
      {required this.id,
      required this.name,
      required this.imageURL,
      this.createdAt,
      this.uid});
}

class Exercise {
  String id;
  String uid;
  String name;
  List<dynamic> musclesNames;
  Timestamp createdAt;
  int? weight;
  int? targetWeight;
  Exercise(
      {required this.id,
      required this.uid,
      required this.name,
      required this.musclesNames,
      required this.createdAt,
      this.weight,
      this.targetWeight});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] as String,
      id: json['id'] as String,
      uid: json['uid'] as String,
      musclesNames: json['musclesNames'] as List<dynamic>,
      createdAt: json['createdAt'] as Timestamp,
      weight: json['weight'] as int,
      targetWeight: json['targetWeight'] as int,
    );
  }
}

class MuscleList {
  List<Muscles> list;
  QueryDocumentSnapshot<Object?>? lastDoc;
  int length;

  MuscleList({this.lastDoc, required this.list, required this.length});
}

class ExerciseList {
  List<Exercise> list;
  QueryDocumentSnapshot<Object?>? lastDoc;
  int length;

  ExerciseList({this.lastDoc, required this.list, required this.length});
}
