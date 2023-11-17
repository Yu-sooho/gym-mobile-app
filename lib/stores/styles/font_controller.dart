import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/styles/custom_fonts.dart';
export 'package:flutter/widgets.dart';

@immutable
class CustomFont {
  final TextStyle bold14;
  final TextStyle bold24;

  CustomFont({
    required this.bold14,
    required this.bold24,
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
        bold14: CustomFont1().bold14,
        bold24: CustomFont1().bold24,
      );
      return customFont;
    } else if (fontType.value == 1) {
      CustomFont customFont = CustomFont(
        bold14: CustomFont2().bold14,
        bold24: CustomFont2().bold24,
      );
      return customFont;
    } else {
      CustomFont customFont = CustomFont(
        bold14: CustomFont3().bold14,
        bold24: CustomFont3().bold24,
      );
      return customFont;
    }
  }
}
