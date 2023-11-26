import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

Widget userProfileButton(BuildContext context, dynamic user, onPressImage,
    {File? image}) {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());

  return SizedBox(
    child: Column(children: [
      InkWell(
          child: CustomButton(
        onPress: () => {onPressImage(context)},
        borderRadius: BorderRadius.circular(50),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: colorController.customColor().skeletonColor),
            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ))
                : CachedNetworkImage(
                    imageUrl:
                        firebaseAuthController.currentUserData?['photoURL'] ??
                            '',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => skeletonBox(),
                    errorWidget: (context, url, error) => errorBox(),
                  )),
      )),
    ]),
  );
}

Widget skeletonBox() {
  final CustomColorController colorController =
      Get.put(CustomColorController());

  return Obx(() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: colorController.customColor().skeletonColor,
        ),
        width: 100.0,
        height: 100.0,
      ));
}

Widget errorBox() {
  final CustomColorController colorController =
      Get.put(CustomColorController());

  return Obx(() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: colorController.customColor().skeletonColor,
        ),
        width: 100.0,
        height: 100.0,
        child: Icon(
          Icons.camera,
          color: colorController.customColor().skeletonColor2,
          size: 100,
        ),
      ));
}
