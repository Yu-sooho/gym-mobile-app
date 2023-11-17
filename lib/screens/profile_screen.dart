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

  void onPressImage() {}

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

Widget userContainer(BuildContext context, User? user, onPressImage) {
  final CustomFontController fontController = Get.put(CustomFontController());

  return SizedBox(
    child: Column(children: [
      InkWell(
          child: CachedNetworkImage(
        imageUrl:
            'https://docs.flutter.dev/assets/images/dash/dasfdfdh-fainting.gif',
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
      )),
      SizedBox(
          child: Obx(() => Text('${user?.displayName}',
              style: fontController.customFont().medium12)))
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
          Icons.error_outline,
          color: Colors.white,
          size: 100,
        ),
      ));
}
