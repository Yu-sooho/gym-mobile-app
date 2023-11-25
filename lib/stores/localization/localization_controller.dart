import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/localization/component_button_text.dart';
import 'package:gym_calendar/stores/localization/home_screen_text.dart';
import 'package:gym_calendar/stores/localization/login_screen_text.dart';
import 'package:gym_calendar/stores/localization/modal_screen_text.dart';
import 'package:gym_calendar/stores/localization/profile_edit_screen_text.dart';
import 'package:gym_calendar/stores/localization/setting_screen_text.dart';
import 'package:gym_calendar/stores/localization/profile_screen_text.dart';
import 'package:gym_calendar/stores/localization/component_error_text.dart';
import 'package:gym_calendar/stores/localization/theme_screen.dart';
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

class ComponentButtonText {
  final String save;

  ComponentButtonText({required this.save});
}

class SettingScreenText {
  final String title;
  final String exerciseAlarm;
  final String scheduleAlarm;

  final String exerciseAlarmCancelToast;
  final String scheduleAlarmCancelToast;
  final String exerciseAlarmToast;
  final String scheduleAlarmToast;

  SettingScreenText({
    required this.title,
    required this.exerciseAlarm,
    required this.scheduleAlarm,
    required this.exerciseAlarmCancelToast,
    required this.scheduleAlarmCancelToast,
    required this.exerciseAlarmToast,
    required this.scheduleAlarmToast,
  });
}

class ProfileScreenText {
  final String title;
  final String edit;
  final String setting;
  final String inquiry;
  final String theme;
  final String logout;
  ProfileScreenText(
      {required this.title,
      required this.edit,
      required this.setting,
      required this.theme,
      required this.inquiry,
      required this.logout});
}

class ProfileEditScreenText {
  final String title;
  final String nickName;
  final String save;
  final String errorNickName;
  final String errorDescription;
  ProfileEditScreenText(
      {required this.title,
      required this.nickName,
      required this.errorNickName,
      required this.errorDescription,
      required this.save});
}

class HomeScreenText {
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  HomeScreenText({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
  });
}

class ModalScreenText {
  final String ok;
  final String cancel;

  final String logoutTitle;
  final String logoutText;

  final String themeChangeTitle;
  final String themeChangeText;

  ModalScreenText(
      {required this.ok,
      required this.cancel,
      required this.logoutTitle,
      required this.logoutText,
      required this.themeChangeText,
      required this.themeChangeTitle});
}

class ThemeScreenText {
  final String title;
  final String colorTitle;
  final String fontTitle;
  final String languageTitle;

  final List<String> colorName;
  final List<String> fontName;
  final List<String> languageName;

