import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

@immutable
class CustomHeader extends StatelessWidget {
  final Stores stores = Get.put(Stores());

  final String title;
  final Function()? onPressLeft;
  final Function()? onPressRight;
  final bool isRightInActive;
  final String? rightText;
  final bool noBack;

  CustomHeader(
      {super.key,
      required this.title,
      this.noBack = false,
      this.rightText = '',
      this.onPressLeft,
      this.onPressRight,
      this.isRightInActive = false});

  late final screenSize = stores.appStateController.logicalWidth.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  noBack
                      ? SizedBox()
                      : InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: onPressLeft,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              width: screenSize / 6,
                              height: 32,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: Icon(Icons.arrow_back_ios,
                                    color: stores.colorController
                                        .customColor()
                                        .defaultTextColor,
                                    size: 20),
                              ))),
                  InkWell(
                      child: Container(
                          alignment: Alignment.center,
                          width: screenSize / 6 * 4,
                          height: 32,
                          child: Text(title,
                              textAlign: TextAlign.center,
                              style:
                                  stores.fontController.customFont().bold14))),
                  InkWell(
                      onTap: isRightInActive ? () {} : onPressRight,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                          alignment: Alignment.centerRight,
                          width: screenSize / 6,
                          height: 32,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                              child: Text(rightText!,
                                  textAlign: TextAlign.right,
                                  style: stores.fontController
                                      .customFont()
                                      .bold12
                                      .copyWith(
                                          color: isRightInActive
                                              ? stores.colorController
                                                  .customColor()
                                                  .buttonInActiveText
                                              : stores.colorController
                                                  .customColor()
                                                  .buttonActiveText))))),
                ],
              )),
        ));
  }
}
