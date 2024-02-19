import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

Widget customTextInput(BuildContext context, Function(String) onChanged,
    {String? title,
    int? maxLength,
    int? count,
    TextAlign? textAlign,
    String? placeholder,
    String? Function(String? value)? validator,
    String? counterText,
    double? width,
    EdgeInsets? contentPadding,
    bool isAnimated = false,
    TextEditingController? controller,
    UnderlineInputBorder? enabledBorder,
    UnderlineInputBorder? focusedBorder,
    TextInputType? keyboardType,
    GlobalKey? key}) {
  final Stores stores = Get.put(Stores());

  Widget customForm() {
    return Form(
        key: key,
        child: TextFormField(
          controller: controller,
          scrollPadding: EdgeInsets.only(bottom: 34),
          onChanged: onChanged,
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.values.last,
          keyboardType: keyboardType,
          validator: validator,
          cursorColor: stores.colorController.customColor().textInputCursor,
          style: stores.fontController.customFont().medium12,
          textAlign: textAlign ?? TextAlign.left,
          decoration: InputDecoration(
            counterStyle: stores.fontController.customFont().medium12,
            contentPadding: contentPadding ?? EdgeInsets.fromLTRB(0, 12, 0, 10),
            counterText: counterText,
            isDense: true,
            hintText: placeholder,
            hintStyle: stores.fontController.customFont().medium12.copyWith(
                  color: stores.colorController.customColor().placeholder,
                ),
            enabledBorder: enabledBorder ??
                UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: stores.colorController.customColor().textInputCursor,
                  ),
                ),
            focusedBorder: focusedBorder ??
                UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: stores.colorController
                        .customColor()
                        .textInputFocusCursor,
                  ),
                ),
            focusColor: stores.colorController.customColor().textInputCursor,
          ),
        ));
  }

  return (Obx(() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SizedBox(
          width: width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            isAnimated && title != null
                ? Expanded(
                    flex: 1,
                    child: Text(
                      title,
                      style: stores.fontController.customFont().bold12,
                    ))
                : SizedBox(),
            isAnimated ? Expanded(flex: 1, child: customForm()) : customForm(),
          ]),
        ),
      )));
}
