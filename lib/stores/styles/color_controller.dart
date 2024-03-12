import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/styles/custom_colors.dart';

@immutable
class CustomColor {
  final Color toastBackground;
  final Color toastText;
  final Color defaultBackground1;
  final Color defaultBackground2;
  final Color loadingSpinnerOpacity;
  final Color loadingSpinnerColor;
  final Color defaultTextColor;
  final Color skeletonColor;
  final Color skeletonColor2;
  final Color transparent;

  final Color buttonBorder;
  final Color buttonOpacity;

  final Color switchTrackColor;
  final Color switchActiveColor;

  final Color modalBackground;
  final Color modalText;
  final Color modalCancel;
  final Color modalOk;

  final Color errorText;
  final Color textInputCursor;
  final Color textInputFocusCursor;
  final Color placeholder;

  final Color bottomTabBarActiveItem;
  final Color bottomTabBarItem;

  final Color buttonActiveText;
  final Color buttonInActiveText;

  final Color buttonActiveColor;
  final Color buttonInActiveColor;
  final Color buttonDefaultColor;
  final Color deleteButtonColor;
  final Color buttonShadowColor;

  final List<Color> routineColors;

  CustomColor(
      {required this.toastBackground,
      required this.toastText,
      required this.defaultBackground1,
      required this.defaultBackground2,
      required this.loadingSpinnerOpacity,
      required this.loadingSpinnerColor,
      required this.defaultTextColor,
      required this.skeletonColor,
      required this.skeletonColor2,
      required this.buttonOpacity,
      required this.buttonBorder,
      required this.switchActiveColor,
      required this.switchTrackColor,
      required this.transparent,
      required this.modalBackground,
      required this.modalText,
      required this.modalOk,
      required this.modalCancel,
      required this.errorText,
      required this.textInputCursor,
      required this.textInputFocusCursor,
      required this.placeholder,
      required this.bottomTabBarActiveItem,
      required this.bottomTabBarItem,
      required this.buttonActiveText,
      required this.buttonInActiveText,
      required this.buttonActiveColor,
      required this.buttonInActiveColor,
      required this.buttonDefaultColor,
      required this.deleteButtonColor,
      required this.buttonShadowColor,
      required this.routineColors});
}

class CustomColorController extends GetxController {
  final storage = FlutterSecureStorage();
  RxInt colorType = 0.obs;

  Future<bool> changeColorMode(type) async {
    try {
      await storage.write(key: 'colorType', value: '$type');
      colorType.value = type;
      return true;
    } catch (error) {
      print('changeColorMode $error');
      return false;
    }
  }

