import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

@override
Widget safeAreaView(BuildContext context, String title,
    {List<Widget>? children}) {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final AppStateController appStateController = Get.put(AppStateController());

  return Stack(children: <Widget>[
    Obx(() => Scaffold(
          backgroundColor: colorController.customColor().defaultBackground,
        )),
    Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(children: [
          CustomHeader(
              title: title, onPressLeft: () => {Navigator.of(context).pop()}),
          SizedBox(
            height: appStateController.logicalHeight.value -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  0, 24, 0, 24 + MediaQuery.of(context).padding.bottom),
              child: Column(children: children ?? []),
            ),
          )
        ]))
  ]);
}
