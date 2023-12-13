import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/exercise_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class ExerciseProvider {
  Stores stores = Stores();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> getMuscleList() async {
    try {
      final collectionName = stores.localizationController.language.value == 1
          ? 'muscles'
          : 'muscles';

      final res = await stores.firebaseFirestoreController
          .getCollectionData(collectionName: collectionName);
      List<Muscles> list = [];
      for (var element in res.docs) {
        final id = element.get('id');
        final name = element.get('name');
        final imageURL = element.get('imageURL');
        final muscle = Muscles(id: id, name: name, imageURL: imageURL);
        list.add(muscle);
      }
      stores.exerciseStateController.muscles = list.obs;
      return true;
    } catch (error) {
      print('ExerciseProvider getMuscleList error: $error');
      rethrow;
    }
  }

  Future<ExerciseList> getExerciseList(
      {DocumentSnapshot<Object?>? startAfter,
      int? limit,
      int? muscleId}) async {
    String uid = stores.firebaseAuthController.uid!.value;
    Query query = firestore
        .collection('user_exercise')
        .where('uid', isEqualTo: uid)
        .where('muscleId', isEqualTo: muscleId)
        .orderBy('createdAt', descending: true)
        .limit(limit ?? 4);

    if (startAfter != null) {
      query = firestore
          .collection('user_exercise')
          .where('uid', isEqualTo: uid)
          .where('muscleId', isEqualTo: muscleId)
          .orderBy('createdAt', descending: true)
          .startAfterDocument(startAfter)
          .limit(limit ?? 4);
    }

    List<Exercise> list = [];
    final res = await stores.firebaseFirestoreController
        .getCollectionData(query: query);
    final last = res.docs.lastOrNull;
    for (var element in res.docs) {
      final uid = element.get('uid');
      final name = element.get('name');
      final muscleId = element.get('muscleId');
      final createdAt = element.get('createdAt');
      final exercise = Exercise(
          uid: uid, name: name, muscleId: muscleId, createdAt: createdAt);
      list.add(exercise);
    }

    return ExerciseList(list: list, lastDoc: last, length: res.docs.length);
  }

  Future postCustomExercise(Map<String, dynamic> data) async {
    try {
      data['uid'] = stores.firebaseAuthController.uid?.value;
      data['createdAt'] = Timestamp.now();
      await stores.firebaseFirestoreController
          .postCollectionDataSet(collectionName: 'user_exercise', obj: data);
      return true;
    } catch (error) {
      print('ExerciseProvider postCustomExercise error: $error');
      rethrow;
    }
  }
}
