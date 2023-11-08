import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/source/localization/localization_controller.dart';
import 'package:gym_calendar/widgets/button/login_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LocalizationController controller = Get.put(LocalizationController());

  void onPressEmail() {
    print(controller.language.value);
    if (controller.language.value == 1) {
      controller.changeLanguage(0);
      return;
    }
    controller.changeLanguage(1);
  }

  @override
  Widget build(BuildContext context) {
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
                        onPress: onPressEmail),
                    LoginButton(
                        image:
                            AssetImage('assets/loginButton/google_login.png'),
                        onPress: onPressEmail),
                    LoginButton(
                        image: AssetImage('assets/loginButton/apple_login.png'),
                        onPress: onPressEmail),
                    // Obx(() => Text(
                    //       controller.localiztion().emailLogin,
                    //       style: const TextStyle(fontSize: 20),
                    //     )),
                    // TextButton(
                    //     onPressed: onPressEmail,
                    //     child: Text(
                    //       controller.localiztion().emailLogin,
                    //     ))
                  ],
                ))));
  }
}
