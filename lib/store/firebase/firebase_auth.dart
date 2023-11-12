import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthController extends GetxController {
  dynamic authState;

  void addAuthEventListener() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      authState = user;
      print('FirebaseAuthController addAuthEventListener $user');
    });
  }

  void appleLogin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'de.lunaone.flutter.signinwithappleexample.service',
          redirectUri: Uri.parse(
              'https://shocking-right-calliandra.glitch.me/callbacks/sign_in_with_apple')),
      nonce: 'example-nonce',
      state: 'example-state',
    );

    // ignore: avoid_print
    print(credential);

    final signInWithAppleEndpoint = Uri(
      scheme: 'https',
      host: 'flutter-sign-in-with-apple-example.glitch.me',
      path: '/sign_in_with_apple',
      queryParameters: <String, String>{
        'code': credential.authorizationCode,
        if (credential.givenName != null) 'firstName': credential.givenName!,
        if (credential.familyName != null) 'lastName': credential.familyName!,
        'useBundleId': (Platform.isIOS || Platform.isMacOS) ? 'true' : 'false',
        if (credential.state != null) 'state': credential.state!,
      },
    );

    print(signInWithAppleEndpoint);
  }
}
