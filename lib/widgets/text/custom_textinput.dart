import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class CustomTextInput extends StatefulWidget {
  final Function(String) onChanged;
  final String? title;
  final int? maxLength;
  final int? count;
  final TextAlign? textAlign;
  final String? placeholder;
  final String? Function(String? value)? validator;
  final String? counterText;
  final double? width;
  final EdgeInsets? contentPadding;
  final bool isAnimated;
  final TextEditingController? controller;
  final UnderlineInputBorder? enabledBorder;
  final UnderlineInputBorder? focusedBorder;
  final TextInputType? keyboardType;

  CustomTextInput({
    required this.onChanged,
    this.title,
    this.maxLength,
    this.count,
    this.textAlign,
    this.placeholder,
    this.validator,
    this.counterText,
    this.width,
    this.contentPadding,
    this.isAnimated = false,
    this.controller,
    this.enabledBorder,
    this.focusedBorder,
    this.keyboardType,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  final Stores stores = Get.find<Stores>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SizedBox(
            width: widget.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isAnimated && widget.title != null)
                  Expanded(
                    flex: 1,
                    child: Text(
                      widget.title!,
                      style: stores.fontController.customFont().bold12,
                    ),
                  ),
                if (widget.isAnimated)
                  Expanded(
                    flex: 1,
                    child: customForm(),
                  )
                else
                  customForm(),
              ],
            ),
          ),
        ));
  }

  Widget customForm() {
    return Form(
      key: widget.key,
      child: TextFormField(
        controller: widget.controller ?? TextEditingController(),
        scrollPadding: EdgeInsets.only(bottom: 34),
        onChanged: (value) {
          widget.onChanged(value);
        },
        maxLength: widget.maxLength,
        autovalidateMode: AutovalidateMode.values.last,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        cursorColor: stores.colorController.customColor().textInputCursor,
        style: stores.fontController.customFont().medium12,
        textAlign: widget.textAlign ?? TextAlign.left,
        decoration: InputDecoration(
          counterStyle: stores.fontController.customFont().medium12,
          contentPadding:
              widget.contentPadding ?? EdgeInsets.fromLTRB(0, 12, 0, 10),
          counterText: widget.counterText,
          isDense: true,
          hintText: widget.placeholder,
          hintStyle: stores.fontController.customFont().medium12.copyWith(
                color: stores.colorController.customColor().placeholder,
              ),
          enabledBorder: widget.enabledBorder ??
              UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: stores.colorController.customColor().textInputCursor,
                ),
              ),
          focusedBorder: widget.focusedBorder ??
              UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color:
                      stores.colorController.customColor().textInputFocusCursor,
                ),
              ),
          focusColor: stores.colorController.customColor().textInputCursor,
        ),
      ),
    );
  }
}
