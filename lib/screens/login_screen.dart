import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Stores stores = Get.put(Stores());

  void onPressLogin({String? type}) async {
    try {
      if (type!.isEmpty) return;
      stores.appStateController.setIsLoading(true, context);
      dynamic res;
      switch (type) {
        case 'kakao':
          res = await stores.authStateController.kakaoLogin();
          break;
        case 'naver':
          res = await stores.authStateController.naverLogin();
          break;
        case 'google':
          res = await stores.authStateController.googleLogin();
          break;
        case 'apple':
          res = await stores.authStateController.appleLogin();
          break;
      }
      if (!context.mounted) return;
      stores.appStateController.setIsLoading(false, context);
      if (res) {
        if (!context.mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
        return;
      }
    } catch (error) {
      stores.appStateController.setIsLoading(false, context);
      if (error ==
          'Error: The email address is already in use by another account.') {
        stores.appStateController.showToast(stores.localizationController
            .localiztionLoginScreen()
            .duplicationEmail);
      } else if (error == 'network Error') {
        stores.appStateController.showToast(stores.localizationController
            .localiztionComponentError()
            .networkError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Obx(() => Scaffold(
              body: Container(
                  decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0, -3),
                end: Alignment(0, 1),
                colors: <Color>[
                  stores.colorController.customColor().defaultBackground2,
                  stores.colorController.customColor().defaultBackground1,
                ],
                tileMode: TileMode.clamp),
          )))),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(children: [
            SizedBox(
                height: stores.appStateController.logicalHeight.value,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: LoginButton(
                            image: AssetImage(
                                'assets/images/loginButton/naver_login.png'),
                            onPress: () => onPressLogin(type: 'naver')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: LoginButton(
                            image: AssetImage(
                                'assets/images/loginButton/kakao_login.png'),
                            onPress: () => onPressLogin(type: 'kakao')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: LoginButton(
                            image: AssetImage(
                                'assets/images/loginButton/google_login.png'),
                            onPress: () => onPressLogin(type: 'google')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: LoginButton(
                            image: AssetImage(
                                'assets/images/loginButton/apple_login.png'),
                            onPress: () => onPressLogin(type: 'apple')),
                      ),
                    ],
                  ),
                ))
          ]))
    ]);
  }
}
