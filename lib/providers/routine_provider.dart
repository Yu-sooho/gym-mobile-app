import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_calendar/models/routine_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class RoutineProvider {
  Stores stores = Stores();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<RoutineList> getRoutineList(
      {DocumentSnapshot<Object?>? startAfter,
      int? limit,
      int? musclesId}) async {
    String uid = stores.firebaseAuthController.uid!.value;
    Query query = firestore
        .collection('user_routine')
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(limit ?? 4);

    if (startAfter != null) {
      query = firestore
          .collection('user_routine')
          .where('uid', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .startAfterDocument(startAfter)
          .limit(limit ?? 4);
    }

    List<Routine> list = [];
    final res = await stores.firebaseFirestoreController
        .getCollectionData(query: query);
    final last = res.docs.lastOrNull;
    for (var element in res.docs) {
      final id = element.id;
      final uid = element.get('uid');
      final name = element.get('name');
      final cycle = element.get('cycle');
      final date = element.get('date');
      final exercises = element.get('exercises');
      final createdAt = element.get('createdAt');
      final routine = Routine(
          id: id,
          uid: uid,
          name: name,
          cycle: cycle,
          date: date,
          exercises: exercises,
          createdAt: createdAt);
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
