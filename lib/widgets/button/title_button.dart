import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

Widget titleButton(BuildContext context,
    {bool isOpen = false, String title = '', Function()? onPress}) {
  final Stores stores = Get.put(Stores());
  return (CustomButton(
      onPress: onPress,
      child: SizedBox(
          width: stores.appStateController.logicalWidth.value,
          height: 52,
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: stores.fontController.customFont().bold12),
                    isOpen
                        ? Icon(
                            Icons.arrow_drop_up,
                            color: stores.colorController
                                .customColor()
                                .bottomTabBarActiveItem,
                            size: 24,
                          )
                        : Icon(
                            Icons.arrow_drop_down,
                            color: stores.colorController
                                .customColor()
                                .bottomTabBarActiveItem,
                            size: 24,
                          ),
                  ])))));
}
