import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/styles/custom_fonts.dart';

@immutable
class CustomFont {
  final TextStyle regular12;
  final TextStyle medium12;
  final TextStyle medium14;
  final TextStyle bold12;
  final TextStyle bold14;
  final TextStyle bold16;
  final TextStyle bold18;

  final TextStyle modalText;
  final TextStyle modalTitle;
  final TextStyle modalOk;
  final TextStyle modalCancel;

  CustomFont(
      {required this.regular12,
      required this.medium12,
      required this.medium14,
      required this.bold12,
      required this.bold14,
      required this.bold16,
      required this.bold18,
      required this.modalText,
      required this.modalTitle,
      required this.modalOk,
      required this.modalCancel});
}

class CustomFontController extends GetxController {
  final storage = FlutterSecureStorage();
  RxInt fontType = 0.obs;

  Future<bool> changeFontMode(type) async {
    try {
      await storage.write(key: 'fontType', value: '$type');
      fontType.value = type;
      return true;
    } catch (error) {
      print('changeFontMode $error');
      return false;
    }
  }

  CustomFont customFont() {
    if (fontType.value == 0) {
      CustomFont customFont = CustomFont(
          regular12: CustomFont1().regular12,
          medium12: CustomFont1().medium12,
          medium14: CustomFont1().medium14,
          bold12: CustomFont1().bold12,
          bold14: CustomFont1().bold14,
          bold16: CustomFont1().bold16,
          bold18: CustomFont1().bold18,
          modalText: CustomFont1().modalText,
          modalTitle: CustomFont1().modalTitle,
          modalOk: CustomFont1().modalOk,
          modalCancel: CustomFont1().modalCancel);
      return customFont;
    } else if (fontType.value == 1) {
      CustomFont customFont = CustomFont(
          regular12: CustomFont2().regular12,
          medium12: CustomFont2().medium12,
          medium14: CustomFont2().medium14,
          bold12: CustomFont2().bold12,
          bold14: CustomFont2().bold14,
          bold16: CustomFont2().bold16,
          bold18: CustomFont2().bold18,
          modalText: CustomFont2().modalText,
          modalTitle: CustomFont2().modalTitle,
          modalOk: CustomFont2().modalOk,
          modalCancel: CustomFont2().modalCancel);
      return customFont;
    } else {
      CustomFont customFont = CustomFont(
          regular12: CustomFont3().regular12,
          medium12: CustomFont3().medium12,
          medium14: CustomFont3().medium14,
          bold12: CustomFont1().bold12,
          bold14: CustomFont3().bold14,
          bold16: CustomFont3().bold16,
          bold18: CustomFont3().bold18,
          modalText: CustomFont3().modalText,
          modalTitle: CustomFont3().modalTitle,
          modalOk: CustomFont3().modalOk,
          modalCancel: CustomFont3().modalCancel);
      return customFont;
    }
  }
}
