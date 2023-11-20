import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screens/package_screen.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

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
  final AppStateController appStateController = Get.put(AppStateController());
  final CustomFontController fontController = Get.put(CustomFontController());

  late OverlayEntry overlayPhoto = OverlayEntry(
      builder: (_) => photoScreen(
          onPress: () => onPressImage(context),
          imageUri:
              'https://image.dongascience.com/Photo/2017/10/15076010680571.jpg'));

  late OverlayEntry overlayLogout = OverlayEntry(
      builder: (_) => customModalScreen(
          title:
              localizationController.localiztionModalScreenText().logoutTitle,
          description:
              localizationController.localiztionModalScreenText().logoutText,
          onPressCancel: logoutCancel,
          onPressOk: () => {logout(context)}));

  void onPressImage(BuildContext context) {
    if (overlayPhoto.mounted) {
      overlayPhoto.remove();
      return;
    }
    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayPhoto);
  }

  void onPressSetting() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingScreen()),
    );
  }

  void onPressInquiry() {}
  void onPressLogout(BuildContext context) {
    if (overlayLogout.mounted) {
      overlayLogout.remove();
      return;
    }
    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayLogout);
  }

  void logoutCancel() {
    if (overlayLogout.mounted) {
      overlayLogout.remove();
      return;
    }
  }

  void logout(BuildContext context) async {
    if (overlayLogout.mounted) {
      overlayLogout.remove();
    }
    await firebaseAuthController.signOut();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Obx(() => Scaffold(
            backgroundColor: colorController.customColor().defaultBackground,
          )),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(children: [
            CustomHeader(
                title: localizationController.localiztionProfileScreen().title,
                onPressLeft: () => {Navigator.of(context).pop()}),
            SizedBox(
              height: appStateController.logicalHeight.value -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 24),
                child: Column(children: [
                  SizedBox(
                      child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: userProfileButton(
                        context,
                        widget.currentUser ??
                            firebaseAuthController.currentUser,
                        onPressImage),
                  )),
                  SizedBox(height: 16),
                  CustomButton(
                      child: Container(
                    height: 32,
                    width: 320,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: colorController.customColor().buttonBorder)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            localizationController
                                .localiztionProfileScreen()
                                .edit,
                            style: fontController.customFont().bold12,
                          )
                        ]),
                  )),
                  SizedBox(
                    height: 24,
                  ),
                  RightArrowButton(
                      onPress: onPressSetting,
                      title: localizationController
                          .localiztionProfileScreen()
                          .setting),
                  RightArrowButton(
                      onPress: onPressInquiry,
                      title: localizationController
                          .localiztionProfileScreen()
                          .inquiry),
                  RightArrowButton(
                      onPress: () => {onPressLogout(context)},
                      isHaveRight: false,
                      textStyle: fontController.customFont().medium12,
                      title: localizationController
                          .localiztionProfileScreen()
                          .logout)
                ]),
              ),
            )
          ]))
    ]);
  }
}
