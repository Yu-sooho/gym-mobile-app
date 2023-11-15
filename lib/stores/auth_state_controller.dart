import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'dart:io' show Platform;

class AuthStateController extends GetxController {
  dynamic authState;

  FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());

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
      print('error $error');
      return false;
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
      return false;
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
        }
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }
        try {
          final res = await UserApi.instance.loginWithKakaoAccount();
          if (res.accessToken.isNotEmpty) {
            User user = await UserApi.instance.me();
            final firebaseRes = await firebaseAuthController.kakaoLoginFirebase(
                user, res.accessToken);
            if (!firebaseRes) return false;
          }
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return false;
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
        }
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return false;
      }
    }
    return false;
  }

  Future<bool> naverLogin() async {
    NaverLoginResult resLogin = await FlutterNaverLogin.logIn();
    final NaverLoginResult result = await FlutterNaverLogin.logIn();
    NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;

    print(resLogin);

    return true;
  }
}
