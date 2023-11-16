import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  void onPressLogin({String? type}) async {
    try {
      if (type!.isEmpty) return;
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
      if (res) {
        if (!context.mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
        return;
      }
      Fluttertoast.showToast(
          msg: localizationController.localiztionLoginScreen().loginError,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (error) {
      String errorMessage =
          localizationController.localiztionLoginScreen().loginError;
      if (error ==
          'Error: The email address is already in use by another account.') {
        errorMessage =
            localizationController.localiztionLoginScreen().duplicationEmail;
      }
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    void onPressEmail() {
      if (localizationController.language.value == 1) {
        localizationController.changeLanguage(0);
        return;
      }
      localizationController.changeLanguage(1);
    }

    void onPressRegistEmail() {}

    void onPressSetting() {
      Navigator.of(context).pushNamed('/setting');
    }

    return Scaffold(
        body: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.black87,
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
                    LoginButton(
                        image: AssetImage('assets/loginButton/kakao_login.png'),
                        onPress: () => onPressLogin(type: 'naver')),
                    LoginButton(
                        image: AssetImage('assets/loginButton/kakao_login.png'),
                        onPress: () => onPressLogin(type: 'kakao')),
                    LoginButton(
                        image:
                            AssetImage('assets/loginButton/google_login.png'),
                        onPress: () => onPressLogin(type: 'google')),
                    LoginButton(
                        image: AssetImage('assets/loginButton/apple_login.png'),
                        onPress: () => onPressLogin(type: 'apple')),
                    Obx(() => InkWell(
                          onTap: onPressEmail,
                          child: Container(
                            width: 320,
                            height: 28,
                            margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            alignment: Alignment.center,
                            child: Text(
                              localizationController
                                  .localiztionLoginScreen()
                                  .emailLogin,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.blueGrey),
                            ),
                          ),
                        )),
                    Obx(() => InkWell(
                          onTap: onPressRegistEmail,
                          child: Container(
                            width: 320,
                            height: 28,
                            alignment: Alignment.center,
                            child: Text(
                              localizationController
                                  .localiztionLoginScreen()
                                  .emailRegist,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.blueGrey),
                            ),
                          ),
                        )),
                    Obx(() => CustomButton(
                          onPress: onPressSetting,
                          child: Container(
                            width: 320,
                            height: 28,
                            alignment: Alignment.center,
                            child: Text(
                              localizationController
                                  .localiztionLoginScreen()
                                  .setting,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.blueGrey),
                            ),
                          ),
                        ))
                  ],
                ))));
  }
}
