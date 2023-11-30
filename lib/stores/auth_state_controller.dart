import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/app_state_controller.dart';
import 'package:gym_calendar/stores/firebase/firebase_auth.dart';
import 'package:gym_calendar/stores/firebase/package_firebase.dart';
import 'package:gym_calendar/stores/localization/localization_controller.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'dart:io' show Platform;

class AuthStateController extends GetxController {
  FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final AppStateController appStateController = Get.put(AppStateController());
  final FirebaseController firebaseController = Get.put(FirebaseController());

  dynamic authState;

  Future<bool> appleLogin() async {
    try {
      final rawNonce = generateNonce();
      final bytes = utf8.encode(rawNonce);
      final digest = sha256.convert(bytes);
      final nonce = digest.toString();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'gymCalendar.guardian.com',
            redirectUri: Uri.parse(
                'https://joyous-unexpected-enigmosaurus.glitch.me/callbacks/sign_in_with_apple')),
        nonce: nonce,
      );
      final res =
          await firebaseAuthController.appleLoginFirebase(credential, rawNonce);
      if (res) {
        return true;
      }
      return false;
    } catch (error) {
      print('auth_state_controller appleLogin $error');
      rethrow;
    }
  }

  Future<bool> googleLogin() async {
    const List<String> scopes = <String>[
      'email',
    ];
    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: Platform.isIOS
          ? '475767358760-c87a5aimkmm2j7poh2iuqpglvfdqfv7m.apps.googleusercontent.com'
          : null,
      scopes: scopes,
    );
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return false; // or throw an error
      }
      await firebaseAuthController.googleLoginFirebase(googleUser);
      return true;
    } catch (error) {
      print('auth_state_controller googleLogin $error');
      rethrow;
    }
  }

  Future<bool> kakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        final res = await UserApi.instance.loginWithKakaoTalk();
        if (res.accessToken.isNotEmpty) {
          User user = await UserApi.instance.me();
          final firebaseRes = await firebaseAuthController.kakaoLoginFirebase(
              user, res.accessToken);
          if (!firebaseRes) return false;
          return true;
        }
      } catch (error) {
        if (error is PlatformException && error.code == 'CANCELED') {
          print('auth_state_controller kakaoLogin cancel $error');
          return false;
        }
        try {
          final res = await UserApi.instance.loginWithKakaoAccount();
          if (res.accessToken.isNotEmpty) {
            User user = await UserApi.instance.me();
            final firebaseRes = await firebaseAuthController.kakaoLoginFirebase(
                user, res.accessToken);
            if (!firebaseRes) return false;
            return true;
          }
        } catch (error) {
          print('auth_state_controller kakaoLogin $error');
          rethrow;
        }
      }
    } else {
      try {
        final res = await UserApi.instance.loginWithKakaoAccount();
        if (res.accessToken.isNotEmpty) {
          User user = await UserApi.instance.me();
          final firebaseRes = await firebaseAuthController.kakaoLoginFirebase(
              user, res.accessToken);
          if (!firebaseRes) return false;
          return true;
        }
      } catch (error) {
        print('auth_state_controller kakaoLogin isNotInstalled Kakao $error');
        rethrow;
      }
    }
    return false;
  }

  Future<bool> naverLogin() async {
    try {
      final NaverLoginResult user = await FlutterNaverLogin.logIn();
      NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
      final firebaseRes = await firebaseAuthController.naverLoginFirebase(
          user, res.accessToken);
      if (!firebaseRes) return false;
      return true;
    } catch (error) {
      print('auth_state_controller naverLogin $error');
      rethrow;
    }
  }

  Future<bool> updateUser(Map<Object, Object> data, String docId) async {
    return firebaseController.firebaseAsync(() async {
      if (docId.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(docId)
            .update(data)
            .timeout(Duration(seconds: 30));
      }
      appStateController.showToast(
          localizationController.localiztionProfileEditScreen().successChange);
      return true;
    });
  }
}
