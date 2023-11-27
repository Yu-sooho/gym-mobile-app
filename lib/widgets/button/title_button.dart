import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

Widget titleButton(BuildContext context,
    {bool isOpen = false, String title = '', Function()? onPress}) {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final CustomFontController fontController = Get.put(CustomFontController());
  final AppStateController appStateController = Get.put(AppStateController());

  return (CustomButton(
      onPress: onPress,
      child: SizedBox(
          width: appStateController.logicalWidth.value,
          height: 52,
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
