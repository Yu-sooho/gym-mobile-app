import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

Future<dynamic> uploadProfileImage(
    String docId, String fileName, String filePath) async {
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final AppStateController appStateController = Get.put(AppStateController());
  try {
    var storageRef =
        FirebaseStorage.instance.ref('users/profilePicture/$docId/$fileName');
    final file = File(filePath);
    await storageRef.putFile(file).timeout(Duration(seconds: 30));
    final url = await storageRef.getDownloadURL();
    return url;
  } on TimeoutException catch (_) {
    print('TimeoutException');
    appStateController.showToast(
        localizationController.localiztionComponentError().networkError);
  } on SocketException catch (_) {
    print('SocketException');
    appStateController.showToast(
        localizationController.localiztionComponentError().networkError);
  } catch (error) {
    print('firebase Storage Error uploadProfileImage $error');
    appStateController.showToast(
        localizationController.localiztionComponentError().networkError);
    return null;
  }
}
