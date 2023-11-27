import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class InquiryScreen extends StatefulWidget {
  InquiryScreen({super.key});

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  final LocalizationController localizationController =
      Get.put(LocalizationController());

  bool inquiryOpen = true;
  bool listOpen = false;

  bool inquiryTitleError = false;
  bool inquiryContentError = false;

  String title = '';
  String content = '';

  void onPressListOpen() {
    setState(() {
      listOpen = !listOpen;
    });
  }

  void onPressInquiryOpen() {
    setState(() {
      inquiryOpen = !inquiryOpen;
    });
  }

  void onPressInquiry() {
    setState(() {
      inquiryTitleError = true;
      inquiryContentError = true;
    });
  }

  void onChangeTitle(String value) {
    setState(() {
      inquiryTitleError = false;
      title = value;
    });
  }

  void onChangeContent(String value) {
    setState(() {
      inquiryContentError = false;
      content = value;
    });
  }

  String? validateTitle(value) {
    final check = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (inquiryTitleError) {
      return localizationController.localiztionInquiryScreen().errorTitle;
    }
    if (check) {
      return localizationController.localiztionInquiryScreen().errorTitle;
    }

    return null;
  }

  String? validateContent(value) {
    final check = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (inquiryContentError) {
      return localizationController.localiztionInquiryScreen().errorContent;
    }
    if (check) {
      return localizationController.localiztionInquiryScreen().errorContent;
    }
    return null;
  }

  String inquiryTitle = '';
  String inquiryContent = '';

  @override
  Widget build(BuildContext context) {
    return (safeAreaView(
        context, localizationController.localiztionInquiryScreen().title,
        children: [
          SizedBox(
            height: 24,
          ),
          titleButton(context,
              title: localizationController.localiztionInquiryScreen().inquiry,
              onPress: onPressInquiryOpen,
              isOpen: inquiryOpen),
          inquiryOpen
              ? inquiryContainer(context,
                  title: inquiryTitle,
                  content: inquiryContent,
                  onPressInquiry: onPressInquiry,
                  onChangeTitle: onChangeTitle,
                  onChangeContent: onChangeContent,
                  validateTitle: validateTitle,
                  validateContent: validateContent,
                  isReady: title != '' &&
                      content != '' &&
                      !inquiryTitleError &&
                      !inquiryContentError)
              : SizedBox(),
          titleButton(context,
              title:
                  localizationController.localiztionInquiryScreen().inquiryList,
              onPress: onPressListOpen,
              isOpen: listOpen)
        ]));
  }
}

Widget inquiryContainer(BuildContext context,
    {String title = '',
    String content = '',
    onPressInquiry,
    onChangeTitle,
    onChangeContent,
    validateTitle,
    validateContent,
    bool isReady = false}) {
  final CustomFontController fontController = Get.put(CustomFontController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final LocalizationController localizationController =
      Get.put(LocalizationController());

  return (Column(children: [
    Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
            child: TextFormField(
                maxLength: 20,
                cursorColor: colorController.customColor().textInputCursor,
                autovalidateMode: AutovalidateMode.values.last,
                style: fontController.customFont().medium12,
                validator: validateTitle,
                onChanged: onChangeTitle,
                decoration: InputDecoration(
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: colorController.customColor().errorText,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: colorController.customColor().errorText,
                    ),
                  ),
                  errorStyle: TextStyle(
                      fontSize: fontController.customFont().regular12.fontSize,
                      fontFamily:
                          fontController.customFont().regular12.fontFamily,
                      fontWeight:
                          fontController.customFont().regular12.fontWeight,
                      color: colorController.customColor().errorText),
                  counterStyle: fontController.customFont().medium12,
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  isDense: true,
                  hintText: localizationController
                      .localiztionInquiryScreen()
                      .inquiryTitlePlaceholder,
                  hintStyle: TextStyle(
                      color: colorController.customColor().placeholder,
                      fontFamily:
                          fontController.customFont().medium12.fontFamily,
                      fontSize: fontController.customFont().medium12.fontSize),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: colorController.customColor().textInputCursor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: colorController.customColor().textInputFocusCursor,
                    ),
                  ),
                  focusColor: colorController.customColor().textInputCursor,
                )))),
    Padding(
        padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: Form(
            child: TextFormField(
                maxLength: 200,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: validateContent,
                onChanged: onChangeContent,
                cursorColor: colorController.customColor().textInputCursor,
                autovalidateMode: AutovalidateMode.values.last,
                style: fontController.customFont().medium12,
                decoration: InputDecoration(
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: colorController.customColor().errorText,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: colorController.customColor().errorText,
                    ),
                  ),
                  errorStyle: TextStyle(
                      fontSize: fontController.customFont().regular12.fontSize,
                      fontFamily:
                          fontController.customFont().regular12.fontFamily,
                      fontWeight:
                          fontController.customFont().regular12.fontWeight,
                      color: colorController.customColor().errorText),
                  counterStyle: fontController.customFont().medium12,
                  contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  isDense: true,
                  hintText: localizationController
                      .localiztionInquiryScreen()
                      .inquiryContentPlaceholder,
                  hintStyle: TextStyle(
                      color: colorController.customColor().placeholder,
                      fontFamily:
                          fontController.customFont().medium12.fontFamily,
                      fontSize: fontController.customFont().medium12.fontSize),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: colorController.customColor().textInputCursor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: colorController.customColor().textInputFocusCursor,
                    ),
                  ),
                  focusColor: colorController.customColor().textInputCursor,
                )))),
    Padding(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: CustomButton(
          onPress: onPressInquiry,
          child: Container(
              width: double.infinity,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: colorController.customColor().buttonBorder),
                  color: isReady
                      ? colorController.customColor().buttonActiveColor
                      : colorController.customColor().buttonInActiveColor,
                  borderRadius: BorderRadius.circular(4)),
              child: Text(
                localizationController.localiztionComponentButton().inquiry,
                style: TextStyle(
                  fontFamily: fontController.customFont().bold12.fontFamily,
                  fontWeight: fontController.customFont().bold12.fontWeight,
                  color: isReady
                      ? colorController.customColor().buttonActiveText
                      : colorController.customColor().buttonInActiveText,
                ),
              )),
        ))
  ]));
}
