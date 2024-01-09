import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

Widget subTitleText(String title, {double? paddingLeft, double? paddingRight}) {
  final Stores stores = Get.put(Stores());

  final double left = paddingLeft ?? 20;
  final double right = paddingRight ?? 20;

  return (Obx(() => Padding(
        padding: EdgeInsets.fromLTRB(left, 0, right, 0),
        child: SizedBox(
            child: Text(
          title,
          style: stores.fontController.customFont().bold12,
        )),
      )));
}
