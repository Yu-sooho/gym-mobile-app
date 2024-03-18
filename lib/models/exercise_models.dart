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

  factory Muscles.fromJson(Map<String, dynamic> json, id) {
    return Muscles(
      name: json['name'] as String,
      id: id ?? json['id'] as String,
      uid: json['uid'] as String,
      createdAt: json['createdAt'] as Timestamp,
      imageURL: json['imageURL'] != null ? json['imageURL'] as String : null,
    );
  }
}

class Exercise {
  String id;
  String uid;
  String name;
  List<dynamic> musclesNames;
  Timestamp createdAt;
  Timestamp? updatedAt;
  String? weight;
  String? targetWeight;
  String? count;
  String? targetCount;
  List<Muscles>? muscles;
  String? docName;
  Exercise(
      {required this.id,
      required this.uid,
      required this.name,
      required this.musclesNames,
      required this.createdAt,
      this.updatedAt,
      this.weight,
      this.muscles,
      this.targetWeight,
      this.docName,
      this.count,
      this.targetCount});

  factory Exercise.fromJson(Map<String, dynamic> json, id) {
    return Exercise(
        name: json['name'] as String,
        id: id ?? json['id'] as String,
        uid: json['uid'] as String,
        musclesNames: json['musclesNames'] as List<dynamic>,
        createdAt: json['createdAt'] as Timestamp,
        weight: json['weight'] as String,
        targetWeight: json['targetWeight'] as String,
        muscles:
            json['muscles'] != null ? json['muscles'] as List<Muscles> : null);
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

  factory ExerciseList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> exercisesJson = json['exercises'] ?? [];
    final List<Exercise> exercises = exercisesJson.cast<Exercise>().toList();
    return ExerciseList(list: exercises, length: exercises.length);
  }
}
