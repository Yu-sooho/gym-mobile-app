import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

@immutable
class CustomHeader extends StatelessWidget {
  final AppStateController appStateController = Get.put(AppStateController());
  final CustomFontController fontController = Get.put(CustomFontController());

  final String title;
  final Function()? onPressLeft;
  final Function()? onPressRight;

  final String? rightText;

  CustomHeader({
    super.key,
    required this.title,
    this.rightText = '',
    this.onPressLeft,
    this.onPressRight,
  });

  late final screenSize = appStateController.logicalWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: onPressLeft,
              child: Container(
                  alignment: Alignment.centerLeft,
                  width: screenSize / 6,
                  height: 32,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 24),
                  ))),
          InkWell(
              child: Container(
                  alignment: Alignment.center,
                  width: screenSize / 6 * 4,
                  height: 32,
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: fontController.customFont().bold14))),
          InkWell(
              onTap: onPressLeft,
              child: Container(
                  alignment: Alignment.centerLeft,
                  width: screenSize / 6,
                  height: 32,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Text(rightText!,
                        textAlign: TextAlign.center,
                        style: fontController.customFont().bold14),
                  ))),
        ],
      )),
    );
  }
}
