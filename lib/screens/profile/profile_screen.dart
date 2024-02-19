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
  final Stores stores = Get.put(Stores());

  late OverlayEntry overlayPhoto = OverlayEntry(
      builder: (_) => photoScreen(
          onPress: () => onPressImage(context),
          imageUri:
              stores.firebaseAuthController.currentUserData.photoURL?.value ??
                  ''));
  late OverlayEntry overlayLogout = OverlayEntry(
      builder: (_) => customModalScreen(
          title: stores.localizationController
              .localiztionModalScreenText()
              .logoutTitle,
          description: stores.localizationController
              .localiztionModalScreenText()
              .logoutText,
          onPressCancel: logoutCancel,
          onPressOk: () => {logout(context)}));

  void onPressImage(BuildContext context) {
    if (stores.firebaseAuthController.currentUserData.photoURL?.value == null) {
      return;
    }
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
      MaterialPageRoute(
          builder: (context) => ThemeScreen(),
          settings: RouteSettings(name: 'theme')),
    );
  }

  void onPressSetting() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SettingScreen(),
          settings: RouteSettings(name: 'setting')),
    );
  }

  void onPressEdit() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileEditScreen(),
          settings: RouteSettings(name: 'profile_edit')),
    );
  }

  void onPressInquiry() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => InquiryScreen(),
          settings: RouteSettings(name: 'inquriy')),
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
    await stores.localizationController.changeLanguage(1);
    await stores.fontController.changeFontMode(0);
    await stores.colorController.changeColorMode(0);
    await stores.firebaseAuthController.signOut();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = stores.firebaseAuthController.currentUserData;
    return safeAreaView(
      context,
      stores.localizationController.localiztionProfileScreen().title,
      children: [
        SizedBox(
            child: Padding(
          padding: EdgeInsets.only(top: 24),
          child: Obx(() => UserProfileButton(
                skeletonColor:
                    stores.colorController.customColor().skeletonColor,
                imageUrl: user.photoURL?.value,
                onPressImage: onPressImage,
              )),
        )),
        SizedBox(
          height: 20,
        ),
        Container(
            alignment: Alignment.center,
            width: stores.appStateController.width2,
            child: Obx(() => Column(children: [
                  Text(
                    '${user.displayName}',
                    style: stores.fontController.customFont().bold12,
                    textAlign: TextAlign.center,
                  ),
                ]))),
        SizedBox(height: 16),
        CustomButton(
            onPress: onPressEdit,
            borderRadius: BorderRadius.circular(10),
            highlightColor: stores.colorController.customColor().buttonOpacity,
            child: Container(
              height: 32,
              width: 320,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: stores.colorController.customColor().buttonActiveColor,
                  border: Border.all(
                      color:
                          stores.colorController.customColor().buttonBorder)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        stores.localizationController
                            .localiztionProfileScreen()
                            .edit,
                        style: stores.fontController
                            .customFont()
                            .bold12
                            .copyWith(
                                color: stores.colorController
                                    .customColor()
                                    .buttonActiveText))
                  ]),
            )),
        SizedBox(
          height: 24,
        ),
        RightArrowButton(
            onPress: onPressSetting,
            title: stores.localizationController
                .localiztionProfileScreen()
                .setting),
        RightArrowButton(
            onPress: onPressTheme,
            title:
                stores.localizationController.localiztionProfileScreen().theme),
        RightArrowButton(
            onPress: onPressInquiry,
            title: stores.localizationController
                .localiztionProfileScreen()
                .inquiry),
        RightArrowButton(
            onPress: () => {onPressLogout(context)},
            isHaveRight: false,
            textStyle: stores.fontController.customFont().medium12,
            title:
                stores.localizationController.localiztionProfileScreen().logout)
      ],
    );
  }
}
