import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/main.dart';
import 'package:gym_calendar/screens/package_screen.dart';
import 'package:gym_calendar/stores/firebase/firebase_auth.dart';
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

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future getUserData() async {
    final uid = stores.firebaseAuthController.uid;
    if (uid == null) {
      Main.navigatorKey.currentState!.pop();
    }
    final result = await stores.firebaseAuthController.getUser();
    if (!result) {
      Main.navigatorKey.currentState!.pop();
    }
    return true;
  }

  void onPressImage(BuildContext context) {
    if (stores.firebaseAuthController.currentUserData.photoURL?.value == null) {
      return;
    }

    showDialog(
        context: context,
        builder: (context) => PhotoScreen(
            onPress: () => {Navigator.pop(context)},
            imageUri:
                stores.firebaseAuthController.currentUserData.photoURL?.value ??
                    ''));
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
    showDialog(
        context: context,
        builder: (context) => CustomModalScreen(
            title: stores.localizationController
                .localiztionModalScreenText()
                .logoutTitle,
            description: stores.localizationController
                .localiztionModalScreenText()
                .logoutText,
            onPressCancel: logoutCancel,
            onPressOk: () => {logout(context)}));
  }

  void logoutCancel() {
    Navigator.pop(context);
  }

  void logout(BuildContext context) async {
    await stores.localizationController.changeLanguage(1);
    await stores.fontController.changeFontMode(0);
    await stores.colorController.changeColorMode(0);
    await stores.firebaseAuthController.signOut();
    stores.firebaseAuthController.currentUserData = UserData();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaView(
      title: stores.localizationController.localiztionProfileScreen().title,
      children: [
        SizedBox(
            child: Padding(
          padding: EdgeInsets.only(top: 24),
          child: Obx(() => UserProfileButton(
                skeletonColor:
                    stores.colorController.customColor().skeletonColor,
                imageUrl: stores
                    .firebaseAuthController.currentUserData.photoURL?.value,
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
                    '${stores.firebaseAuthController.currentUserData.displayName}',
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
                            .copyWith())
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
