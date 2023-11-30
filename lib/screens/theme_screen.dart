import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/styles/custom_colors.dart';
import 'package:gym_calendar/stores/styles/custom_fonts.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

@immutable
class ThemeScreen extends StatefulWidget {
  ThemeScreen({super.key});
  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  final storage = FlutterSecureStorage();

  final Stores stores = Get.put(Stores());

  late OverlayEntry overlayPopup;

  bool colorOpen = false;
  bool fontOpen = false;
  bool languageOpen = false;

  late int nowColor = stores.colorController.colorType.value;
  late int nowFont = stores.fontController.fontType.value;
  late int language = stores.localizationController.language.value;

  void onPressColor() {
    setState(() {
      colorOpen = !colorOpen;
    });
  }

  void onPressFont() {
    setState(() {
      fontOpen = !fontOpen;
    });
  }

  void onPressLanguage() {
    setState(() {
      languageOpen = !languageOpen;
    });
  }

  void selectColor(int value) {
    setState(() {
      nowColor = value;
    });
  }

  void selectFont(int value) {
    setState(() {
      nowFont = value;
    });
  }

  void selectLanguage(int value) {
    setState(() {
      language = value;
    });
  }

  void changeTheme() {
    overlayPopup = OverlayEntry(
        builder: (_) => customModalScreen(
            title: stores.localizationController
                .localiztionModalScreenText()
                .themeChangeTitle,
            description: stores.localizationController
                .localiztionModalScreenText()
                .themeChangeText,
            onPressCancel: () {
              overlayPopup.remove();
            },
            onPressOk: () async {
              overlayPopup.remove();
              await stores.localizationController.changeLanguage(language);
              await stores.fontController.changeFontMode(nowFont);
              await stores.colorController.changeColorMode(nowColor);
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (_) => false);
              }
            }));
    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayPopup);
  }

  bool checkCanSave() {
    if (nowColor != stores.colorController.colorType.value) return false;
    if (nowFont != stores.fontController.fontType.value) return false;
    if (language != stores.localizationController.language.value) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return safeAreaView(
        context, stores.localizationController.localiztionThemeScreen().title,
        rightText:
            stores.localizationController.localiztionComponentButton().save,
        isRightInActive: checkCanSave(),
        onPressRight: changeTheme,
        children: [
          SizedBox(
            height: 24,
          ),
          titleButton(context,
              title: stores.localizationController
                  .localiztionThemeScreen()
                  .colorTitle,
              isOpen: colorOpen,
              onPress: onPressColor),
          colorOpen
              ? radioButtonList(
                  context,
                  [0, 1, 2],
                  nowColor,
                  selectColor,
                  'ColorMode',
                  stores.localizationController
                      .localiztionThemeScreen()
                      .colorName,
                  isColor: true)
              : SizedBox(),
          titleButton(context,
              title: stores.localizationController
                  .localiztionThemeScreen()
                  .fontTitle,
              isOpen: fontOpen,
              onPress: onPressFont),
          fontOpen
              ? radioButtonList(
                  context,
                  [0, 1, 2],
                  nowFont,
                  selectFont,
                  'FontMode',
                  stores.localizationController
                      .localiztionThemeScreen()
                      .fontName,
                  isFont: true)
              : SizedBox(),
          titleButton(context,
              title: stores.localizationController
                  .localiztionThemeScreen()
                  .languageTitle,
              isOpen: languageOpen,
              onPress: onPressLanguage),
          languageOpen
              ? radioButtonList(
                  context,
                  [0, 1],
                  language,
                  selectLanguage,
                  'LanguageMode',
                  stores.localizationController
                      .localiztionThemeScreen()
                      .languageName)
              : SizedBox(),
        ]);
  }
}

Widget radioButtonList(
  BuildContext context,
  List group,
  int selectValue,
  Function(int value) onPressItem,
  String itemText,
  List<String> names, {
  bool isFont = false,
  bool isColor = false,
}) {
  final Stores stores = Get.put(Stores());

  final CustomFont1 font1 = CustomFont1();
  final CustomFont2 font2 = CustomFont2();
  final CustomFont3 font3 = CustomFont3();
  final List fontList = [font1, font2, font3];

  final CustomColorMode1 colorMode1 = CustomColorMode1();
  final CustomColorMode2 colorMode2 = CustomColorMode2();
  final CustomColorMode3 colorMode3 = CustomColorMode3();
  final List colorList = [colorMode1, colorMode2, colorMode3];

  return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      itemCount: group.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Obx(() => CustomButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPress: () => onPressItem(index),
              child: SizedBox(
                  height: 48,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(names[index],
                                style: selectValue == index
                                    ? isFont
                                        ? fontList[index].bold12
                                        : isColor
                                            ? TextStyle(
                                                color: colorList[index]
                                                    .defaultTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: stores
                                                    .fontController
                                                    .customFont()
                                                    .medium12
                                                    .fontFamily)
                                            : stores.fontController
                                                .customFont()
                                                .bold12
                                    : isFont
                                        ? fontList[index].medium12
                                        : isColor
                                            ? TextStyle(
                                                color: colorList[index]
                                                    .defaultTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: stores
                                                    .fontController
                                                    .customFont()
                                                    .medium12
                                                    .fontFamily)
                                            : stores.fontController
                                                .customFont()
                                                .medium12),
                            selectValue == index
                                ? Icon(
                                    Icons.check,
                                    color: stores.colorController
                                        .customColor()
                                        .bottomTabBarActiveItem,
                                    size: 12,
                                  )
                                : SizedBox()
                          ],
                        ),
                      ))),
            ));
      });
}
