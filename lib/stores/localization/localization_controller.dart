import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_calendar/stores/localization/component_button_text.dart';
import 'package:gym_calendar/stores/localization/exercise_add_screen_text.dart';
import 'package:gym_calendar/stores/localization/exercise_screen_text.dart';
import 'package:gym_calendar/stores/localization/home_screen_text.dart';
import 'package:gym_calendar/stores/localization/inquiry_screen_text.dart';
import 'package:gym_calendar/stores/localization/login_screen_text.dart';
import 'package:gym_calendar/stores/localization/modal_screen_text.dart';
import 'package:gym_calendar/stores/localization/profile_edit_screen_text.dart';
import 'package:gym_calendar/stores/localization/routine_add_screen_text.dart';
import 'package:gym_calendar/stores/localization/routine_cycle_screen_text.dart';
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
  final String noSearchData;

  ComponentErrorText({required this.networkError, required this.noSearchData});
}

class ComponentButtonText {
  final String save;
  final String inquiry;
  final String latest;
  final String oldest;
  final String startDatest;
  final String endDatest;
  final String name;
  final String addToday;
  final String searchPlaceholder;
  final String add;
  final String delete;
  final String edit;
  final String complete;

  ComponentButtonText(
      {required this.save,
      required this.inquiry,
      required this.latest,
      required this.oldest,
      required this.endDatest,
      required this.startDatest,
      required this.addToday,
      required this.name,
      required this.searchPlaceholder,
      required this.add,
      required this.delete,
      required this.edit,
      required this.complete});
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
  final String muscleSuccess;
  final String alreadyPart;
  final String maxPart;
  final String noExercise;
  final String successDelete;
  final String errorDelete;
  final String weight;
  final String nowWeight;
  final String targetWeight;
  final String addMuscle;
  final String noMuscle;
  final String errorWeight;
  final String part;
  final String editSuccess;

  ExerciseAddScreenText(
      {required this.title,
      required this.inputTitle,
      required this.inputTitlePlaceholder,
      required this.partPlaceholder,
      required this.partName,
      required this.addExercise,
      required this.add,
      required this.success,
      required this.muscleSuccess,
      required this.alreadyPart,
      required this.maxPart,
      required this.noExercise,
      required this.successDelete,
      required this.errorDelete,
      required this.weight,
      required this.nowWeight,
      required this.targetWeight,
      required this.addMuscle,
      required this.noMuscle,
      required this.errorWeight,
      required this.part,
      required this.editSuccess});
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

  final String deleteRoutine;
  final String deleteExercise;
  final String deleteMuscle;

  final String delete;

  ModalScreenText(
      {required this.ok,
      required this.cancel,
      required this.logoutTitle,
      required this.logoutText,
      required this.themeChangeText,
      required this.themeChangeTitle,
      required this.delete,
      required this.deleteRoutine,
      required this.deleteExercise,
      required this.deleteMuscle});
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
  final String routineCycle;
  final String date;
  final String noRoutine;

  RoutineScreenText(
      {required this.inputTitle,
      required this.inputTitlePlaceholder,
      required this.addRoutine,
      required this.routineName,
      required this.routineCycle,
      required this.date,
      required this.noRoutine});
}

class RoutineAddScreenText {
  final String title;
  final String editTitle;
  final String inputTitle;
  final String inputTitlePlaceholder;
  final String exercisePlaceholder;
  final String success;
  final String editSuccess;
  final String maxExercise;
  final String noRoutine;
  final String successDelete;
  final String errorDelete;
  final String cycle;
  final String repeat;
  final String cycleDate;
  final String exerciseListCheck;
  final String exercise;
  final String errorCycle;
  final String cycleDes;
  final String repeatDes;
  final String startDate;
  final String endDate;
  final String selectedDate;
  final String dateFormat;
  final String executionCount;
  final String allCount;
  final String count;
  final String day;
  final String week;
  final String startDateHintText;
  final String routineCycle;

  RoutineAddScreenText(
      {required this.title,
      required this.editTitle,
      required this.inputTitle,
      required this.inputTitlePlaceholder,
      required this.exercisePlaceholder,
      required this.success,
      required this.editSuccess,
      required this.maxExercise,
      required this.noRoutine,
      required this.successDelete,
      required this.errorDelete,
      required this.cycle,
      required this.repeat,
      required this.exercise,
      required this.cycleDate,
      required this.exerciseListCheck,
      required this.errorCycle,
      required this.cycleDes,
      required this.repeatDes,
      required this.startDate,
      required this.endDate,
      required this.selectedDate,
      required this.dateFormat,
      required this.executionCount,
      required this.allCount,
      required this.count,
      required this.day,
      required this.week,
      required this.startDateHintText,
      required this.routineCycle});
}

class ExerciseScreenText {
  final String inputTitle;

