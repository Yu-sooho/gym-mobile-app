import 'package:flutter/material.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class CustomFont1 {
  final Stores stores = Stores();

  late TextStyle regular12 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.w100,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle medium12 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle medium14 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold12 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold14 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold16 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 16 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold18 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 18 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold40 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 40 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle modalTitle = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().modalText);
  late TextStyle modalText = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().modalText);
  late TextStyle modalOk = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().modalOk);
  late TextStyle modalCancel = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().modalCancel);
}

class CustomFont2 {
  final Stores stores = Stores();

  late TextStyle regular12 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.w100,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle medium12 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle medium14 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold12 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold14 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold16 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 16 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold18 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 18 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold40 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 40 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle modalTitle = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().modalText);
  late TextStyle modalText = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().modalText);
  late TextStyle modalOk = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().modalOk);
  late TextStyle modalCancel = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().modalCancel);
}

class CustomFont3 {
  final Stores stores = Stores();

  late TextStyle regular12 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.w100,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle medium12 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle medium14 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold12 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold14 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold16 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 16 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold18 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 18 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle bold40 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 40 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().defaultTextColor);
  late TextStyle modalTitle = TextStyle(
      fontFamily: 'SCore',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.bold,
      color: stores.colorController.customColor().modalText);
  late TextStyle modalText = TextStyle(
      fontFamily: 'SCore',
      fontSize: 12 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().modalText);
  late TextStyle modalOk = TextStyle(
      fontFamily: 'SCore',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().modalOk);
  late TextStyle modalCancel = TextStyle(
      fontFamily: 'SCore',
      fontSize: 14 + stores.appStateController.fontSize.value,
      fontWeight: FontWeight.normal,
      color: stores.colorController.customColor().modalCancel);
}
