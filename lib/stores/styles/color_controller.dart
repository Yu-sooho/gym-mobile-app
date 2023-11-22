import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/styles/custom_colors.dart';
export 'package:flutter/widgets.dart';

@immutable
class CustomColor {
  final Color toastBackground;
  final Color toastText;
  final Color defaultBackground;
  final Color loadingSpinnerOpacity;
  final Color loadingSpinnerColor;
  final Color defaultTextColor;
  final Color skeletonColor;
  final Color skeletonColor2;
  final Color transparent;

  final Color buttonBorder;
  final Color buttonOpacity;

  final Color switchColor;

  final Color modalBackground;
  final Color modalText;
  final Color modalCancel;
  final Color modalOk;

  final Color textInputCursor;
  final Color textInputFocusCursor;
  final Color placeholder;

  final Color bottomTabBarActiveItem;
  final Color bottomTabBarItem;

  CustomColor(
      {required this.toastBackground,
      required this.toastText,
      required this.defaultBackground,
      required this.loadingSpinnerOpacity,
      required this.loadingSpinnerColor,
      required this.defaultTextColor,
      required this.skeletonColor,
      required this.skeletonColor2,
      required this.buttonOpacity,
      required this.buttonBorder,
      required this.switchColor,
      required this.transparent,
      required this.modalBackground,
      required this.modalText,
      required this.modalOk,
      required this.modalCancel,
      required this.textInputCursor,
      required this.textInputFocusCursor,
      required this.placeholder,
      required this.bottomTabBarActiveItem,
      required this.bottomTabBarItem});
}

class CustomColorController extends GetxController {
  RxInt colorType = 0.obs;

  void changeColorMode(int type) {
    colorType.value = type;
  }

  CustomColor customColor() {
    if (colorType.value == 0) {
      CustomColor customColor = CustomColor(
        toastBackground: CustomColorMode1().toastBackground,
        toastText: CustomColorMode1().toastText,
        defaultBackground: CustomColorMode1().defaultBackground,
        loadingSpinnerOpacity: CustomColorMode1().loadingSpinnerOpacity,
        loadingSpinnerColor: CustomColorMode1().loadingSpinnerColor,
        defaultTextColor: CustomColorMode1().defaultTextColor,
        skeletonColor: CustomColorMode1().skeletonColor,
        skeletonColor2: CustomColorMode2().skeletonColor2,
        buttonOpacity: CustomColorMode1().buttonOpacity,
        transparent: CustomColorMode1().transparent,
        buttonBorder: CustomColorMode1().buttonBorder,
        modalBackground: CustomColorMode1().modalBackground,
        modalText: CustomColorMode1().modalText,
        modalOk: CustomColorMode1().modalOk,
        modalCancel: CustomColorMode1().modalCancel,
        switchColor: CustomColorMode1().switchColor,
        textInputCursor: CustomColorMode1().textInputCursor,
        textInputFocusCursor: CustomColorMode1().textInputFocusCursor,
        placeholder: CustomColorMode1().placeholder,
        bottomTabBarActiveItem: CustomColorMode1().bottomTabBarActiveItem,
        bottomTabBarItem: CustomColorMode1().bottomTabBarItem,
      );
      return customColor;
    } else if (colorType.value == 1) {
      CustomColor customColor = CustomColor(
        toastBackground: CustomColorMode2().toastBackground,
        toastText: CustomColorMode2().toastText,
        defaultBackground: CustomColorMode2().defaultBackground,
        loadingSpinnerOpacity: CustomColorMode2().loadingSpinnerOpacity,
        loadingSpinnerColor: CustomColorMode2().loadingSpinnerColor,
        defaultTextColor: CustomColorMode2().defaultTextColor,
        skeletonColor: CustomColorMode2().skeletonColor,
        skeletonColor2: CustomColorMode2().skeletonColor2,
        buttonOpacity: CustomColorMode2().buttonOpacity,
        transparent: CustomColorMode2().transparent,
        buttonBorder: CustomColorMode1().buttonBorder,
        modalBackground: CustomColorMode2().modalBackground,
        modalText: CustomColorMode2().modalText,
        modalOk: CustomColorMode2().modalOk,
        modalCancel: CustomColorMode2().modalCancel,
        switchColor: CustomColorMode2().switchColor,
        textInputCursor: CustomColorMode1().textInputCursor,
        textInputFocusCursor: CustomColorMode1().textInputFocusCursor,
        placeholder: CustomColorMode1().placeholder,
        bottomTabBarActiveItem: CustomColorMode1().bottomTabBarActiveItem,
        bottomTabBarItem: CustomColorMode1().bottomTabBarItem,
      );
      return customColor;
    } else {
      CustomColor customColor = CustomColor(
        toastBackground: CustomColorMode1().toastBackground,
        toastText: CustomColorMode1().toastText,
        defaultBackground: CustomColorMode1().defaultBackground,
        loadingSpinnerOpacity: CustomColorMode1().loadingSpinnerOpacity,
        loadingSpinnerColor: CustomColorMode1().loadingSpinnerColor,
        defaultTextColor: CustomColorMode1().defaultTextColor,
        skeletonColor: CustomColorMode1().skeletonColor,
        skeletonColor2: CustomColorMode2().skeletonColor2,
        buttonOpacity: CustomColorMode1().buttonOpacity,
        transparent: CustomColorMode1().transparent,
        buttonBorder: CustomColorMode1().buttonBorder,
        modalBackground: CustomColorMode2().modalBackground,
        modalText: CustomColorMode2().modalText,
        modalOk: CustomColorMode2().modalOk,
        modalCancel: CustomColorMode2().modalCancel,
        switchColor: CustomColorMode1().switchColor,
        textInputCursor: CustomColorMode1().textInputCursor,
        textInputFocusCursor: CustomColorMode1().textInputFocusCursor,
        placeholder: CustomColorMode1().placeholder,
        bottomTabBarActiveItem: CustomColorMode1().bottomTabBarActiveItem,
        bottomTabBarItem: CustomColorMode1().bottomTabBarItem,
      );
      return customColor;
    }
  }
}
