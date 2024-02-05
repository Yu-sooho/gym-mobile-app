import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gym_calendar/stores/package_stores.dart';

Widget loadingFotter(bool loading, bool isRefresh) {
  Stores stores = Stores();

  return (SizedBox(
      height: 72,
      child: Align(
        child: loading && !isRefresh
            ? SpinKitFadingCircle(
                size: 24,
                color: stores.colorController.customColor().loadingSpinnerColor,
              )
            : SizedBox(),
      )));
}
