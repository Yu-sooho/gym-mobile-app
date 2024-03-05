import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_calendar/models/exercise_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class ExerciseProvider {
  Stores stores = Stores();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  orderBy(order) {
    final name =
        stores.localizationController.localiztionComponentButton().name;
    final oldest =
        stores.localizationController.localiztionComponentButton().oldest;
    if (order == name) {
      return {'text': 'name', 'descending': false};
    } else if (order == oldest) {
      return {'text': 'createdAt', 'descending': false};
    } else {
      return {'text': 'createdAt', 'descending': true};
    }
  }

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

  Future<MuscleList> getUserMuscleList(
      {DocumentSnapshot<Object?>? startAfter,
      int? limit,
      String? sort,
      String? searchKeyword}) async {
    try {
      const collectionName = 'user_muscles';
      final order = orderBy(sort);

      String uid = stores.firebaseAuthController.uid!.value;
      Query query = firestore
          .collection(collectionName)
          .where('uid', isEqualTo: uid)
          .orderBy(order['text'], descending: order['descending'])
          .limit(limit ?? 20);

      if (startAfter != null) {
        query = firestore
            .collection('user_muscles')
            .where('uid', isEqualTo: uid)
            .orderBy(order['text'], descending: order['descending'])
            .startAfterDocument(startAfter)
            .limit(limit ?? 20);
      }

      if (searchKeyword != null && searchKeyword != '') {
        query = firestore
            .collection('user_muscles')
            .where('uid', isEqualTo: uid)
            .where('name', isGreaterThanOrEqualTo: searchKeyword)
            .where('name', isLessThanOrEqualTo: '$searchKeyword\uf8ff')
            .orderBy('name')
            .limit(limit ?? 4);
      }

      if (searchKeyword != null && searchKeyword != '' && startAfter != null) {
        query = firestore
            .collection('user_muscles')
            .where('uid', isEqualTo: uid)
            .where('name', isGreaterThanOrEqualTo: searchKeyword)
            .where('name', isLessThanOrEqualTo: '$searchKeyword\uf8ff')
            .orderBy('name')
            .startAfterDocument(startAfter)
            .limit(limit ?? 4);
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
      String? sort,
      String? searchKeyword}) async {
    String uid = stores.firebaseAuthController.uid!.value;
    late Query query;
    final order = orderBy(sort);

    query = firestore
        .collection('user_exercise')
        .where('uid', isEqualTo: uid)
        .orderBy(order['text'], descending: order['descending'])
        .limit(limit ?? 4);

    if (startAfter != null) {
      query = firestore
          .collection('user_exercise')
          .where('uid', isEqualTo: uid)
          .orderBy(order['text'], descending: order['descending'])
          .startAfterDocument(startAfter)
          .limit(limit ?? 4);
    }

    if (searchKeyword != null && searchKeyword != '') {
      query = firestore
          .collection('user_exercise')
          .where('uid', isEqualTo: uid)
          .where('name', isGreaterThanOrEqualTo: searchKeyword)
          .where('name', isLessThanOrEqualTo: '$searchKeyword\uf8ff')
          .orderBy('name')
          .limit(limit ?? 4);
    }

    if (searchKeyword != null && searchKeyword != '' && startAfter != null) {
      query = firestore
          .collection('user_exercise')
          .where('uid', isEqualTo: uid)
          .where('name', isGreaterThanOrEqualTo: searchKeyword)
          .where('name', isLessThanOrEqualTo: '$searchKeyword\uf8ff')
          .orderBy('name')
          .startAfterDocument(startAfter)
          .limit(limit ?? 4);
    }

    // final userRoutineQuerySnapshot = await stores.firebaseFirestoreController
    //     .getCollectionData(query: query);
    final userExerciseQuerySnapshot = await stores.firebaseFirestoreController
        .getCollectionData(query: query);
    final muscleNames = userExerciseQuerySnapshot.docs
        .map((doc) => (doc.data() as Map<String, dynamic>)['musclesNames']
            as List<dynamic>)
        .expand((muscles) => muscles)
        .cast<String>()
        .toList();

    var userMusclesResult = <Muscles>[];
    if (muscleNames.isEmpty) {
      userMusclesResult = [];
    } else {
      final userMuscelsQuerySnapshot = await firestore
          .collection('user_muscles')
          .where('name', whereIn: muscleNames)
          .get();
      userMusclesResult = userMuscelsQuerySnapshot.docs
          .map((doc) => Muscles.fromJson(doc.data(), doc.id))
          .toList();
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
      final weight = data['weight'];
      final targetWeight = data['targetWeight'];
      final id = element.id;
      final exercise = Exercise(
          id: id,
          uid: uid,
          name: name,
          musclesNames: musclesNames ?? [],
          docName: element.id,
          muscles: userMusclesResult,
          createdAt: createdAt,
          weight: weight,
          targetWeight: targetWeight);
      list.add(exercise);
    }

    return ExerciseList(list: list, lastDoc: last, length: res.docs.length);
  }

  Future postCustomMuscle(Map<String, dynamic> data) async {
    try {
      data['uid'] = stores.firebaseAuthController.uid?.value;
      data['createdAt'] = Timestamp.now();
      bool isUnique = await stores.firebaseFirestoreController.isUniqueData(
          text: data['name'], collection: 'user_muscles', field: 'name');
      if (isUnique) {
        await stores.firebaseFirestoreController
            .postCollectionDataSet(collectionName: 'user_muscles', obj: data);
        return true;
      } else {
        return false;
      }
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

  Future postCustomExercise(
    Map<String, dynamic> data,
  ) async {
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

  Future putCustomExercise(Map<String, dynamic> data, String docName) async {
    try {
      data['uid'] = stores.firebaseAuthController.uid?.value;
      data['updatedAt'] = Timestamp.now();
      await stores.firebaseFirestoreController.putCollectionDataSet(
          collectionName: 'user_exercise', obj: data, docName: docName);
      return true;
    } catch (error) {
      print('RoutineProvider putCustomRoutine error: $error');
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
