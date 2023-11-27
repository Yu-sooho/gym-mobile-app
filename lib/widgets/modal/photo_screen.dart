import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

Widget photoScreen(
    {BuildContext? context,
    Color? backgroundColor,
    Color? highlightColor,
    Color? splashColor,
    Function()? onPress,
    String imageUri = ''}) {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  return Scaffold(
      backgroundColor: backgroundColor ??
          colorController.customColor().loadingSpinnerOpacity,
      body: CustomButton(
          highlightColor:
              highlightColor ?? colorController.customColor().transparent,
          splashColor: splashColor ?? colorController.customColor().transparent,
          onPress: onPress,
          child: CachedNetworkImage(
            imageUrl: imageUri,
            placeholder: (context, url) => skeletonBox(),
            errorWidget: (context, url, error) => errorBox(),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: imageProvider,
                ),
              ),
            ),
          )));
}

Widget skeletonBox() {
  final CustomColorController colorController =
      Get.put(CustomColorController());

  return Obx(() => SpinKitThreeBounce(
        color: colorController.customColor().loadingSpinnerColor,
        size: 15,
      ));
}

Widget errorBox() {
  final CustomColorController colorController =
      Get.put(CustomColorController());

  return Obx(() => Container(
        decoration: BoxDecoration(
          color: colorController.customColor().loadingSpinnerOpacity,
        ),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Container(
            width: double.infinity,
            height: 400,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorController.customColor().skeletonColor,
            ),
            child: Icon(
              Icons.photo,
              color: colorController.customColor().skeletonColor2,
              size: 100,
            )),
      ));
}
