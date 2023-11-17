import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/localization/login_screen_text.dart';
import 'package:gym_calendar/stores/localization/setting_screen_text.dart';
import 'package:gym_calendar/stores/localization/profile_screen_text.dart';
import 'package:gym_calendar/stores/localization/component_error_text.dart';
export 'package:flutter/widgets.dart';

@immutable
class LoginScreenText {
  final String title;
  final String emailLogin;
  final String emailRegist;
  final String setting;

  final String loginError;
  final String duplicationEmail;

  LoginScreenText({
    required this.title,
    required this.emailLogin,
    required this.emailRegist,
    required this.setting,
    required this.loginError,
    required this.duplicationEmail,
  });
}

class ComponentErrorText {
  final String networkError;

  ComponentErrorText({required this.networkError});
}

class SettingScreenText {
  final String title;

  SettingScreenText({
    required this.title,
  });
}

class ProfileScreenText {
  final String title;

  ProfileScreenText({
    required this.title,
  });
}

class LocalizationController extends GetxController {
  RxInt language = 1.obs;

  void changeLanguage(lang) {
    language.value = lang;
  }

  LoginScreenText localiztionLoginScreen() {
    if (language.value == 0) {
      LoginScreenText loginScreenText = LoginScreenText(
          title: LoginScreenTextEn().title,
          emailLogin: LoginScreenTextEn().emailLogin,
          emailRegist: LoginScreenTextEn().emailRegist,
          setting: LoginScreenTextEn().setting,
          loginError: LoginScreenTextEn().loginError,
          duplicationEmail: LoginScreenTextEn().duplicationEmail);
      return loginScreenText;
    } else {
      LoginScreenText loginScreenText = LoginScreenText(
          title: LoginScreenTextKr().title,
          emailLogin: LoginScreenTextKr().emailLogin,
          emailRegist: LoginScreenTextKr().emailRegist,
          setting: LoginScreenTextKr().setting,
          loginError: LoginScreenTextKr().loginError,
          duplicationEmail: LoginScreenTextKr().duplicationEmail);
      return loginScreenText;
    }
  }

  SettingScreenText localiztionSettingScreen() {
    if (language.value == 0) {
      SettingScreenText settingScreenText =
          SettingScreenText(title: SettingScreenTextEn().title);
      return settingScreenText;
    } else {
      SettingScreenText settingScreenText =
          SettingScreenText(title: SettingScreenTextKr().title);
      return settingScreenText;
    }
  }

  ProfileScreenText localiztionProfileScreen() {
    if (language.value == 0) {
      ProfileScreenText profileScreenText =
          ProfileScreenText(title: ProfileScreenTextEn().title);
      return profileScreenText;
    } else {
      ProfileScreenText profileScreenText =
          ProfileScreenText(title: ProfileScreenTextKr().title);
      return profileScreenText;
    }
  }

  ComponentErrorText localiztionComponentError() {
    if (language.value == 0) {
      ComponentErrorText settingScreenText =
          ComponentErrorText(networkError: ComponentErrorTextEn().networkError);
      return settingScreenText;
    } else {
      ComponentErrorText settingScreenText =
          ComponentErrorText(networkError: ComponentErrorTextKr().networkError);
      return settingScreenText;
    }
  }
}
