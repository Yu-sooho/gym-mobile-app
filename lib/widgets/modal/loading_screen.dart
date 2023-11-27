import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingScreen(BuildContext context) {
  CustomColorController colorController = Get.put(CustomColorController());
  return Obx(() => Container(
        decoration: BoxDecoration(
            color: colorController.customColor().loadingSpinnerOpacity),
        child: Center(
          child: SpinKitFadingCircle(
            color: colorController.customColor().loadingSpinnerColor,
          ),
        ),
      ));
}
