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
  final Stores stores = Get.put(Stores());

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
      return stores.localizationController
          .localiztionInquiryScreen()
          .errorTitle;
    }
    if (check) {
      return stores.localizationController
          .localiztionInquiryScreen()
          .errorTitle;
    }

    return null;
  }

  String? validateContent(value) {
    final check = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (inquiryContentError) {
      return stores.localizationController
          .localiztionInquiryScreen()
          .errorContent;
    }
    if (check) {
      return stores.localizationController
          .localiztionInquiryScreen()
          .errorContent;
    }
    return null;
  }

  String inquiryTitle = '';
  String inquiryContent = '';

  @override
  Widget build(BuildContext context) {
    return (safeAreaView(
        context, stores.localizationController.localiztionInquiryScreen().title,
        children: [
          SizedBox(
            height: 24,
          ),
          titleButton(context,
              title: stores.localizationController
                  .localiztionInquiryScreen()
                  .inquiry,
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
              title: stores.localizationController
                  .localiztionInquiryScreen()
                  .inquiryList,
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
  final Stores stores = Get.put(Stores());

  return (Column(children: [
    Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
            child: TextFormField(
                maxLength: 20,
                cursorColor:
                    stores.colorController.customColor().textInputCursor,
                autovalidateMode: AutovalidateMode.values.last,
                style: stores.fontController.customFont().medium12,
                validator: validateTitle,
                onChanged: onChangeTitle,
                decoration: InputDecoration(
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: stores.colorController.customColor().errorText,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: stores.colorController.customColor().errorText,
                    ),
                  ),
                  errorStyle: TextStyle(
                      fontSize:
                          stores.fontController.customFont().regular12.fontSize,
                      fontFamily: stores.fontController
                          .customFont()
                          .regular12
                          .fontFamily,
                      fontWeight: stores.fontController
                          .customFont()
                          .regular12
                          .fontWeight,
                      color: stores.colorController.customColor().errorText),
                  counterStyle: stores.fontController.customFont().medium12,
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  isDense: true,
                  hintText: stores.localizationController
                      .localiztionInquiryScreen()
                      .inquiryTitlePlaceholder,
                  hintStyle: TextStyle(
                      color: stores.colorController.customColor().placeholder,
                      fontFamily: stores.fontController
                          .customFont()
                          .medium12
                          .fontFamily,
                      fontSize:
                          stores.fontController.customFont().medium12.fontSize),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color:
                          stores.colorController.customColor().textInputCursor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: stores.colorController
                          .customColor()
                          .textInputFocusCursor,
                    ),
                  ),
                  focusColor:
                      stores.colorController.customColor().textInputCursor,
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
                cursorColor:
                    stores.colorController.customColor().textInputCursor,
                autovalidateMode: AutovalidateMode.values.last,
                style: stores.fontController.customFont().medium12,
                decoration: InputDecoration(
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: stores.colorController.customColor().errorText,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: stores.colorController.customColor().errorText,
                    ),
                  ),
                  errorStyle: TextStyle(
                      fontSize:
                          stores.fontController.customFont().regular12.fontSize,
                      fontFamily: stores.fontController
                          .customFont()
                          .regular12
                          .fontFamily,
                      fontWeight: stores.fontController
                          .customFont()
                          .regular12
                          .fontWeight,
                      color: stores.colorController.customColor().errorText),
                  counterStyle: stores.fontController.customFont().medium12,
                  contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  isDense: true,
                  hintText: stores.localizationController
                      .localiztionInquiryScreen()
                      .inquiryContentPlaceholder,
                  hintStyle: TextStyle(
                      color: stores.colorController.customColor().placeholder,
                      fontFamily: stores.fontController
                          .customFont()
                          .medium12
                          .fontFamily,
                      fontSize:
                          stores.fontController.customFont().medium12.fontSize),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color:
                          stores.colorController.customColor().textInputCursor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: stores.colorController
                          .customColor()
                          .textInputFocusCursor,
                    ),
                  ),
                  focusColor:
                      stores.colorController.customColor().textInputCursor,
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
                      color: stores.colorController.customColor().buttonBorder),
                  color: isReady
                      ? stores.colorController.customColor().buttonActiveColor
                      : stores.colorController
                          .customColor()
                          .buttonInActiveColor,
                  borderRadius: BorderRadius.circular(4)),
              child: Text(
                stores.localizationController
                    .localiztionComponentButton()
                    .inquiry,
                style: TextStyle(
                  fontFamily:
                      stores.fontController.customFont().bold12.fontFamily,
                  fontWeight:
                      stores.fontController.customFont().bold12.fontWeight,
                  color: isReady
                      ? stores.colorController.customColor().buttonActiveText
                      : stores.colorController.customColor().buttonInActiveText,
                ),
              )),
        ))
  ]));
}
