import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class UserProfileButton extends StatefulWidget {
  final Function? onPressImage;
  final File? image;
  final String? imageUrl;
  final Color? skeletonColor;
  UserProfileButton(
      {super.key,
      this.onPressImage,
      this.image,
      this.imageUrl,
      this.skeletonColor});

  @override
  State<UserProfileButton> createState() => _UserProfileButtonState();
}

class _UserProfileButtonState extends State<UserProfileButton> {
  @override
  Widget build(BuildContext context) {
    final onPressImage = widget.onPressImage;
    final File? image = widget.image;
    final String? imageUrl = widget.imageUrl;

    final Stores stores = Get.put(Stores());

    return SizedBox(
      child: Column(children: [
        InkWell(
            child: CustomButton(
          onPress: () => {onPressImage!(context)},
          borderRadius: BorderRadius.circular(50),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: widget.skeletonColor ??
                      stores.colorController.customColor().skeletonColor),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Stack(children: <Widget>[
                        Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: stores.colorController
                                    .customColor()
                                    .skeletonColor),
                            child: SpinKitThreeBounce(
                              color: stores.colorController
                                  .customColor()
                                  .loadingSpinnerColor,
                              size: 15,
                            )),
                        Image.file(
                          image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      ]))
                  : imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl ?? '',
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
                        )
                      : errorBox()),
        )),
      ]),
    );
  }

  Widget skeletonBox() {
    final Stores stores = Get.put(Stores());

    return Obx(() => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: stores.colorController.customColor().skeletonColor,
          ),
          width: 100.0,
          height: 100.0,
          child: SpinKitThreeBounce(
            color: stores.colorController.customColor().loadingSpinnerColor,
            size: 15,
          ),
        ));
  }

  Widget errorBox() {
    final Stores stores = Get.put(Stores());

    return Obx(() => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: stores.colorController.customColor().skeletonColor,
          ),
          width: 100.0,
          height: 100.0,
          child: Icon(
            Icons.photo,
            color: stores.colorController.customColor().skeletonColor2,
            size: 55,
          ),
        ));
  }
}
