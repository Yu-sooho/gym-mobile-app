import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/firebase/package_firebase.dart';
import 'package:gym_calendar/stores/localization/localization_controller.dart';

class FirebaseFirestoreController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final FirebaseController firebaseController = Get.put(FirebaseController());

  /// 컬렉션 네임으로 문서 자동 Id 및 하나의 데이터 셋
  Future postCollectionDataSet(
      {String collectionName = '',
      String? docName,
      Map<String, dynamic>? obj}) async {
    try {
      if (collectionName.isEmpty) {
        throw {'error': 'no collectionName'};
      }
      if (obj == null) {
        throw {'error': 'no obj'};
      }
      print('firebase_firestores getCollectionData success $collectionName');
      return firebaseController.firebaseVoid(() async {
        return await firestore
            .collection(collectionName)
            .doc(docName)
            .set(obj, SetOptions(merge: true));
      });
    } catch (error) {
      print('firebase_firestores getCollectionData error $error');
      rethrow;
    }
  }

  /// 문서 이름으로 하나의 데이터 삭제
  Future deleteCollectionDataSet({
    String collectionName = '',
    String docName = '',
  }) async {
    try {
      if (collectionName.isEmpty) {
        throw {'error': 'no collectionName'};
      }
      if (docName.isEmpty) {
        throw {'error': 'no docName'};
      }
      print(
          'firebase_firestores deleteCollectionDataSet success $collectionName');
      return firebaseController.firebaseVoid(() async {
        return await firestore.collection(collectionName).doc(docName).delete();
      });
    } catch (error) {
      print('firebase_firestores deleteCollectionDataSet error $error');
      rethrow;
    }
  }

  /// 컬렉션 네임으로 해당 문서 전부 다 가져오는 함수
  Future<QuerySnapshot> getCollectionData(
      {String? collectionName, Query? query}) async {
    try {
      if (collectionName == null && query == null) {
        throw {'error': 'no collectionName and no Query'};
      }
      return firebaseController.firebaseQuerySnapshot(() async {
        return query != null
            ? query.get()
            : firestore.collection(collectionName!).orderBy('id').get();
      });
    } catch (error) {
      print('firebase_firestores getCollectionData error $error');
      rethrow;
    }
  }
}