  final String addExercise;
  final String addPart;
  final String add;

  final String noExercise;
  final String maxPart;

  final String errorDelete;
  final String successDelete;

  ExerciseScreenText({
    required this.inputTitle,
    required this.addExercise,
    required this.addPart,
    required this.add,
    required this.noExercise,
    required this.maxPart,
    required this.errorDelete,
    required this.successDelete,
  });
}

class RoutineCycleScreenText {
  final String title;
  final String subTitle;
  final String week;
  final List<String> weekday;
  RoutineCycleScreenText(
      {required this.title,
      required this.subTitle,
      required this.week,
      required this.weekday});
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
      ComponentErrorText settingScreenText = ComponentErrorText(
          networkError: ComponentErrorTextEn().networkError,
          noSearchData: ComponentErrorTextEn().noSearchData);
      return settingScreenText;
    } else {
      ComponentErrorText settingScreenText = ComponentErrorText(
          networkError: ComponentErrorTextKr().networkError,
          noSearchData: ComponentErrorTextKr().noSearchData);
      return settingScreenText;
    }
  }

  ComponentButtonText localiztionComponentButton() {
    if (language.value == 0) {
      ComponentButtonText localiztionButtonText = ComponentButtonText(
          save: ComponentButtonTextEn().save,
          inquiry: ComponentButtonTextEn().inquiry,
          latest: ComponentButtonTextEn().latest,
          oldest: ComponentButtonTextEn().oldest,
          name: ComponentButtonTextEn().name,
          addToday: ComponentButtonTextEn().addToday,
          searchPlaceholder: ComponentButtonTextEn().searchPlaceholder,
          add: ComponentButtonTextEn().add,
          edit: ComponentButtonTextEn().edit,
          delete: ComponentButtonTextEn().delete,
          endDatest: ComponentButtonTextEn().endDatest,
          startDatest: ComponentButtonTextEn().startDatest,
          complete: ComponentButtonTextEn().complete);
      return localiztionButtonText;
    } else {
      ComponentButtonText localiztionButtonText = ComponentButtonText(
          save: ComponentButtonTextKr().save,
          inquiry: ComponentButtonTextKr().inquiry,
          latest: ComponentButtonTextKr().latest,
          oldest: ComponentButtonTextKr().oldest,
          name: ComponentButtonTextKr().name,
          addToday: ComponentButtonTextKr().addToday,
          searchPlaceholder: ComponentButtonTextKr().searchPlaceholder,
          add: ComponentButtonTextKr().add,
          edit: ComponentButtonTextKr().edit,
          delete: ComponentButtonTextKr().delete,
          endDatest: ComponentButtonTextKr().endDatest,
          startDatest: ComponentButtonTextKr().startDatest,
          complete: ComponentButtonTextKr().complete);
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
        themeChangeText: ModalScreenTextEn().themeChangeText,
        delete: ModalScreenTextEn().delete,
        deleteExercise: ModalScreenTextEn().deleteExercise,
        deleteMuscle: ModalScreenTextEn().deleteMuscle,
        deleteRoutine: ModalScreenTextEn().deleteRoutine,
      );
      return modalScreenText;
    } else {
      ModalScreenText modalScreenText = ModalScreenText(
        ok: ModalScreenTextKr().ok,
        cancel: ModalScreenTextKr().cancel,
        logoutText: ModalScreenTextKr().logoutText,
        logoutTitle: ModalScreenTextKr().logoutTitle,
        themeChangeTitle: ModalScreenTextKr().themeChangeTitle,
        themeChangeText: ModalScreenTextKr().themeChangeText,
        delete: ModalScreenTextKr().delete,
        deleteExercise: ModalScreenTextKr().deleteExercise,
        deleteMuscle: ModalScreenTextKr().deleteMuscle,
        deleteRoutine: ModalScreenTextKr().deleteRoutine,
      );
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

  ExerciseScreenText localiztionExerciseScreen() {
    if (language.value == 0) {
      ExerciseScreenText exerciseScreenText = ExerciseScreenText(
          inputTitle: ExerciseScreenTextEn().inputTitle,
          addExercise: ExerciseScreenTextEn().addExercise,
          addPart: ExerciseScreenTextEn().addPart,
          add: ExerciseScreenTextEn().add,
          noExercise: ExerciseScreenTextKr().noExercise,
          maxPart: ExerciseScreenTextEn().maxPart,
          errorDelete: ExerciseScreenTextEn().errorDelete,
          successDelete: ExerciseScreenTextEn().successDelete);
      return exerciseScreenText;
    } else {
      ExerciseScreenText exerciseScreenText = ExerciseScreenText(
          inputTitle: ExerciseScreenTextKr().inputTitle,
          addExercise: ExerciseScreenTextKr().addExercise,
          addPart: ExerciseScreenTextKr().addPart,
          add: ExerciseScreenTextKr().add,
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
          inputTitlePlaceholder:
              ExerciseAddScreenTextEn().inputTitlePlaceholder,
          partPlaceholder: ExerciseAddScreenTextEn().partPlaceholder,
          partName: ExerciseAddScreenTextEn().partName,
          addExercise: ExerciseAddScreenTextEn().addExercise,
          add: ExerciseAddScreenTextEn().add,
          success: ExerciseAddScreenTextEn().success,
          alreadyPart: ExerciseAddScreenTextEn().alreadyPart,
          maxPart: ExerciseAddScreenTextEn().maxPart,
          noExercise: ExerciseAddScreenTextEn().noExercise,
          successDelete: ExerciseAddScreenTextEn().successDelete,
          errorDelete: ExerciseAddScreenTextEn().errorDelete,
          weight: ExerciseAddScreenTextEn().weight,
          nowWeight: ExerciseAddScreenTextEn().nowWeight,
          targetWeight: ExerciseAddScreenTextEn().targetWeight,
          addMuscle: ExerciseAddScreenTextEn().addMuscle,
          muscleSuccess: ExerciseAddScreenTextEn().muscleSuccess,
          noMuscle: ExerciseAddScreenTextEn().noMuscle,
          errorWeight: ExerciseAddScreenTextEn().errorWeight,
          part: ExerciseAddScreenTextEn().part,
          editSuccess: ExerciseAddScreenTextEn().editSuccess);
      return exerciseAddScreenText;
    } else {
      ExerciseAddScreenText exerciseAddScreenText = ExerciseAddScreenText(
          title: ExerciseAddScreenTextKr().title,
          inputTitle: ExerciseAddScreenTextKr().inputTitle,
          inputTitlePlaceholder:
              ExerciseAddScreenTextKr().inputTitlePlaceholder,
          partPlaceholder: ExerciseAddScreenTextKr().partPlaceholder,
          partName: ExerciseAddScreenTextKr().partName,
          addExercise: ExerciseAddScreenTextKr().addExercise,
          add: ExerciseAddScreenTextKr().add,
          success: ExerciseAddScreenTextKr().success,
          alreadyPart: ExerciseAddScreenTextKr().alreadyPart,
          maxPart: ExerciseAddScreenTextKr().maxPart,
          noExercise: ExerciseAddScreenTextKr().noExercise,
          successDelete: ExerciseAddScreenTextKr().successDelete,
          errorDelete: ExerciseAddScreenTextKr().errorDelete,
          weight: ExerciseAddScreenTextKr().weight,
          nowWeight: ExerciseAddScreenTextKr().nowWeight,
          targetWeight: ExerciseAddScreenTextKr().targetWeight,
          addMuscle: ExerciseAddScreenTextKr().addMuscle,
          muscleSuccess: ExerciseAddScreenTextKr().muscleSuccess,
          noMuscle: ExerciseAddScreenTextKr().noMuscle,
          errorWeight: ExerciseAddScreenTextKr().errorWeight,
          part: ExerciseAddScreenTextKr().part,
          editSuccess: ExerciseAddScreenTextKr().editSuccess);
      return exerciseAddScreenText;
    }
  }

  RoutineScreenText localiztionRoutineScreen() {
    if (language.value == 0) {
      RoutineScreenText routineScreenText = RoutineScreenText(
          inputTitle: RoutineScreenTextEn().inputTitle,
          inputTitlePlaceholder: RoutineScreenTextEn().inputTitlePlaceholder,
          addRoutine: RoutineScreenTextEn().addRoutine,
          routineName: RoutineScreenTextEn().routineName,
          routineCycle: RoutineScreenTextEn().routineCycle,
          date: RoutineScreenTextEn().date,
          noRoutine: RoutineScreenTextEn().noRoutine);
      return routineScreenText;
    } else {
      RoutineScreenText routineScreenText = RoutineScreenText(
          inputTitle: RoutineScreenTextKr().inputTitle,
          inputTitlePlaceholder: RoutineScreenTextKr().inputTitlePlaceholder,
          addRoutine: RoutineScreenTextKr().addRoutine,
          routineName: RoutineScreenTextKr().routineName,
          routineCycle: RoutineScreenTextKr().routineCycle,
          date: RoutineScreenTextKr().date,
          noRoutine: RoutineScreenTextKr().noRoutine);
      return routineScreenText;
    }
  }

  RoutineAddScreenText localiztionRoutineAddScreen() {
    if (language.value == 0) {
      RoutineAddScreenText routineAddScreenText = RoutineAddScreenText(
          title: RoutineAddScreenTextEn().title,
          editTitle: RoutineAddScreenTextEn().editTitle,
          inputTitle: RoutineAddScreenTextEn().inputTitle,
          inputTitlePlaceholder: RoutineAddScreenTextEn().inputTitlePlaceholder,
          exercisePlaceholder: RoutineAddScreenTextEn().exercisePlaceholder,
          success: RoutineAddScreenTextEn().success,
          editSuccess: RoutineAddScreenTextEn().editSuccess,
          maxExercise: RoutineAddScreenTextEn().maxExercise,
          noRoutine: RoutineAddScreenTextEn().noRoutine,
          successDelete: RoutineAddScreenTextEn().successDelete,
          errorDelete: RoutineAddScreenTextEn().errorDelete,
          cycle: RoutineAddScreenTextEn().cycle,
          repeat: RoutineAddScreenTextEn().repeat,
          cycleDate: RoutineAddScreenTextEn().cycleDate,
          exercise: RoutineAddScreenTextKr().exercise,
          exerciseListCheck: RoutineAddScreenTextEn().exerciseListCheck,
          errorCycle: RoutineAddScreenTextEn().errorCycle,
          cycleDes: RoutineAddScreenTextEn().cycleDes,
          repeatDes: RoutineAddScreenTextEn().repeatDes,
          startDate: RoutineAddScreenTextEn().startDate,
          endDate: RoutineAddScreenTextEn().endDate,
          selectedDate: RoutineAddScreenTextEn().selectedDate,
          dateFormat: RoutineAddScreenTextEn().dateFormat,
          executionCount: RoutineAddScreenTextEn().executionCount,
          allCount: RoutineAddScreenTextEn().allCount,
          count: RoutineAddScreenTextEn().count,
          day: RoutineAddScreenTextEn().day,
          week: RoutineAddScreenTextEn().week,
          startDateHintText: RoutineAddScreenTextEn().startDateHintText,
          routineCycle: RoutineAddScreenTextEn().routineCycle);
      return routineAddScreenText;
    } else {
      RoutineAddScreenText routineAddScreenText = RoutineAddScreenText(
          title: RoutineAddScreenTextKr().title,
          editTitle: RoutineAddScreenTextKr().editTitle,
          inputTitle: RoutineAddScreenTextKr().inputTitle,
          inputTitlePlaceholder: RoutineAddScreenTextKr().inputTitlePlaceholder,
          exercisePlaceholder: RoutineAddScreenTextKr().exercisePlaceholder,
          success: RoutineAddScreenTextKr().success,
          editSuccess: RoutineAddScreenTextKr().editSuccess,
          maxExercise: RoutineAddScreenTextKr().maxExercise,
          noRoutine: RoutineAddScreenTextKr().noRoutine,
          successDelete: RoutineAddScreenTextKr().successDelete,
          errorDelete: RoutineAddScreenTextKr().errorDelete,
          cycle: RoutineAddScreenTextKr().cycle,
          repeat: RoutineAddScreenTextKr().repeat,
          cycleDate: RoutineAddScreenTextKr().cycleDate,
          exercise: RoutineAddScreenTextKr().exercise,
          exerciseListCheck: RoutineAddScreenTextKr().exerciseListCheck,
          errorCycle: RoutineAddScreenTextKr().errorCycle,
          cycleDes: RoutineAddScreenTextKr().cycleDes,
          repeatDes: RoutineAddScreenTextKr().repeatDes,
          startDate: RoutineAddScreenTextKr().startDate,
          endDate: RoutineAddScreenTextKr().endDate,
          selectedDate: RoutineAddScreenTextKr().selectedDate,
          dateFormat: RoutineAddScreenTextKr().dateFormat,
          executionCount: RoutineAddScreenTextKr().executionCount,
          allCount: RoutineAddScreenTextKr().allCount,
          count: RoutineAddScreenTextKr().count,
          day: RoutineAddScreenTextKr().day,
          week: RoutineAddScreenTextKr().week,
          startDateHintText: RoutineAddScreenTextKr().startDateHintText,
          routineCycle: RoutineAddScreenTextKr().routineCycle);
      return routineAddScreenText;
    }
  }

  RoutineCycleScreenText localiztionRoutineCycleScreen() {
    if (language.value == 0) {
      RoutineCycleScreenText routineCycleScreenText = RoutineCycleScreenText(
        title: RoutineCycleScreenTextEn().title,
        subTitle: RoutineCycleScreenTextEn().subTitle,
        week: RoutineCycleScreenTextEn().week,
        weekday: RoutineCycleScreenTextEn().weekday,
      );
      return routineCycleScreenText;
    } else {
      RoutineCycleScreenText routineCycleScreenText = RoutineCycleScreenText(
        title: RoutineCycleScreenTextKr().title,
        subTitle: RoutineCycleScreenTextKr().subTitle,
        week: RoutineCycleScreenTextKr().week,
        weekday: RoutineCycleScreenTextKr().weekday,
      );
      return routineCycleScreenText;
    }
  }
}