  CustomColor customColor() {
    if (colorType.value == 0) {
      CustomColor customColor = CustomColor(
        errorText: CustomColorMode1().errorText,
        toastBackground: CustomColorMode1().toastBackground,
        toastText: CustomColorMode1().toastText,
        defaultBackground1: CustomColorMode1().defaultBackground1,
        defaultBackground2: CustomColorMode1().defaultBackground2,
        loadingSpinnerOpacity: CustomColorMode1().loadingSpinnerOpacity,
        loadingSpinnerColor: CustomColorMode1().loadingSpinnerColor,
        defaultTextColor: CustomColorMode1().defaultTextColor,
        skeletonColor: CustomColorMode1().skeletonColor,
        skeletonColor2: CustomColorMode1().skeletonColor2,
        buttonOpacity: CustomColorMode1().buttonOpacity,
        transparent: CustomColorMode1().transparent,
        buttonBorder: CustomColorMode1().buttonBorder,
        modalBackground: CustomColorMode1().modalBackground,
        modalText: CustomColorMode1().modalText,
        modalOk: CustomColorMode1().modalOk,
        modalCancel: CustomColorMode1().modalCancel,
        switchActiveColor: CustomColorMode1().switchActiveColor,
        switchTrackColor: CustomColorMode1().switchTrackColor,
        textInputCursor: CustomColorMode1().textInputCursor,
        textInputFocusCursor: CustomColorMode1().textInputFocusCursor,
        placeholder: CustomColorMode1().placeholder,
        bottomTabBarActiveItem: CustomColorMode1().bottomTabBarActiveItem,
        bottomTabBarItem: CustomColorMode1().bottomTabBarItem,
        buttonInActiveText: CustomColorMode1().buttonInActiveText,
        buttonActiveText: CustomColorMode1().buttonActiveText,
        buttonInActiveColor: CustomColorMode1().buttonInActiveColor,
        buttonActiveColor: CustomColorMode1().buttonActiveColor,
        buttonDefaultColor: CustomColorMode1().buttonDefaultColor,
        deleteButtonColor: CustomColorMode1().deleteButtonColor,
        buttonShadowColor: CustomColorMode1().buttonShadowColor,
        routineColors: CustomColorMode1().routineColors,
      );
      return customColor;
    } else if (colorType.value == 1) {
      CustomColor customColor = CustomColor(
        errorText: CustomColorMode2().errorText,
        toastBackground: CustomColorMode2().toastBackground,
        toastText: CustomColorMode2().toastText,
        defaultBackground1: CustomColorMode2().defaultBackground1,
        defaultBackground2: CustomColorMode2().defaultBackground2,
        loadingSpinnerOpacity: CustomColorMode2().loadingSpinnerOpacity,
        loadingSpinnerColor: CustomColorMode2().loadingSpinnerColor,
        defaultTextColor: CustomColorMode2().defaultTextColor,
        skeletonColor: CustomColorMode2().skeletonColor,
        skeletonColor2: CustomColorMode2().skeletonColor2,
        buttonOpacity: CustomColorMode2().buttonOpacity,
        transparent: CustomColorMode2().transparent,
        buttonBorder: CustomColorMode2().buttonBorder,
        modalBackground: CustomColorMode2().modalBackground,
        modalText: CustomColorMode2().modalText,
        modalOk: CustomColorMode2().modalOk,
        modalCancel: CustomColorMode2().modalCancel,
        switchActiveColor: CustomColorMode2().switchActiveColor,
        switchTrackColor: CustomColorMode2().switchTrackColor,
        textInputCursor: CustomColorMode2().textInputCursor,
        textInputFocusCursor: CustomColorMode2().textInputFocusCursor,
        placeholder: CustomColorMode2().placeholder,
        bottomTabBarActiveItem: CustomColorMode2().bottomTabBarActiveItem,
        bottomTabBarItem: CustomColorMode2().bottomTabBarItem,
        buttonInActiveText: CustomColorMode2().buttonInActiveText,
        buttonActiveText: CustomColorMode2().buttonActiveText,
        buttonInActiveColor: CustomColorMode2().buttonInActiveColor,
        buttonActiveColor: CustomColorMode2().buttonActiveColor,
        buttonDefaultColor: CustomColorMode2().buttonDefaultColor,
        deleteButtonColor: CustomColorMode2().deleteButtonColor,
        buttonShadowColor: CustomColorMode2().buttonShadowColor,
        routineColors: CustomColorMode2().routineColors,
      );
      return customColor;
    } else {
      CustomColor customColor = CustomColor(
        errorText: CustomColorMode3().errorText,
        toastBackground: CustomColorMode3().toastBackground,
        toastText: CustomColorMode3().toastText,
        defaultBackground1: CustomColorMode3().defaultBackground1,
        defaultBackground2: CustomColorMode3().defaultBackground2,
        loadingSpinnerOpacity: CustomColorMode3().loadingSpinnerOpacity,
        loadingSpinnerColor: CustomColorMode3().loadingSpinnerColor,
        defaultTextColor: CustomColorMode3().defaultTextColor,
        skeletonColor: CustomColorMode3().skeletonColor,
        skeletonColor2: CustomColorMode3().skeletonColor2,
        buttonOpacity: CustomColorMode3().buttonOpacity,
        transparent: CustomColorMode3().transparent,
        buttonBorder: CustomColorMode3().buttonBorder,
        modalBackground: CustomColorMode3().modalBackground,
        modalText: CustomColorMode3().modalText,
        modalOk: CustomColorMode3().modalOk,
        modalCancel: CustomColorMode3().modalCancel,
        switchActiveColor: CustomColorMode3().switchActiveColor,
        switchTrackColor: CustomColorMode3().switchTrackColor,
        textInputCursor: CustomColorMode3().textInputCursor,
        textInputFocusCursor: CustomColorMode3().textInputFocusCursor,
        placeholder: CustomColorMode3().placeholder,
        bottomTabBarActiveItem: CustomColorMode3().bottomTabBarActiveItem,
        bottomTabBarItem: CustomColorMode3().bottomTabBarItem,
        buttonInActiveText: CustomColorMode3().buttonInActiveText,
        buttonActiveText: CustomColorMode3().buttonActiveText,
        buttonInActiveColor: CustomColorMode3().buttonInActiveColor,
        buttonActiveColor: CustomColorMode3().buttonActiveColor,
        buttonDefaultColor: CustomColorMode3().buttonDefaultColor,
        deleteButtonColor: CustomColorMode3().deleteButtonColor,
        buttonShadowColor: CustomColorMode3().buttonShadowColor,
        routineColors: CustomColorMode3().routineColors,
      );
      return customColor;
    }
  }
}
