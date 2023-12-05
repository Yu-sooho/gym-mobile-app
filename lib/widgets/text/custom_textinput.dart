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
    bool isAnimated = false,
    GlobalKey? key}) {
  final Stores stores = Get.put(Stores());

  Widget customForm() {
    return Form(
        key: key,
        child: TextFormField(
          scrollPadding: EdgeInsets.only(bottom: 34),
          onChanged: onChanged,
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.values.last,
          validator: validator,
          cursorColor: stores.colorController.customColor().textInputCursor,
          style: stores.fontController.customFont().medium12,
          decoration: InputDecoration(
            counterStyle: stores.fontController.customFont().medium12,
            contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 10),
            isDense: true,
            hintText: placeholder,
            hintStyle: TextStyle(
                color: stores.colorController.customColor().placeholder,
                fontFamily:
                    stores.fontController.customFont().medium12.fontFamily,
                fontSize: stores.fontController.customFont().medium12.fontSize),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: stores.colorController.customColor().textInputCursor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color:
                    stores.colorController.customColor().textInputFocusCursor,
              ),
            ),
            focusColor: stores.colorController.customColor().textInputCursor,
          ),
        ));
  }

  Widget customTitle() {
    return (title != null
        ? Text(
            title,
            style: stores.fontController.customFont().bold12,
          )
        : SizedBox());
  }

  return (Obx(() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SizedBox(
          width: width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            isAnimated ? Expanded(flex: 1, child: customTitle()) : SizedBox(),
            isAnimated ? Expanded(flex: 1, child: customForm()) : customForm(),
          ]),
        ),
      )));
}
