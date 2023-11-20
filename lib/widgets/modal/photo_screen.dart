import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
