import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'dart:io' show Platform;

@immutable
class CustomButton extends StatelessWidget {
  final FirebaseAnalyticsController firebaseAnalyticsController =
      Get.put(FirebaseAnalyticsController());
  final CustomColorController colorController =
      Get.put(CustomColorController());

  final Function()? onPress;
  final BoxDecoration? boxDecoration;
  final Widget child;
  final BorderRadius? borderRadius;
  late final Color? highlightColor;
  late final Color? splashColor;

  CustomButton({
    this.onPress,
    this.boxDecoration,
    this.borderRadius,
    this.highlightColor,
    this.splashColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    onTap() async {
      // final screenName = ModalRoute.of(context)?.settings.name;
      // if (screenName != null) {
      //   String result = screenName.replaceAll('/', '');
      //   await firebaseAnalyticsController.clickEvent(
      //       name: 'custom_button',
      //       parameters: {
      //         'screenName': result,
      //         'platform': Platform.isIOS ? 'ios' : 'android'
      //       });
      // }
      if (onPress != null) {
        onPress!();
      }
    }

    return Stack(children: <Widget>[
      child,
      Positioned.fill(
        child: Material(
          color: const Color.fromRGBO(0, 0, 0, 0),
          child: Obx(() => InkWell(
                onTap: onTap,
                borderRadius: borderRadius,
                highlightColor: highlightColor,
                splashColor:
                    splashColor ?? colorController.customColor().transparent,
                hoverColor: colorController.customColor().buttonOpacity,
              )),
        ),
      ),
    ]);
  }
}
