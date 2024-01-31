import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/localization/component_button_text.dart';
import 'package:gym_calendar/stores/localization/exercise_add_screen_text.dart';
import 'package:gym_calendar/stores/localization/exercise_screen_text.dart';
import 'package:gym_calendar/stores/localization/home_screen_text.dart';
import 'package:gym_calendar/stores/localization/inquiry_screen_text.dart';
import 'package:gym_calendar/stores/localization/login_screen_text.dart';
import 'package:gym_calendar/stores/localization/modal_screen_text.dart';
import 'package:gym_calendar/stores/localization/profile_edit_screen_text.dart';
import 'package:gym_calendar/stores/localization/routine_add_screen_text.dart';
import 'package:gym_calendar/stores/localization/routine_screen_text.dart';
import 'package:gym_calendar/stores/localization/setting_screen_text.dart';
import 'package:gym_calendar/stores/localization/profile_screen_text.dart';
import 'package:gym_calendar/stores/localization/component_error_text.dart';
import 'package:gym_calendar/stores/localization/theme_screen.dart';

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
  final String inquiry;

  ComponentButtonText({required this.save, required this.inquiry});
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

  final String successChange;
  final String errorChange;
  ProfileEditScreenText(
      {required this.title,
      required this.nickName,
      required this.errorNickName,
      required this.errorDescription,
      required this.successChange,
      required this.errorChange,
      required this.save});
}

class ExerciseAddScreenText {
  final String title;
  final String inputTitle;
  final String inputTitlePlaceholder;
  final String partPlaceholder;
  final String partName;
  final String addExercise;
  final String add;
  final String success;
  final String latestSort;
  final String alreadyPart;
  final String maxPart;
  final String noExercise;
  final String successDelete;
  final String errorDelete;
  ExerciseAddScreenText({
    required this.title,
    required this.inputTitle,
    required this.inputTitlePlaceholder,
    required this.partPlaceholder,
    required this.partName,
    required this.addExercise,
    required this.add,
    required this.success,
    required this.latestSort,
    required this.alreadyPart,
    required this.maxPart,
    required this.noExercise,
    required this.successDelete,
    required this.errorDelete,
  });
}

class InquiryScreenText {
  final String title;
  final String inquiry;
  final String inquiryList;

  final String inquiryTitlePlaceholder;
  final String inquiryContentPlaceholder;

  final String errorTitle;
  final String errorContent;
  InquiryScreenText(
      {required this.title,
      required this.inquiry,
      required this.inquiryList,
      required this.inquiryTitlePlaceholder,
      required this.inquiryContentPlaceholder,
      required this.errorTitle,
      required this.errorContent});
}

class HomeScreenText {
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final String title5;
  HomeScreenText(
      {required this.title1,
      required this.title2,
      required this.title3,
      required this.title4,
      required this.title5});
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

  final String errorFontSizePlus;
  final String errorFontSizeMinus;

  ThemeScreenText({
    required this.title,
    required this.fontTitle,
    required this.colorTitle,
    required this.languageTitle,
    required this.colorName,
    required this.fontName,
    required this.languageName,
    required this.errorFontSizePlus,
    required this.errorFontSizeMinus,
  });
}

class RoutineScreenText {
  final String inputTitle;
  final String inputTitlePlaceholder;
  final String addRoutine;
  final String routineName;
  final String latestSort;
  final String routineCycle;
  final String date;

  RoutineScreenText(
      {required this.inputTitle,
      required this.inputTitlePlaceholder,
      required this.addRoutine,
      required this.routineName,
      required this.routineCycle,
      required this.latestSort,
      required this.date});
}

class RoutineAddScreenText {
  final String title;
  final String inputTitle;
  final String inputTitlePlaceholder;
  final String exercisePlaceholder;
  final String add;
  final String success;
  final String latestSort;
  final String maxExercise;
  final String noRoutine;
  final String successDelete;
  final String errorDelete;
  RoutineAddScreenText({
    required this.title,
    required this.inputTitle,
    required this.inputTitlePlaceholder,
    required this.exercisePlaceholder,
    required this.add,
    required this.success,
    required this.latestSort,
    required this.maxExercise,
    required this.noRoutine,
    required this.successDelete,
    required this.errorDelete,
  });
}

class ExerciseScreenText {
  final String inputTitle;

  final String addExercise;
  final String add;

  final String latestSort;
  final String noExercise;
  final String maxPart;

  final String errorDelete;
  final String successDelete;

  ExerciseScreenText({
    required this.inputTitle,
    required this.addExercise,
    required this.add,
    required this.latestSort,
    required this.noExercise,
    required this.maxPart,
    required this.errorDelete,
    required this.successDelete,
  });
}

class LocalizationController extends GetxController {
  final storage = FlutterSecureStorage();
  RxInt language = 1.obs;