  ThemeScreenText(
      {required this.title,
      required this.fontTitle,
      required this.colorTitle,
      required this.languageTitle,
      required this.colorName,
      required this.fontName,
      required this.languageName});
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
      SettingScreenText settingScreenText = SettingScreenText(
          title: SettingScreenTextEn().title,
          scheduleAlarm: SettingScreenTextEn().scheduleAlarm,
          exerciseAlarm: SettingScreenTextEn().exerciseAlarm,
          scheduleAlarmToast: SettingScreenTextEn().scheduleAlarmToast,
          exerciseAlarmToast: SettingScreenTextEn().exerciseAlarmToast,
          scheduleAlarmCancelToast:
              SettingScreenTextEn().scheduleAlarmCancelToast,
          exerciseAlarmCancelToast:
              SettingScreenTextEn().exerciseAlarmCancelToast);
      return settingScreenText;
    } else {
      SettingScreenText settingScreenText = SettingScreenText(
          title: SettingScreenTextKr().title,
          scheduleAlarm: SettingScreenTextKr().scheduleAlarm,
          exerciseAlarm: SettingScreenTextKr().exerciseAlarm,
          scheduleAlarmToast: SettingScreenTextKr().scheduleAlarmToast,
          exerciseAlarmToast: SettingScreenTextKr().exerciseAlarmToast,
          scheduleAlarmCancelToast:
              SettingScreenTextKr().scheduleAlarmCancelToast,
          exerciseAlarmCancelToast:
              SettingScreenTextKr().exerciseAlarmCancelToast);
      return settingScreenText;
    }
  }

  ProfileScreenText localiztionProfileScreen() {
    if (language.value == 0) {
      ProfileScreenText profileScreenText = ProfileScreenText(
          title: ProfileScreenTextEn().title,
          edit: ProfileScreenTextEn().edit,
          setting: ProfileScreenTextEn().setting,
          theme: ProfileScreenTextEn().theme,
          inquiry: ProfileScreenTextEn().inquiry,
          logout: ProfileScreenTextEn().logout);
      return profileScreenText;
    } else {
      ProfileScreenText profileScreenText = ProfileScreenText(
          title: ProfileScreenTextKr().title,
          edit: ProfileScreenTextKr().edit,
          setting: ProfileScreenTextKr().setting,
          theme: ProfileScreenTextKr().theme,
          inquiry: ProfileScreenTextKr().inquiry,
          logout: ProfileScreenTextKr().logout);
      return profileScreenText;
    }
  }

  ProfileEditScreenText localiztionProfileEditScreen() {
    if (language.value == 0) {
      ProfileEditScreenText profileEditScreenText = ProfileEditScreenText(
        title: ProfileEditScreenTextEn().title,
        nickName: ProfileEditScreenTextEn().nickName,
        save: ProfileEditScreenTextEn().save,
        errorNickName: ProfileEditScreenTextEn().errorNickName,
        errorDescription: ProfileEditScreenTextEn().errorDescription,
      );
      return profileEditScreenText;
    } else {
      ProfileEditScreenText profileEditScreenText = ProfileEditScreenText(
        title: ProfileEditScreenTextKr().title,
        nickName: ProfileEditScreenTextKr().nickName,
        save: ProfileEditScreenTextKr().save,
        errorNickName: ProfileEditScreenTextKr().errorNickName,
        errorDescription: ProfileEditScreenTextKr().errorDescription,
      );
      return profileEditScreenText;
    }
  }

  ThemeScreenText localiztionThemeScreen() {
    if (language.value == 0) {
      ThemeScreenText settingScreenText = ThemeScreenText(
          title: ThemeScreenTextEn().title,
          colorTitle: ThemeScreenTextEn().colorTitle,
          fontTitle: ThemeScreenTextEn().fontTitle,
          languageTitle: ThemeScreenTextEn().languageTitle,
          languageName: ThemeScreenTextEn().languageName,
          colorName: ThemeScreenTextEn().colorName,
          fontName: ThemeScreenTextEn().fontName);
      return settingScreenText;
    } else {
      ThemeScreenText settingScreenText = ThemeScreenText(
          title: ThemeScreenTextKr().title,
          colorTitle: ThemeScreenTextKr().colorTitle,
          fontTitle: ThemeScreenTextKr().fontTitle,
          languageTitle: ThemeScreenTextKr().languageTitle,
          languageName: ThemeScreenTextKr().languageName,
          colorName: ThemeScreenTextKr().colorName,
          fontName: ThemeScreenTextKr().fontName);
      return settingScreenText;
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

  ComponentButtonText localiztionComponentButton() {
    if (language.value == 0) {
      ComponentButtonText localiztionButtonText =
          ComponentButtonText(save: ComponentButtonTextEn().save);
      return localiztionButtonText;
    } else {
      ComponentButtonText localiztionButtonText =
          ComponentButtonText(save: ComponentButtonTextKr().save);
      return localiztionButtonText;
    }
  }

  ModalScreenText localiztionModalScreenText() {
    if (language.value == 0) {
      ModalScreenText modalScreenText = ModalScreenText(
          ok: ModalScreenTextEn().ok,
          cancel: ModalScreenTextEn().cancel,
          logoutText: ModalScreenTextEn().logoutText,
          logoutTitle: ModalScreenTextEn().logoutTitle,
          themeChangeTitle: ModalScreenTextEn().themeChangeTitle,
          themeChangeText: ModalScreenTextEn().themeChangeText);
      return modalScreenText;
    } else {
      ModalScreenText modalScreenText = ModalScreenText(
          ok: ModalScreenTextKr().ok,
          cancel: ModalScreenTextKr().cancel,
          logoutText: ModalScreenTextKr().logoutText,
          logoutTitle: ModalScreenTextKr().logoutTitle,
          themeChangeTitle: ModalScreenTextKr().themeChangeTitle,
          themeChangeText: ModalScreenTextKr().themeChangeText);
      return modalScreenText;
    }
  }

  HomeScreenText localiztionHomeScreen() {
    if (language.value == 0) {
      HomeScreenText settingScreenText = HomeScreenText(
          title1: HomeScreenTextEn().title1,
          title2: HomeScreenTextEn().title2,
          title3: HomeScreenTextEn().title3,
          title4: HomeScreenTextEn().title4);
      return settingScreenText;
    } else {
      HomeScreenText settingScreenText = HomeScreenText(
          title1: HomeScreenTextKr().title1,
          title2: HomeScreenTextKr().title2,
          title3: HomeScreenTextKr().title3,
          title4: HomeScreenTextKr().title4);
      return settingScreenText;
    }
  }
}
