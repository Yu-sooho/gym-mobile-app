import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gym_calendar/stores/package_stores.dart';

Widget emptyContainer(bool exerciseLoading, bool isRefresh) {
  Stores stores = Stores();

  return (SizedBox(
    height: 120,
    child: Align(
        child: exerciseLoading
            ? SpinKitFadingCircle(
                size: 24,
                color: stores.colorController.customColor().loadingSpinnerColor,
              )
            : Text(
                stores.localizationController
                    .localiztionExerciseScreen()
                    .noExercise,
                style: stores.fontController.customFont().medium12,
              )),
  ));
}
