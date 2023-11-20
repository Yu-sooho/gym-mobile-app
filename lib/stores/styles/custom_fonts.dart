import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class CustomFont1 {
  final CustomColorController colorController =
      Get.put(CustomColorController());

  late TextStyle medium12 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold12 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold14 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold18 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: colorController.customColor().defaultTextColor);
}

class CustomFont2 {
  final CustomColorController colorController =
      Get.put(CustomColorController());

  late TextStyle medium12 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold12 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold14 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold18 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: colorController.customColor().defaultTextColor);
}

class CustomFont3 {
  final CustomColorController colorController =
      Get.put(CustomColorController());

  late TextStyle medium12 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold12 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold14 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold18 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: colorController.customColor().defaultTextColor);
}
