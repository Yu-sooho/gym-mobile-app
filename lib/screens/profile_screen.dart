import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screens/package_screen.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

@immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

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
          imageUri: firebaseAuthController.currentUserData?['photoURL']));
  late OverlayEntry overlayLogout = OverlayEntry(
      builder: (_) => customModalScreen(
          title:
              localizationController.localiztionModalScreenText().logoutTitle,
          description:
              localizationController.localiztionModalScreenText().logoutText,
          onPressCancel: logoutCancel,
          onPressOk: () => {logout(context)}));

  void onPressImage(BuildContext context) {
    if (firebaseAuthController.currentUserData?['photoURL'] == null) return;

    if (overlayPhoto.mounted) {
      overlayPhoto.remove();
      return;
    }

    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayPhoto);
  }

  void onPressTheme() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThemeScreen()),
    );
  }

  void onPressSetting() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingScreen()),
    );
  }

  void onPressEdit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileEditScreen()),
    );
  }

  void onPressInquiry() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InquiryScreen()),
    );
  }

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
    final user = firebaseAuthController.currentUserData;
    print(firebaseAuthController.currentUserData['email']);
    return safeAreaView(
      context,
      localizationController.localiztionProfileScreen().title,
      children: [
        SizedBox(
            child: Padding(
          padding: EdgeInsets.only(top: 24),
          child: userProfileButton(context, user, onPressImage),
        )),
        SizedBox(
          height: 20,
        ),
        Container(
            alignment: Alignment.center,
            width: appStateController.width2,
            child: Obx(() => Column(children: [
                  Text(
                    '${user?['displayName']}',
                    style: fontController.customFont().bold12,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '${user?['phoneNumber']}',
                      style: fontController.customFont().medium12,
                      textAlign: TextAlign.center,
                    ),
                  )
                ]))),
        SizedBox(height: 16),
        CustomButton(
            onPress: onPressEdit,
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
                      localizationController.localiztionProfileScreen().edit,
                      style: fontController.customFont().bold12,
                    )
                  ]),
            )),
        SizedBox(
          height: 24,
        ),
        RightArrowButton(
            onPress: onPressSetting,
            title: localizationController.localiztionProfileScreen().setting),
        RightArrowButton(
            onPress: onPressTheme,
            title: localizationController.localiztionProfileScreen().theme),
        RightArrowButton(
            onPress: onPressInquiry,
            title: localizationController.localiztionProfileScreen().inquiry),
        RightArrowButton(
            onPress: () => {onPressLogout(context)},
            isHaveRight: false,
            textStyle: fontController.customFont().medium12,
            title: localizationController.localiztionProfileScreen().logout)
      ],
    );
  }
}
