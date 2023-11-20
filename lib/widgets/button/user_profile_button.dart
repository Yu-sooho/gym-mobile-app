import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

Widget userProfileButton(
  BuildContext context,
  User? user,
  onPressImage,
) {
  final CustomFontController fontController = Get.put(CustomFontController());
  final AppStateController appStateController = Get.put(AppStateController());

  return SizedBox(
    child: Column(children: [
      InkWell(
          child: CustomButton(
        onPress: () => {onPressImage(context)},
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          imageUrl:
              'https://image.dongascience.com/Photo/2017/10/15076010680571.jpg',
          imageBuilder: (context, imageProvider) => Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => skeletonBox(),
          errorWidget: (context, url, error) => errorBox(),
        ),
      )),
      SizedBox(
        height: 20,
      ),
      Container(
          alignment: Alignment.center,
          width: appStateController.width2,
          child: Obx(() => Column(children: [
                Text(
                  '${user?.displayName}',
                  style: fontController.customFont().bold12,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '${user?.phoneNumber}',
                    style: fontController.customFont().medium12,
                    textAlign: TextAlign.center,
                  ),
                )
              ]))),
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