  Future<bool> changeLanguage(lang) async {
    try {
      await storage.write(key: 'language', value: '$lang');
      language.value = lang;
      return true;
    } catch (error) {
      print('changeLanguage $error');
      return false;
    }
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
          successChange: ProfileEditScreenTextEn().successChange,
          errorChange: ProfileEditScreenTextEn().errorChange);
      return profileEditScreenText;
    } else {
      ProfileEditScreenText profileEditScreenText = ProfileEditScreenText(
          title: ProfileEditScreenTextKr().title,
          nickName: ProfileEditScreenTextKr().nickName,
          save: ProfileEditScreenTextKr().save,
          errorNickName: ProfileEditScreenTextKr().errorNickName,
          errorDescription: ProfileEditScreenTextKr().errorDescription,
          successChange: ProfileEditScreenTextKr().successChange,
          errorChange: ProfileEditScreenTextKr().errorChange);
      return profileEditScreenText;
    }
  }

  InquiryScreenText localiztionInquiryScreen() {
    if (language.value == 0) {
      InquiryScreenText inquiryScreenText = InquiryScreenText(
          title: InquiryScreenTextEn().title,
          inquiry: InquiryScreenTextEn().inquiry,
          inquiryList: InquiryScreenTextEn().inquiryList,
          inquiryTitlePlaceholder:
              InquiryScreenTextEn().inquiryTitlePlaceholder,
          inquiryContentPlaceholder:
              InquiryScreenTextEn().inquiryContentPlaceholder,
          errorTitle: InquiryScreenTextEn().errorTitle,
          errorContent: InquiryScreenTextEn().errorContent);
      return inquiryScreenText;
    } else {
      InquiryScreenText inquiryScreenText = InquiryScreenText(
          title: InquiryScreenTextKr().title,
          inquiry: InquiryScreenTextKr().inquiry,
          inquiryList: InquiryScreenTextKr().inquiryList,
          inquiryTitlePlaceholder:
              InquiryScreenTextKr().inquiryTitlePlaceholder,
          inquiryContentPlaceholder:
              InquiryScreenTextKr().inquiryContentPlaceholder,
          errorTitle: InquiryScreenTextKr().errorTitle,
          errorContent: InquiryScreenTextKr().errorContent);
      return inquiryScreenText;
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
          errorFontSizePlus: ThemeScreenTextEn().errorFontSizePlus,
          errorFontSizeMinus: ThemeScreenTextEn().errorFontSizeMinus,
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
          errorFontSizePlus: ThemeScreenTextKr().errorFontSizePlus,
          errorFontSizeMinus: ThemeScreenTextKr().errorFontSizeMinus,
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
      ComponentButtonText localiztionButtonText = ComponentButtonText(
        save: ComponentButtonTextEn().save,
        inquiry: ComponentButtonTextEn().inquiry,
      );
      return localiztionButtonText;
    } else {
      ComponentButtonText localiztionButtonText = ComponentButtonText(
          save: ComponentButtonTextKr().save,
          inquiry: ComponentButtonTextKr().inquiry);
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
          title4: HomeScreenTextEn().title4,
          title5: HomeScreenTextEn().title5);
      return settingScreenText;
    } else {
      HomeScreenText settingScreenText = HomeScreenText(
          title1: HomeScreenTextKr().title1,
          title2: HomeScreenTextKr().title2,
          title3: HomeScreenTextKr().title3,
          title4: HomeScreenTextKr().title4,
          title5: HomeScreenTextKr().title5);
      return settingScreenText;
    }
  }

  RoutineScreenText localiztionRoutineScreen() {
    if (language.value == 0) {
      RoutineScreenText routineScreenText = RoutineScreenText(
          inputTitle: RoutineScreenTextEn().inputTitle,
          inputTitlePlaceholder: RoutineScreenTextEn().inputTitlePlaceholder,
          addRoutine: RoutineScreenTextEn().addRoutine,
          routineName: RoutineScreenTextEn().routineName,
          latestSort: RoutineScreenTextEn().latestSort,
          routineCycle: RoutineScreenTextEn().routineCycle,
          date: RoutineScreenTextEn().date);
      return routineScreenText;
    } else {
      RoutineScreenText routineScreenText = RoutineScreenText(
          inputTitle: RoutineScreenTextKr().inputTitle,
          inputTitlePlaceholder: RoutineScreenTextKr().inputTitlePlaceholder,
          addRoutine: RoutineScreenTextKr().addRoutine,
          routineName: RoutineScreenTextKr().routineName,
          latestSort: RoutineScreenTextKr().latestSort,
          routineCycle: RoutineScreenTextKr().routineCycle,
          date: RoutineScreenTextKr().date);
      return routineScreenText;
    }
  }

  ExerciseScreenText localiztionExerciseScreen() {
    if (language.value == 0) {
      ExerciseScreenText exerciseScreenText = ExerciseScreenText(
          inputTitle: ExerciseScreenTextEn().inputTitle,
          addExercise: ExerciseScreenTextEn().addExercise,
          add: ExerciseScreenTextEn().add,
          latestSort: ExerciseScreenTextEn().latestSort,
          noExercise: ExerciseScreenTextKr().noExercise,
          maxPart: ExerciseScreenTextEn().maxPart,
          errorDelete: ExerciseScreenTextEn().errorDelete,
          successDelete: ExerciseScreenTextEn().successDelete);
      return exerciseScreenText;
    } else {
      ExerciseScreenText exerciseScreenText = ExerciseScreenText(
          inputTitle: ExerciseScreenTextKr().inputTitle,
          addExercise: ExerciseScreenTextKr().addExercise,
          add: ExerciseScreenTextKr().add,
          latestSort: ExerciseScreenTextKr().latestSort,
          noExercise: ExerciseScreenTextKr().noExercise,
          maxPart: ExerciseScreenTextKr().maxPart,
          errorDelete: ExerciseScreenTextEn().errorDelete,
          successDelete: ExerciseScreenTextEn().successDelete);
      return exerciseScreenText;
    }
  }

  ExerciseAddScreenText localiztionExerciseAddScreen() {
    if (language.value == 0) {
      ExerciseAddScreenText exerciseAddScreenText = ExerciseAddScreenText(
        title: ExerciseAddScreenTextEn().title,
        inputTitle: ExerciseAddScreenTextEn().inputTitle,
        inputTitlePlaceholder: ExerciseAddScreenTextEn().inputTitlePlaceholder,
        partPlaceholder: ExerciseAddScreenTextEn().partPlaceholder,
        partName: ExerciseAddScreenTextEn().partName,
        addExercise: ExerciseAddScreenTextEn().addExercise,
        add: ExerciseAddScreenTextEn().add,
        success: ExerciseAddScreenTextEn().success,
        latestSort: ExerciseAddScreenTextEn().latestSort,
        alreadyPart: ExerciseAddScreenTextEn().alreadyPart,
        maxPart: ExerciseAddScreenTextEn().maxPart,
        noExercise: ExerciseAddScreenTextEn().noExercise,
        successDelete: ExerciseAddScreenTextEn().successDelete,
        errorDelete: ExerciseAddScreenTextEn().errorDelete,
      );
      return exerciseAddScreenText;
    } else {
      ExerciseAddScreenText exerciseAddScreenText = ExerciseAddScreenText(
        title: ExerciseAddScreenTextKr().title,
        inputTitle: ExerciseAddScreenTextKr().inputTitle,
        inputTitlePlaceholder: ExerciseAddScreenTextKr().inputTitlePlaceholder,
        partPlaceholder: ExerciseAddScreenTextKr().partPlaceholder,
        partName: ExerciseAddScreenTextKr().partName,
        addExercise: ExerciseAddScreenTextKr().addExercise,
        add: ExerciseAddScreenTextKr().add,
        success: ExerciseAddScreenTextKr().success,
        latestSort: ExerciseAddScreenTextKr().latestSort,
        alreadyPart: ExerciseAddScreenTextKr().alreadyPart,
        maxPart: ExerciseAddScreenTextKr().maxPart,
        noExercise: ExerciseAddScreenTextKr().noExercise,
        successDelete: ExerciseAddScreenTextKr().successDelete,
        errorDelete: ExerciseAddScreenTextKr().errorDelete,
      );
      return exerciseAddScreenText;
    }
  }

  RoutineAddScreenText localiztionRoutineAddScreen() {
    if (language.value == 0) {
      RoutineAddScreenText routineAddScreenText = RoutineAddScreenText(
        title: RoutineAddScreenTextEn().title,
        inputTitle: RoutineAddScreenTextEn().inputTitle,
        inputTitlePlaceholder: RoutineAddScreenTextEn().inputTitlePlaceholder,
        exercisePlaceholder: RoutineAddScreenTextEn().exercisePlaceholder,
        add: RoutineAddScreenTextEn().add,
        success: RoutineAddScreenTextEn().success,
        latestSort: RoutineAddScreenTextEn().latestSort,
        maxExercise: RoutineAddScreenTextEn().maxExercise,
        noRoutine: RoutineAddScreenTextEn().noRoutine,
        successDelete: RoutineAddScreenTextEn().successDelete,
        errorDelete: RoutineAddScreenTextEn().errorDelete,
      );
      return routineAddScreenText;
    } else {
      RoutineAddScreenText routineAddScreenText = RoutineAddScreenText(
        title: RoutineAddScreenTextKr().title,
        inputTitle: RoutineAddScreenTextKr().inputTitle,
        inputTitlePlaceholder: RoutineAddScreenTextKr().inputTitlePlaceholder,
        exercisePlaceholder: RoutineAddScreenTextKr().exercisePlaceholder,
        add: RoutineAddScreenTextKr().add,
        success: RoutineAddScreenTextKr().success,
        latestSort: RoutineAddScreenTextKr().latestSort,
        maxExercise: RoutineAddScreenTextKr().maxExercise,
        noRoutine: RoutineAddScreenTextKr().noRoutine,
        successDelete: RoutineAddScreenTextKr().successDelete,
        errorDelete: RoutineAddScreenTextKr().errorDelete,
      );
      return routineAddScreenText;
    }
  }
}
