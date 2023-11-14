import 'dart:convert';
import 'package:get/get.dart';
import 'package:gym_calendar/store/package_stores.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
}
