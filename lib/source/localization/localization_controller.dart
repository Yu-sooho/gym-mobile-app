import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/source/localization/login_screen_text.dart';
export 'package:flutter/widgets.dart';

@immutable
class LoginScreenText {
  final String title;
  final String emailLogin;
  final String emailRegist;
  final String setting;

  LoginScreenText({
    required this.title,
    required this.emailLogin,
    required this.emailRegist,
    required this.setting,
  });
}

class LocalizationController extends GetxController {
  RxInt language = 0.obs;

  void changeLanguage(lang) {
    language.value = lang;
  }

  LoginScreenText localiztion() {
    if (language.value == 0) {
      LoginScreenText loginScreenText = LoginScreenText(
          title: LoginScreenTextEn().title,
          emailLogin: LoginScreenTextEn().emailLogin,
          emailRegist: LoginScreenTextEn().emailRegist,
          setting: LoginScreenTextEn().setting);

      return loginScreenText;
    } else {
      LoginScreenText loginScreenText = LoginScreenText(
          title: LoginScreenTextKr().title,
          emailLogin: LoginScreenTextKr().emailLogin,
          emailRegist: LoginScreenTextKr().emailRegist,
          setting: LoginScreenTextKr().setting);

      return loginScreenText;
    }
  }
}
