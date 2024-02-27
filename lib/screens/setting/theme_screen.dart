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

class _ThemeScreenState extends State<ThemeScreen>
    with TickerProviderStateMixin {
  final storage = FlutterSecureStorage();

  final Stores stores = Get.put(Stores());

  bool colorOpen = false;
  bool fontOpen = false;
  bool languageOpen = false;

  late int nowColor = stores.colorController.colorType.value;
  late int nowFont = stores.fontController.fontType.value;
  late int language = stores.localizationController.language.value;
  late double fontSize = stores.appStateController.fontSize.value;

  void onPressColor() {
    setState(() {
      colorOpen = !colorOpen;
    });
  }

  void onPressFont() {
    if (fontOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
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

  void plusFontSize() {
    if (fontSize > 4) {
      stores.appStateController.showToast(stores.localizationController
          .localiztionThemeScreen()
          .errorFontSizePlus);
      return;
    }
    setState(() {
      fontSize++;
    });
  }

  void minusFontSize() {
    if (fontSize < -2) {
      stores.appStateController.showToast(stores.localizationController
          .localiztionThemeScreen()
          .errorFontSizeMinus);
      return;
    }
    setState(() {
      fontSize--;
    });
  }

  void changeTheme() {
    showDialog(
        context: context,
        builder: (context) => CustomModalScreen(
            title: stores.localizationController
                .localiztionModalScreenText()
                .themeChangeTitle,
            description: stores.localizationController
                .localiztionModalScreenText()
                .themeChangeText,
            onPressCancel: () {},
            onPressOk: () async {
              await stores.localizationController.changeLanguage(language);
              await stores.fontController.changeFontMode(nowFont);
              await stores.colorController.changeColorMode(nowColor);
              await stores.appStateController.changeFontSize(fontSize);
              if (context.mounted) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (route) => false);
              }
            }));
  }

  bool checkCanSave() {
    if (nowColor != stores.colorController.colorType.value) return false;
    if (nowFont != stores.fontController.fontType.value) return false;
    if (language != stores.localizationController.language.value) return false;
    if (fontSize != stores.appStateController.fontSize.value) return false;
    return true;
  }

  final CustomFont1 font1 = CustomFont1();
  final CustomFont2 font2 = CustomFont2();
  final CustomFont3 font3 = CustomFont3();

  final CustomColorMode1 colorMode1 = CustomColorMode1();
  final CustomColorMode2 colorMode2 = CustomColorMode2();
  final CustomColorMode3 colorMode3 = CustomColorMode3();

  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          TitleButton(
              title: stores.localizationController
                  .localiztionThemeScreen()
                  .colorTitle,
              isOpen: colorOpen,
              onPress: onPressColor),
          RadioButtonList(
            isOpen: colorOpen,
            group: [0, 1, 2],
            styleColor: [
              colorMode1.defaultTextColor,
              colorMode2.defaultTextColor,
              colorMode3.defaultTextColor
            ],
            selectValue: nowColor,
            onPressItem: selectColor,
            itemText: 'ColorMode',
            names: stores.localizationController
                .localiztionThemeScreen()
                .colorName,
          ),
          TitleButton(
              title: stores.localizationController
                  .localiztionThemeScreen()
                  .fontTitle,
              isOpen: fontOpen,
              onPress: onPressFont),
          AnimatedOpacity(
              opacity: fontOpen ? 1 : 0,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 250),
              child: SizedBox(
                height: _animation.value * 32,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                            onPress: minusFontSize,
                            child: Container(
                              alignment: Alignment.center,
                              height: 32,
                              width: 32,
                              child: Text(
                                '-',
                                style:
                                    stores.fontController.customFont().bold14,
                              ),
                            )),
                        Text('${fontSize.floor()}',
                            style: stores.fontController.customFont().bold14),
                        CustomButton(
                            onPress: plusFontSize,
                            child: Container(
                              alignment: Alignment.center,
                              height: 32,
                              width: 32,
                              child: Text('+',
                                  style: stores.fontController
                                      .customFont()
                                      .bold14),
                            )),
                      ]),
                ),
              )),
          RadioButtonList(
            isOpen: fontOpen,
            group: [0, 1, 2],
            styleGroup: [font1.medium12, font2.medium12, font3.medium12],
            selectValue: nowFont,
            onPressItem: selectFont,
            itemText: 'FontMode',
            names:
                stores.localizationController.localiztionThemeScreen().fontName,
          ),
          TitleButton(
              title: stores.localizationController
                  .localiztionThemeScreen()
                  .languageTitle,
              isOpen: languageOpen,
              onPress: onPressLanguage),
          RadioButtonList(
              isOpen: languageOpen,
              group: [0, 1],
              selectValue: language,
              onPressItem: selectLanguage,
              itemText: 'LanguageMode',
              names: stores.localizationController
                  .localiztionThemeScreen()
                  .languageName),
        ]);
  }
}
