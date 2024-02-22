import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_calendar/providers/auth_provider.dart';
import 'package:gym_calendar/stores/firebase/firebase_firestores.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// notification1 운동
// notification2 스케쥴
class UserData {
  RxString? displayName;
  RxBool? disabled;
  RxString? creationTime;
  RxString? email;
  RxBool? emailVerified;
  RxString? photoURL;
  RxString? phoneNumber;
  RxString? fcmToken;
  RxBool? notification1;
  RxBool? notification2;
  UserData(
      {this.displayName,
      this.disabled,
      this.creationTime,
      this.email,
      this.emailVerified,
      this.photoURL,
      this.phoneNumber,
      this.fcmToken,
      this.notification1,
      this.notification2});
}

class FirebaseAuthController extends GetxController {
  final FirebaseFirestoreController firebaseFirestoreController =
      Get.put(FirebaseFirestoreController());

  RxString? uid;
  RxString? docId;
  UserData currentUserData = UserData();

  void addAuthEventListener() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        uid = user.uid.obs;
        await getUser(user: user);
        print('FirebaseAuthController addAuthEventListener login $user');
        return;
      }
      uid = null;
      print('FirebaseAuthController addAuthEventListener logout');
    });
  }

  Future<bool> getUser({User? user}) async {
    try {
      final id = user?.uid ?? uid?.value;
      if (id == null) return false;
      final res = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: id)
          .get();

      for (var doc in res.docs) {
        docId = doc.id.obs;
        final bool? disabled = doc.data()['disabled'];
        final bool? emailVerified = doc.data()['emailVerified'];
        final String? photoURL = doc.data()['photoURL'];
        final String? displayName = doc.data()['displayName'];
        final String? creationTime = doc.data()['creationTime'];
        final String? email = doc.data()['email'];
        final String? phontNumber = doc.data()['phoneNumber'];
        final String? fcmToken = doc.data()['fcmToken'];
        final bool? notification1 = doc.data()['notification1'];
        final bool? notification2 = doc.data()['notification2'];

        currentUserData.disabled = disabled?.obs;
        currentUserData.emailVerified = emailVerified?.obs;
        currentUserData.photoURL = photoURL?.obs;
        currentUserData.displayName = displayName?.obs;
        currentUserData.creationTime = creationTime?.obs;
        currentUserData.email = email?.obs;
        currentUserData.phoneNumber = phontNumber?.obs;
        currentUserData.fcmToken = fcmToken?.obs;
        currentUserData.notification1 = notification1?.obs;
        currentUserData.notification2 = notification2?.obs;
      }

      if (docId?.value != null) {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        firebaseFirestoreController.postCollectionDataSet(
            collectionName: 'users',
            docName: docId?.value,
            obj: {'fcmToken': fcmToken});
      }
      return true;
    } catch (error) {
      print('getUser error $error');
      return false;
    }
  }

  Future<bool> appleLoginFirebase(
      AuthorizationCredentialAppleID appleCredential, String rawNonce) async {
    try {
      final OAuthCredential credential = OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
          accessToken: appleCredential.authorizationCode);
      UserCredential res =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (res.user?.uid.isNotEmpty ?? false) return true;
      return false;
    } catch (error) {
      print('firebase_auth appleLoginFirebase $error');
      rethrow;
    }
  }

  Future<bool> googleLoginFirebase(
      GoogleSignInAccount googleSignInAccount) async {
    try {
      GoogleSignInAuthentication authentication =
          await googleSignInAccount.authentication;
      OAuthCredential googleCredential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken,
      );
      UserCredential res =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);
      if (res.user?.uid.isNotEmpty ?? false) return true;
      return false;
    } catch (error) {
      print('firebase_auth googleLoginFirebase $error');
      rethrow;
    }
  }

  Future<bool> kakaoLoginFirebase(user, token) async {
    try {
      final SocialLoginProvider socialLoginProvider = SocialLoginProvider();
      final res = await socialLoginProvider.postKakaoLogin({"code": token});
      if (res['firebaseToken'] != null) {
        await FirebaseAuth.instance.signInWithCustomToken(res['firebaseToken']);
        return true;
      }
      return false;
    } catch (error) {
      print('firebase_auth kakaoLoginFirebase $error');
      rethrow;
    }
  }

  Future<bool> naverLoginFirebase(user, token) async {
    try {
      final SocialLoginProvider socialLoginProvider = SocialLoginProvider();
      final res = await socialLoginProvider.postNaverLogin({"code": token});
      if (res['firebaseToken'] != null) {
        await FirebaseAuth.instance.signInWithCustomToken(res['firebaseToken']);
        return true;
      }
      return false;
    } catch (error) {
      print('firebase_auth naverLoginFirebase $error');
      rethrow;
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
