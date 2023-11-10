import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/source/localization/localization_controller.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LocalizationController controller = Get.put(LocalizationController());
  @override
  Widget build(BuildContext context) {
    void onPressKakao() {
      print('카카오로 로그인');
    }

    void onPressApple() {
      print('애플로 로그인');
    }

    void onPressGoogle() {
      print('구글로 로그인');
    }

    void onPressEmail() {
      if (controller.language.value == 1) {
        controller.changeLanguage(0);
        return;
      }
      controller.changeLanguage(1);
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
                        onPress: onPressKakao),
                    LoginButton(
                        image:
                            AssetImage('assets/loginButton/google_login.png'),
                        onPress: onPressGoogle),
                    LoginButton(
                        image: AssetImage('assets/loginButton/apple_login.png'),
                        onPress: onPressApple),
                    Obx(() => InkWell(
                          onTap: onPressEmail,
                          child: Container(
                            width: 320,
                            height: 28,
                            margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            alignment: Alignment.center,
                            child: Text(
                              controller.localiztionLoginScreen().emailLogin,
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
                              controller.localiztionLoginScreen().emailRegist,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.blueGrey),
                            ),
                          ),
                        )),
                    Obx(() => InkWell(
                          onTap: onPressSetting,
                          child: Container(
                            width: 320,
                            height: 28,
                            alignment: Alignment.center,
                            child: Text(
                              controller.localiztionLoginScreen().setting,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.blueGrey),
                            ),
                          ),
                        )),
                  ],
                ))));
  }
}
