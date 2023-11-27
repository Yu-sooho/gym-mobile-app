import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

@override
Widget safeAreaView(
  BuildContext context,
  String title, {
  List<Widget>? children,
  final Function()? onPressRight,
  final bool? isRightInActive,
  final String? rightText,
}) {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final AppStateController appStateController = Get.put(AppStateController());
  return Stack(children: <Widget>[
    Obx(() => Scaffold(
            body: Container(
                decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0, -3),
              end: Alignment(0, 1),
              colors: <Color>[
                colorController.customColor().defaultBackground2,
                colorController.customColor().defaultBackground1,
              ], // Gradient from https://learnui.design/tools/gradient-generator.html
              tileMode: TileMode.clamp),
        )))),
    Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(children: [
          CustomHeader(
            title: title,
            onPressRight: onPressRight,
            rightText: rightText ?? '',
            isRightInActive: isRightInActive ?? false,
            onPressLeft: () => {
              Navigator.of(context).pop(),
            },
          ),
          SizedBox(
            height: appStateController.logicalHeight.value -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                MediaQuery.of(context).viewInsets.bottom -
                32,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 0, 24 + MediaQuery.of(context).padding.bottom),
              child: Column(children: children ?? []),
            ),
          )
        ]))
  ]);
}
