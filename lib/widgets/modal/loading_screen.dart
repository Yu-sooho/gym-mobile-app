import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gym_calendar/stores/package_stores.dart';

Widget loadingScreen(BuildContext context) {
  final Stores stores = Get.put(Stores());
  return Obx(() => Container(
        decoration: BoxDecoration(
            color: stores.colorController.customColor().loadingSpinnerOpacity),
        child: Center(
          child: SpinKitFadingCircle(
            color: stores.colorController.customColor().loadingSpinnerColor,
          ),
        ),
      ));
}
