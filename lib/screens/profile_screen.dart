import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

@immutable
class ProfileScreen extends StatefulWidget {
  final User? currentUser;
  ProfileScreen({super.key, this.currentUser});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());

  late OverlayEntry overlayEntrys = OverlayEntry(builder: photo);

  void onPressImage(BuildContext context) {
    if (overlayEntrys.mounted) {
      overlayEntrys.remove();
      return;
    }
    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayEntrys);
  }

  Widget photo(BuildContext context) {
    return Scaffold(
        backgroundColor: colorController.customColor().loadingSpinnerOpacity,
        body: CustomButton(
            highlightColor: colorController.customColor().transparent,
            splashColor: colorController.customColor().transparent,
            onPress: () => onPressImage(context),
            child: CachedNetworkImage(
              imageUrl:
                  'https://image.dongascience.com/Photo/2017/10/15076010680571.jpg',
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

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Obx(() => Scaffold(
            backgroundColor: colorController.customColor().defaultBackground,
          )),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
              child: SizedBox(
            child: Column(children: [
              CustomHeader(
                  title:
                      localizationController.localiztionProfileScreen().title,
                  onPressLeft: () => {Navigator.of(context).pop()}),
              SizedBox(
                  child: Padding(
                padding: EdgeInsets.only(top: 0),
                child: userContainer(
                    context,
                    widget.currentUser ?? firebaseAuthController.currentUser,
                    onPressImage),
              ))
            ]),
          )))
    ]);
  }
}

Widget userContainer(
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
        height: 24,
      ),
      Container(
          alignment: Alignment.center,
          width: appStateController.width2,
          child: Obx(() => Text(
                '${user?.displayName}',
                style: fontController.customFont().bold12,
                textAlign: TextAlign.center,
              )))
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
