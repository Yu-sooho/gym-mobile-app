import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<dynamic> uploadProfileImage(
    String uid, String fileName, String filePath) async {
// firebaseAuthController.currentUser?.uid
// pickedFile.name
  try {
    var storageRef =
        FirebaseStorage.instance.ref('users/profilePicture/$uid/$fileName');
    final file = File(filePath);
    await storageRef.putFile(file);
    final url = await storageRef.getDownloadURL();
    return url;
  } catch (error) {
    print('firebase Storage Error uploadProfileImage $error');
    return null;
  }
}
