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
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final AuthStateController authController = Get.put(AuthStateController());
  final CustomColorController customColorController =
      Get.put(CustomColorController());
  final AppStateController appStateController = Get.put(AppStateController());

  void onPressLogin({String? type}) async {
    try {
      if (type!.isEmpty) return;
      appStateController.setIsLoading(true, context);
      dynamic res;
      switch (type) {
        case 'kakao':
          res = await authController.kakaoLogin();
          break;
        case 'naver':
          res = await authController.naverLogin();
          break;
        case 'google':
          res = await authController.googleLogin();
          break;
        case 'apple':
          res = await authController.appleLogin();
          break;
      }
      if (!context.mounted) return;
      appStateController.setIsLoading(false, context);
      if (res) {
        if (!context.mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
        return;
      }
      appStateController.showToast(
          localizationController.localiztionLoginScreen().loginError);
    } catch (error) {
      appStateController.setIsLoading(false, context);
      if (error ==
          'Error: The email address is already in use by another account.') {
        appStateController.showToast(
            localizationController.localiztionLoginScreen().duplicationEmail);
      } else if (error == 'network Error') {
        appStateController.showToast(
            localizationController.localiztionComponentError().networkError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: customColorController.customColor().defaultBackground,
          ),
          child: Align(
              alignment: Alignment(0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(50),
                    child: Icon(
                      Icons.beach_access,
                      color: Colors.white,
                      size: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: LoginButton(
                        image: AssetImage('assets/loginButton/kakao_login.png'),
                        onPress: () => onPressLogin(type: 'naver')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: LoginButton(
                        image: AssetImage('assets/loginButton/kakao_login.png'),
                        onPress: () => onPressLogin(type: 'kakao')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: LoginButton(
                        image:
                            AssetImage('assets/loginButton/google_login.png'),
                        onPress: () => onPressLogin(type: 'google')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: LoginButton(
                        image: AssetImage('assets/loginButton/apple_login.png'),
                        onPress: () => onPressLogin(type: 'apple')),
                  ),
                ],
              ))),
    ));
  }
}
