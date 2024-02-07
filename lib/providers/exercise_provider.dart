import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/exercise_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class ExerciseProvider {
  Stores stores = Stores();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<MuscleList> getMuscleList() async {
    try {
      final collectionName = stores.localizationController.language.value == 1
          ? 'muscles_kr'
          : 'muscles';

      final res = await stores.firebaseFirestoreController
          .getCollectionData(collectionName: collectionName);
      final last = res.docs.lastOrNull;
      List<Muscles> list = [];
      for (var element in res.docs) {
        final data = element.data() as Map<String, dynamic>;
        final name = data['name'];
        final imageURL = data['imageURL'];
        final createdAt = data['createdAt'];
        final uid = data['uid'];
        final id = element.id;
        final muscle = Muscles(
            id: id,
            uid: uid,
            name: name,
            imageURL: imageURL,
            createdAt: createdAt);
        list.add(muscle);
      }
      return MuscleList(list: list, lastDoc: last, length: res.docs.length);
    } catch (error) {
      print('ExerciseProvider getMuscleList error: $error');
      rethrow;
    }
  }

  Future<MuscleList> getUserMuscleList({
    DocumentSnapshot<Object?>? startAfter,
    int? limit,
  }) async {
    try {
      const collectionName = 'user_muscles';

      String uid = stores.firebaseAuthController.uid!.value;
      Query query = firestore
          .collection(collectionName)
          .where('uid', isEqualTo: uid)
          .orderBy('createdAt')
          .limit(limit ?? 20);

      if (startAfter != null) {
        query = firestore
            .collection('user_muscles')
            .where('uid', isEqualTo: uid)
            .orderBy('createdAt')
            .startAfterDocument(startAfter)
            .limit(limit ?? 20);
      }

      List<Muscles> list = [];
      final res = await stores.firebaseFirestoreController
          .getCollectionData(query: query);
      final last = res.docs.lastOrNull;
      for (var element in res.docs) {
        final data = element.data() as Map<String, dynamic>;
        final name = data['name'];
        final imageURL = data['imageURL'];
        final createdAt = data['createdAt'];
        final uid = data['uid'];
        final id = element.id;
        final exercise = Muscles(
            id: id,
            uid: uid,
            name: name,
            imageURL: imageURL,
            createdAt: createdAt);
        list.add(exercise);
      }
      return MuscleList(list: list, lastDoc: last, length: res.docs.length);
    } catch (error) {
      print('ExerciseProvider getMuscleList error: $error');
      rethrow;
    }
  }

  Future<ExerciseList> getExerciseList(
      {DocumentSnapshot<Object?>? startAfter,
      int? limit,
      int? musclesNames}) async {
    String uid = stores.firebaseAuthController.uid!.value;
    Query query = firestore
        .collection('user_exercise')
        .where('uid', isEqualTo: uid)
        .where('musclesNames', arrayContains: musclesNames)
        .orderBy('createdAt', descending: true)
        .limit(limit ?? 4);

    if (startAfter != null) {
      query = firestore
          .collection('user_exercise')
          .where('uid', isEqualTo: uid)
          .where('musclesNames', arrayContains: musclesNames)
          .orderBy('createdAt', descending: true)
          .startAfterDocument(startAfter)
          .limit(limit ?? 4);
    }

    List<Exercise> list = [];
    final res = await stores.firebaseFirestoreController
        .getCollectionData(query: query);
    final last = res.docs.lastOrNull;
    for (var element in res.docs) {
      final data = element.data() as Map<String, dynamic>;
      final name = data['name'];
      final musclesNames = data['musclesNames'];
      final createdAt = data['createdAt'];
      final uid = data['uid'];
      final id = element.id;
      final exercise = Exercise(
          id: id,
          uid: uid,
          name: name,
          musclesNames: musclesNames ?? [],
          createdAt: createdAt);
      list.add(exercise);
    }

    return ExerciseList(list: list, lastDoc: last, length: res.docs.length);
  }

  Future postCustomMuscle(Map<String, dynamic> data) async {
    try {
      data['uid'] = stores.firebaseAuthController.uid?.value;
      data['createdAt'] = Timestamp.now();
      await stores.firebaseFirestoreController
          .postCollectionDataSet(collectionName: 'user_muscles', obj: data);
      return true;
    } catch (error) {
      print('ExerciseProvider postCustomMuscle error: $error');
      rethrow;
    }
  }

  Future deleteCustomMuscle(String docName) async {
    try {
      await stores.firebaseFirestoreController.deleteCollectionDataSet(
          collectionName: 'user_muscles', docName: docName);
      return true;
    } catch (error) {
      print('ExerciseProvider deleteCustomMuscle error: $error');
      rethrow;
    }
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

  Future deleteCustomExercise(String docName) async {
    try {
      await stores.firebaseFirestoreController.deleteCollectionDataSet(
          collectionName: 'user_exercise', docName: docName);
      return true;
    } catch (error) {
      print('ExerciseProvider deleteCustomExercise error: $error');
      rethrow;
    }
  }
}
