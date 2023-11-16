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

  CustomColor(
      {required this.toastBackground,
      required this.toastText,
      required this.defaultBackground,
      required this.loadingSpinnerOpacity,
      required this.loadingSpinnerColor});
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
          loadingSpinnerColor: CustomColorMode1().loadingSpinnerColor);
      return customColor;
    } else if (colorType.value == 1) {
      CustomColor customColor = CustomColor(
          toastBackground: CustomColorMode2().toastBackground,
          toastText: CustomColorMode2().toastText,
          defaultBackground: CustomColorMode2().defaultBackground,
          loadingSpinnerOpacity: CustomColorMode2().loadingSpinnerOpacity,
          loadingSpinnerColor: CustomColorMode2().loadingSpinnerColor);
      return customColor;
    } else {
      CustomColor customColor = CustomColor(
          toastBackground: CustomColorMode1().toastBackground,
          toastText: CustomColorMode1().toastText,
          defaultBackground: CustomColorMode1().defaultBackground,
          loadingSpinnerOpacity: CustomColorMode1().loadingSpinnerOpacity,
          loadingSpinnerColor: CustomColorMode1().loadingSpinnerColor);
      return customColor;
    }
  }
}
