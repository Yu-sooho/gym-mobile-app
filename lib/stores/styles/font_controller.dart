import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/styles/custom_fonts.dart';
export 'package:flutter/widgets.dart';

@immutable
class CustomFont {
  final TextStyle medium12;
  final TextStyle bold12;
  final TextStyle bold14;
  final TextStyle bold18;

  CustomFont({
    required this.medium12,
    required this.bold12,
    required this.bold14,
    required this.bold18,
  });
}

class CustomFontController extends GetxController {
  RxInt fontType = 0.obs;

  void changeFontMode(int type) {
    fontType.value = type;
  }

  CustomFont customFont() {
    if (fontType.value == 0) {
      CustomFont customFont = CustomFont(
        medium12: CustomFont1().medium12,
        bold12: CustomFont1().bold12,
        bold14: CustomFont1().bold14,
        bold18: CustomFont1().bold18,
      );
      return customFont;
    } else if (fontType.value == 1) {
      CustomFont customFont = CustomFont(
        medium12: CustomFont2().medium12,
        bold12: CustomFont1().bold12,
        bold14: CustomFont2().bold14,
        bold18: CustomFont2().bold18,
      );
      return customFont;
    } else {
      CustomFont customFont = CustomFont(
        medium12: CustomFont3().medium12,
        bold12: CustomFont1().bold12,
        bold14: CustomFont3().bold14,
        bold18: CustomFont3().bold18,
      );
      return customFont;
    }
  }
}
