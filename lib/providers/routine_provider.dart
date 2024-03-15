import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class RoutineProvider {
  Stores stores = Stores();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  orderBy(order) {
    final name =
        stores.localizationController.localiztionComponentButton().name;
    final oldest =
        stores.localizationController.localiztionComponentButton().oldest;
    final startDatest =
        stores.localizationController.localiztionComponentButton().startDatest;
    final endDatest =
        stores.localizationController.localiztionComponentButton().endDatest;
    if (order == name) {
      return {'text': 'name', 'descending': false};
    } else if (order == endDatest) {
      return {'text': 'endDate', 'descending': false};
    } else if (order == startDatest) {
      return {'text': 'startDate', 'descending': false};
    } else if (order == oldest) {
      return {'text': 'createdAt', 'descending': false};
    } else {
      return {'text': 'createdAt', 'descending': true};
    }
  }

  Future<Routine?> getRoutineByDocName(String docName) async {
    try {
      DocumentSnapshot documentSnapshot =
          await stores.firebaseFirestoreController.getCollectionDocData(
              collectionName: 'user_routine', docName: docName);

      if (!documentSnapshot.exists) {
        print("Document with docName $docName not found.");
        return null;
      }

      final data = documentSnapshot.data() as Map<String, dynamic>;
      final exerciseIDs = (data['exercises'] as List<dynamic>).cast<String>();

      List<Exercise> exercises = [];
      if (exerciseIDs.isNotEmpty) {
        QuerySnapshot exerciseQuerySnapshot = await firestore
            .collection('user_exercise')
            .where(FieldPath.documentId, whereIn: exerciseIDs)
            .get();

        exercises = exerciseQuerySnapshot.docs
            .map((doc) =>
                Exercise.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList();
      }

      return Routine(
        id: documentSnapshot.id,
        uid: data['uid'],
        name: data['name'],
        color: data['color'],
        exercises: exercises,
        routineCycle: data['routineCycle'],
        startDate: data['startDate'],
        endDate: data['endDate'],
        docName: documentSnapshot.id,
        allCount: data['allCount'],
        createdAt: data['createdAt'],
      );
    } catch (e) {
      print('Error retrieving document: $e');
      return null;
    }
  }

  Future<RoutineList> getRoutineList(
      {DocumentSnapshot<Object?>? startAfter,
      int? limit,
      String? sort,
      String? searchKeyword}) async {
    String uid = stores.firebaseAuthController.uid!.value;
    late Query query;
    final order = orderBy(sort);

    query = firestore
        .collection('user_routine')
        .where('uid', isEqualTo: uid)
        .orderBy(order['text'], descending: order['descending'])
        .limit(limit ?? 4);

    if (startAfter != null) {
      query = firestore
          .collection('user_routine')
          .where('uid', isEqualTo: uid)
          .orderBy(order['text'], descending: order['descending'])
          .startAfterDocument(startAfter)
          .limit(limit ?? 4);
    }

    if (searchKeyword != null && searchKeyword != '') {
      query = firestore
          .collection('user_routine')
          .where('uid', isEqualTo: uid)
          .where('name', isGreaterThanOrEqualTo: searchKeyword)
          .where('name', isLessThanOrEqualTo: '$searchKeyword\uf8ff')
          .orderBy('name')
          .limit(limit ?? 4);
    }

    if (searchKeyword != null && searchKeyword != '' && startAfter != null) {
      query = firestore
          .collection('user_routine')
          .where('uid', isEqualTo: uid)
          .where('name', isGreaterThanOrEqualTo: searchKeyword)
          .where('name', isLessThanOrEqualTo: '$searchKeyword\uf8ff')
          .orderBy('name')
          .startAfterDocument(startAfter)
          .limit(limit ?? 4);
    }

    final userRoutineQuerySnapshot = await stores.firebaseFirestoreController
        .getCollectionData(query: query);
    final exerciseIDs = userRoutineQuerySnapshot.docs
        .map((doc) =>
            (doc.data() as Map<String, dynamic>)['exercises'] as List<dynamic>)
        .expand((exercises) => exercises)
        .cast<String>()
        .toList();

    var userExerciseResult = <Exercise>[];
    if (exerciseIDs.isEmpty) {
      userExerciseResult = [];
    } else {
      final userExerciseQuerySnapshot = await firestore
          .collection('user_exercise')
          .where(FieldPath.documentId, whereIn: exerciseIDs)
          .get();
      userExerciseResult = userExerciseQuerySnapshot.docs
          .map((doc) => Exercise.fromJson(doc.data(), doc.id))
          .toList();
    }

    List<Routine> list = [];
    final res = await stores.firebaseFirestoreController
        .getCollectionData(query: query);
    final last = res.docs.lastOrNull;

    for (var element in res.docs) {
      final data = element.data() as Map<String, dynamic>;
      final name = data['name'];
      final createdAt = data['createdAt'];
      final uid = data['uid'];
      final startDate = data['startDate'];
      final endDate = data['endDate'];
      final allCount = data['allCount'];
      final routineCycle = data['routineCycle'];
      final color = data['color'];
      final id = element.id;
      final routine = Routine(
        id: id,
        uid: uid,
        name: name,
        color: color,
        exercises: userExerciseResult,
        routineCycle: routineCycle,
        startDate: startDate,
        endDate: endDate,
        docName: element.id,
        allCount: allCount,
        createdAt: createdAt,
      );
      list.add(routine);
    }

    return RoutineList(list: list, lastDoc: last, length: res.docs.length);
  }

  Future<RoutineList?> getRoutineInCalendar({int? year, int? month}) async {
    String uid = stores.firebaseAuthController.uid!.value;
    late Query query;
    if (year == null) return null;
    DateTime dateTime = DateTime(year);

    query = firestore
        .collection('user_routine')
        .where('uid', isEqualTo: uid)
        .where('startDate', isGreaterThanOrEqualTo: dateTime)
        .where('isEnded', isNull: true);

    final userRoutineQuerySnapshot = await stores.firebaseFirestoreController
        .getCollectionData(query: query);
    final exerciseIDs = userRoutineQuerySnapshot.docs
        .map((doc) =>
            (doc.data() as Map<String, dynamic>)['exercises'] as List<dynamic>)
        .expand((exercises) => exercises)
        .cast<String>()
        .toList();

    var userExerciseResult = <Exercise>[];
    if (exerciseIDs.isEmpty) {
      userExerciseResult = [];
    } else {
      final userExerciseQuerySnapshot = await firestore
          .collection('user_exercise')
          .where(FieldPath.documentId, whereIn: exerciseIDs)
          .get();
      userExerciseResult = userExerciseQuerySnapshot.docs
          .map((doc) => Exercise.fromJson(doc.data(), doc.id))
          .toList();
    }

    List<Routine> list = [];
    final res = await stores.firebaseFirestoreController
        .getCollectionData(query: query);
    final last = res.docs.lastOrNull;

    for (var element in res.docs) {
      final data = element.data() as Map<String, dynamic>;
      final name = data['name'];
      final createdAt = data['createdAt'];
      final uid = data['uid'];
      final startDate = data['startDate'];
      final endDate = data['endDate'];
      final allCount = data['allCount'];
      final routineCycle = data['routineCycle'];
      final executionDate = data['executionDate'];
      final color = data['color'];
      final id = element.id;
      final routine = Routine(
          id: id,
          uid: uid,
          name: name,
          color: color,
          exercises: userExerciseResult,
          routineCycle: routineCycle,
          startDate: startDate,
          endDate: endDate,
          docName: element.id,
          allCount: allCount,
          createdAt: createdAt,
          executionDate: executionDate);
      list.add(routine);
    }

    return RoutineList(list: list, lastDoc: last, length: res.docs.length);
  }

  Future postCustomRoutine(Map<String, dynamic> data) async {
    try {
      data['uid'] = stores.firebaseAuthController.uid?.value;
      data['createdAt'] = Timestamp.now();
      await stores.firebaseFirestoreController
          .postCollectionDataSet(collectionName: 'user_routine', obj: data);
      return true;
    } catch (error) {
      print('RoutineProvider postCustomRoutine error: $error');
      rethrow;
    }
  }

  Future putCustomRoutine(Map<String, dynamic> data, String docName) async {
    try {
      data['uid'] = stores.firebaseAuthController.uid?.value;
      data['updatedAt'] = Timestamp.now();
      await stores.firebaseFirestoreController.putCollectionDataSet(
          collectionName: 'user_routine', obj: data, docName: docName);
      return true;
    } catch (error) {
      print('RoutineProvider putCustomRoutine error: $error');
      rethrow;
    }
  }

  Future deleteCustomRoutine(String docName) async {
    try {
      await stores.firebaseFirestoreController.deleteCollectionDataSet(
          collectionName: 'user_routine', docName: docName);
      return true;
    } catch (error) {
      print('RoutineProvider postCustomRoutine error: $error');
      rethrow;
    }
  }
}
