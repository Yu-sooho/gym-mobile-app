import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

Widget customTextInput(BuildContext context, Function(String) onChanged,
    {String? title,
    int? maxLength,
    int? count,
    String? placeholder,
    String? Function(String? value)? validator,
    double? width,
    GlobalKey? key}) {
  final CustomFontController fontController = Get.put(CustomFontController());
  final CustomColorController colorController =
      Get.put(CustomColorController());

  return (Obx(() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SizedBox(
          width: width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            title != null
                ? Text(
                    title,
                    style: fontController.customFont().bold12,
                  )
                : SizedBox(),
            Form(
                key: key,
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom: 34),
                  onChanged: onChanged,
                  maxLength: maxLength,
                  autovalidateMode: AutovalidateMode.values.last,
                  validator: validator,
                  cursorColor: colorController.customColor().textInputCursor,
                  style: fontController.customFont().medium12,
                  decoration: InputDecoration(
                    counterStyle: fontController.customFont().medium12,
                    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 10),
                    isDense: true,
                    hintText: placeholder,
                    hintStyle: TextStyle(
                        color: colorController.customColor().placeholder,
                        fontFamily:
                            fontController.customFont().medium12.fontFamily,
                        fontSize:
                            fontController.customFont().medium12.fontSize),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: colorController.customColor().textInputCursor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color:
                            colorController.customColor().textInputFocusCursor,
                      ),
                    ),
                    focusColor: colorController.customColor().textInputCursor,
                  ),
                )),
          ]),
        ),
      )));
}
