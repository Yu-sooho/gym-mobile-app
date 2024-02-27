import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class PhotoScreen extends StatelessWidget {
  final Color? backgroundColor;
  final Color? highlightColor;
  final Color? splashColor;
  final Function()? onPress;
  final String imageUri;

  const PhotoScreen({
    super.key,
    this.backgroundColor,
    this.highlightColor,
    this.splashColor,
    this.onPress,
    required this.imageUri,
  });

  @override
  Widget build(BuildContext context) {
    final Stores stores = Get.put(Stores());
    return Scaffold(
      backgroundColor:
          backgroundColor ?? stores.colorController.customColor().transparent,
      body: CustomButton(
        highlightColor:
            highlightColor ?? stores.colorController.customColor().transparent,
        splashColor:
            splashColor ?? stores.colorController.customColor().transparent,
        onPress: onPress,
        child: CachedNetworkImage(
          imageUrl: imageUri,
          placeholder: (context, url) => SkeletonBox(),
          errorWidget: (context, url, error) => ErrorBox(),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: imageProvider,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SkeletonBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stores stores = Get.put(Stores());
    return Obx(
      () => SpinKitThreeBounce(
        color: stores.colorController.customColor().loadingSpinnerColor,
        size: 15,
      ),
    );
  }
}

class ErrorBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stores stores = Get.put(Stores());
    return Obx(
      () => Container(
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
          ),
        ),
      ),
    );
  }
}
