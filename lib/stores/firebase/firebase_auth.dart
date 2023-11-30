import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_calendar/providers/auth_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserData {
  RxString? displayName;
  RxBool? disabled;
  RxString? creationTime;
  RxString? email;
  RxBool? emailVerified;
  RxString? photoURL;
  RxString? phoneNumber;
  UserData({
    this.displayName,
    this.disabled,
    this.creationTime,
    this.email,
    this.emailVerified,
    this.photoURL,
    this.phoneNumber,
  });
}

class FirebaseAuthController extends GetxController {
  RxString? uid;
  RxString? docId;
  UserData currentUserData = UserData();

  void addAuthEventListener() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        uid = user.uid.obs;
        getUser(user);
        print('FirebaseAuthController addAuthEventListener login $user');
        return;
      }
      uid = null;
      print('FirebaseAuthController addAuthEventListener logout');
    });
  }

  void getUser(User user) async {
    try {
      final res = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
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

        currentUserData.disabled = disabled?.obs;
        currentUserData.emailVerified = emailVerified?.obs;
        currentUserData.photoURL = photoURL?.obs;
        currentUserData.displayName = displayName?.obs;
        currentUserData.creationTime = creationTime?.obs;
        currentUserData.email = email?.obs;
        currentUserData.phoneNumber = phontNumber?.obs;
      }
    } catch (error) {
      print('getUser error $error');
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
