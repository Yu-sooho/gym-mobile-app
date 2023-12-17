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
  int id;
  String name;
  String? imageURL;
  Muscles({required this.id, required this.name, required this.imageURL});
}

class Exercise {
  String id;
  String uid;
  String name;
  List<dynamic> musclesId;
  Timestamp createdAt;
  Exercise(
      {required this.id,
      required this.uid,
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
