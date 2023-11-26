import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_calendar/providers/auth_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<bool> updateUser(String url, String uid) async {
  try {
    if (url.isNotEmpty && uid.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'photoURL': url});
    }
    return true;
  } catch (error) {
    print('updateUser $error');
    return false;
  }
}

class FirebaseAuthController extends GetxController {
  User? currentUser;
  late dynamic currentUserData;

  void addAuthEventListener() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        currentUser = user;
        getUser(user);
        print('FirebaseAuthController addAuthEventListener login $user');
        return;
      }
      currentUser = null;
      print('FirebaseAuthController addAuthEventListener logout');
    });
  }

  void getUser(User user) async {
    final res = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    currentUserData = res.data();
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
      print(res['firebaseToken']);
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
