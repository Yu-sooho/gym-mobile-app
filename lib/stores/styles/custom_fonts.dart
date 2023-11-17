import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class CustomFont1 {
  final CustomColorController colorController =
      Get.put(CustomColorController());

  late TextStyle bold14 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold24 = TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: colorController.customColor().defaultTextColor);
}

class CustomFont2 {
  final CustomColorController colorController =
      Get.put(CustomColorController());

  late TextStyle bold14 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold24 = TextStyle(
      fontFamily: 'Nanum',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: colorController.customColor().defaultTextColor);
}

class CustomFont3 {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  late TextStyle bold14 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: colorController.customColor().defaultTextColor);
  late TextStyle bold24 = TextStyle(
      fontFamily: 'SCore',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: colorController.customColor().defaultTextColor);
}
