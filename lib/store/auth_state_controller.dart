import 'dart:convert';
import 'package:get/get.dart';
import 'package:gym_calendar/store/package_stores.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';

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
      // Math math = Math();
      // final token = math.parseJwtPayLoad('${credential.identityToken}');
      // print(token);
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

  void appleLogout(credential) async {}
}
