import 'package:flutter/material.dart';
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
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final AppStateController appStateController = Get.put(AppStateController());
  final CustomFontController fontController = Get.put(CustomFontController());

  late OverlayEntry overlayPopup;

  bool colorOpen = false;
  bool fontOpen = false;
  bool languageOpen = false;

  late int nowColor = colorController.colorType.value;
  late int nowFont = fontController.fontType.value;
  late int language = localizationController.language.value;

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
            title: localizationController
                .localiztionModalScreenText()
                .themeChangeTitle,
            description: localizationController
                .localiztionModalScreenText()
                .themeChangeText,
            onPressCancel: () {
              overlayPopup.remove();
            },
            onPressOk: () {
              overlayPopup.remove();
              localizationController.changeLanguage(language);
              fontController.changeFontMode(nowFont);
              colorController.changeColorMode(nowColor);
              Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
            }));
    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayPopup);
  }

  bool checkCanSave() {
    if (nowColor != colorController.colorType.value) return false;
    if (nowFont != fontController.fontType.value) return false;
    if (language != localizationController.language.value) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return safeAreaView(
        context, localizationController.localiztionThemeScreen().title,
        rightText: localizationController.localiztionComponentButton().save,
        isRightInActive: checkCanSave(),
        onPressRight: changeTheme,
        children: [
          titleButton(context,
              title: localizationController.localiztionThemeScreen().colorTitle,
              isOpen: colorOpen,
              onPress: onPressColor),
          colorOpen
              ? radioButtonList(
                  context,
                  [0, 1, 2],
                  nowColor,
                  selectColor,
                  'ColorMode',
                  localizationController.localiztionThemeScreen().colorName,
                  isColor: true)
              : SizedBox(),
          titleButton(context,
              title: localizationController.localiztionThemeScreen().fontTitle,
              isOpen: fontOpen,
              onPress: onPressFont),
          fontOpen
              ? radioButtonList(
                  context,
                  [0, 1, 2],
                  nowFont,
                  selectFont,
                  'FontMode',
                  localizationController.localiztionThemeScreen().fontName,
                  isFont: true)
              : SizedBox(),
          titleButton(context,
              title:
                  localizationController.localiztionThemeScreen().languageTitle,
              isOpen: languageOpen,
              onPress: onPressLanguage),
          languageOpen
              ? radioButtonList(
                  context,
                  [0, 1],
                  language,
                  selectLanguage,
                  'LanguageMode',
                  localizationController.localiztionThemeScreen().languageName)
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
  final CustomFontController fontController = Get.put(CustomFontController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
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
                                                fontFamily: fontController
                                                    .customFont()
                                                    .medium12
                                                    .fontFamily)
                                            : fontController.customFont().bold12
                                    : isFont
                                        ? fontList[index].medium12
                                        : isColor
                                            ? TextStyle(
                                                color: colorList[index]
                                                    .defaultTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: fontController
                                                    .customFont()
                                                    .medium12
                                                    .fontFamily)
                                            : fontController
                                                .customFont()
                                                .medium12),
                            selectValue == index
                                ? Icon(
                                    Icons.check,
                                    color: colorController
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

Widget titleButton(BuildContext context,
    {bool isOpen = false, String title = '', Function()? onPress}) {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final CustomFontController fontController = Get.put(CustomFontController());
  final AppStateController appStateController = Get.put(AppStateController());

  return (CustomButton(
      onPress: onPress,
      child: Container(
          width: appStateController.logicalWidth.value,
          height: 52,
          decoration: BoxDecoration(
              color: colorController.customColor().defaultBackground),
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: fontController.customFont().bold12),
                    isOpen
                        ? Icon(
                            Icons.arrow_drop_up,
                            color: colorController
                                .customColor()
                                .bottomTabBarActiveItem,
                            size: 24,
                          )
                        : Icon(
                            Icons.arrow_drop_down,
                            color: colorController
                                .customColor()
                                .bottomTabBarActiveItem,
                            size: 24,
                          ),
                  ])))));
}
