import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingScreen(BuildContext context) {
  CustomColorController customColorController =
      Get.put(CustomColorController());
  return Container(
    decoration: BoxDecoration(
        color: customColorController.customColor().loadingSpinnerOpacity),
    child: Center(child: SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
              color: customColorController.customColor().loadingSpinnerColor),
        );
      },
    )),
  );
}
