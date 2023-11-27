import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_calendar/providers/auth_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<bool> updateUser(Map<Object, Object> data, String uid) async {
  try {
    if (uid.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(data);
    }
    return true;
  } catch (error) {
    print('updateUser $error');
    return false;
  }
}

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
  User? currentUser;
  UserData currentUserData = UserData();

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
    final String photoURL = res.data()?['photoURL'];
    final bool disabled = res.data()?['disabled'];
    final String displayName = res.data()?['displayName'];
    final String creationTime = res.data()?['creationTime'];
    final String email = res.data()?['email'];
    final bool emailVerified = res.data()?['emailVerified'];
    final String? phoneNumber = res.data()?['phoneNumber'];

    currentUserData.photoURL = photoURL.obs;
    currentUserData.disabled = disabled.obs;
    currentUserData.displayName = displayName.obs;
    currentUserData.creationTime = creationTime.obs;
    currentUserData.email = email.obs;
    currentUserData.emailVerified = emailVerified.obs;
    currentUserData.phoneNumber = phoneNumber?.obs;
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
