import 'package:flutter/material.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:get/get.dart';
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

  bool colorOpen = false;
  bool fontOpen = false;
  bool languageOpen = false;

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

  void changeLanguage(lang) {
    localizationController.changeLanguage(lang);
    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return safeAreaView(
        context, localizationController.localiztionThemeScreen().title,
        children: [
          titleButton(context,
              title: localizationController.localiztionThemeScreen().colorTitle,
              isOpen: colorOpen,
              onPress: onPressColor),
          colorOpen
              ? radioButtonList(context, [0, 1, 2], colorController.colorType,
                  colorController.changeColorMode, 'ColorMode')
              : SizedBox(),
          titleButton(context,
              title: localizationController.localiztionThemeScreen().fontTitle,
              isOpen: fontOpen,
              onPress: onPressFont),
          fontOpen
              ? radioButtonList(context, [0, 1, 2], fontController.fontType,
                  fontController.changeFontMode, 'FontMode')
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
                  localizationController.language,
                  changeLanguage,
                  'LanguageMode')
              : SizedBox(),
        ]);
  }
}

Widget radioButtonList(
  BuildContext context,
  List group,
  RxInt selectValue,
  Function(int value) onPressItem,
  String itemText,
) {
  final CustomFontController fontController = Get.put(CustomFontController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
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
                            Text('$itemText $index',
                                style: selectValue.value == index
                                    ? fontController.customFont().bold12
                                    : fontController.customFont().medium12),
                            selectValue.value == index
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
