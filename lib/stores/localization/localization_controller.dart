import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/localization/login_screen_text.dart';
import 'package:gym_calendar/stores/localization/modal_screen_text.dart';
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
  final String edit;
  final String setting;
  final String inquiry;
  final String logout;
  ProfileScreenText(
      {required this.title,
      required this.edit,
      required this.setting,
      required this.inquiry,
      required this.logout});
}

class ModalScreenText {
  final String ok;
  final String cancel;

  final String logoutTitle;
  final String logoutText;

  ModalScreenText(
      {required this.ok,
      required this.cancel,
      required this.logoutTitle,
      required this.logoutText});
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
      ProfileScreenText profileScreenText = ProfileScreenText(
          title: ProfileScreenTextEn().title,
          edit: ProfileScreenTextEn().edit,
          setting: ProfileScreenTextEn().setting,
          inquiry: ProfileScreenTextEn().inquiry,
          logout: ProfileScreenTextEn().logout);
      return profileScreenText;
    } else {
      ProfileScreenText profileScreenText = ProfileScreenText(
          title: ProfileScreenTextKr().title,
          edit: ProfileScreenTextKr().edit,
          setting: ProfileScreenTextKr().setting,
          inquiry: ProfileScreenTextKr().inquiry,
          logout: ProfileScreenTextKr().logout);
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

  ModalScreenText localiztionModalScreenText() {
    if (language.value == 0) {
      ModalScreenText modalScreenText = ModalScreenText(
          ok: ModalScreenTextEn().ok,
          cancel: ModalScreenTextEn().cancel,
          logoutText: ModalScreenTextEn().logoutText,
          logoutTitle: ModalScreenTextEn().logoutTitle);
      return modalScreenText;
    } else {
      ModalScreenText modalScreenText = ModalScreenText(
          ok: ModalScreenTextKr().ok,
          cancel: ModalScreenTextKr().cancel,
          logoutText: ModalScreenTextKr().logoutText,
          logoutTitle: ModalScreenTextKr().logoutTitle);
      return modalScreenText;
    }
  }
}
