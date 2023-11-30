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
  final Stores stores = Get.put(Stores());
  return Scaffold(
      backgroundColor: backgroundColor ??
          stores.colorController.customColor().loadingSpinnerOpacity,
      body: CustomButton(
          highlightColor: highlightColor ??
              stores.colorController.customColor().transparent,
          splashColor:
              splashColor ?? stores.colorController.customColor().transparent,
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
  final Stores stores = Get.put(Stores());

  return Obx(() => SpinKitThreeBounce(
        color: stores.colorController.customColor().loadingSpinnerColor,
        size: 15,
      ));
}

Widget errorBox() {
  final Stores stores = Get.put(Stores());

  return Obx(() => Container(
        decoration: BoxDecoration(
          color: stores.colorController.customColor().loadingSpinnerOpacity,
        ),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Container(
            width: double.infinity,
            height: 400,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: stores.colorController.customColor().skeletonColor,
            ),
            child: Icon(
              Icons.photo,
              color: stores.colorController.customColor().skeletonColor2,
              size: 100,
            )),
      ));
}
