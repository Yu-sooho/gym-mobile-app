import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RightArrowButton extends StatelessWidget {
  final String title;
  final Function() onPress;
  final TextStyle? textStyle;
  final bool isHaveRight;

  RightArrowButton(
      {super.key,
      this.textStyle,
      this.isHaveRight = true,
      required this.title,
      required this.onPress});

  final AppStateController appStateController = Get.put(AppStateController());
  final CustomFontController customFontController =
      Get.put(CustomFontController());
  final CustomColorController customColorController =
      Get.put(CustomColorController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => (CustomButton(
        onPress: onPress,
        splashColor: customColorController.customColor().transparent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 8, 0),
          child: SizedBox(
            height: 52,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title,
                      style: textStyle ??
                          customFontController.customFont().bold14),
                  isHaveRight
                      ? Icon(
                          Icons.arrow_right_outlined,
                          color: customColorController
                              .customColor()
                              .defaultTextColor,
                          size: 32,
                        )
                      : SizedBox(),
                ]),
          ),
        ))));
  }
}