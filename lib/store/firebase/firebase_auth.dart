import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FirebaseAuthController extends GetxController {
  User? authState;

  final storage = FlutterSecureStorage();

  void addAuthEventListener() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        authState = user;
        print('FirebaseAuthController addAuthEventListener login $user');
        return;
      }
      authState = null;
      print('FirebaseAuthController addAuthEventListener logout');
    });
  }

  Future<bool> appleLoginFirebase(
      AuthorizationCredentialAppleID appleCredential, String rawNonce) async {
    try {
      final OAuthCredential credential = OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
          accessToken: appleCredential.authorizationCode);
      final res = await FirebaseAuth.instance.signInWithCredential(credential);
      if (res.user?.uid.isNotEmpty ?? false) return true;
      return false;
    } catch (error) {
      print('firebase_auth appleLoginFirebase $error');
      return false;
    }
  }

  Future<void> signOut() async {
    return FirebaseAuth.instance.signOut().whenComplete(() {
      print("SignOut Done");
    }).catchError((error) {
      print("error in signout $error");
    });
  }
}
