import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

@override
Widget tabAreaView(BuildContext context,
    {List<Widget>? children,
    double paddingTop = 0,
    double paddingBottom = 0,
    double paddingLeft = 0,
    double paddingRight = 0,
    double marginTop = 0,
    double marginBottom = 0,
    double marginLeft = 0,
    double marginRight = 0}) {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final AppStateController appStateController = Get.put(AppStateController());
  return (Stack(children: <Widget>[
    ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorController.customColor().defaultBackground1,
              Colors.transparent,
              Colors.transparent,
              colorController.customColor().defaultBackground2,
            ],
            stops: [
              0.0,
              0.01,
              0.95,
              1.0
            ], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              marginLeft, marginTop, marginRight, marginBottom),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Column(children: [
              SizedBox(
                height: appStateController.logicalHeight.value -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom -
                    MediaQuery.of(context).viewInsets.bottom -
                    90 -
                    32 -
                    marginTop -
                    marginBottom,
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                      paddingLeft,
                      paddingTop,
                      paddingRight,
                      24 +
                          MediaQuery.of(context).padding.bottom +
                          paddingBottom),
                  child: Column(children: children ?? []),
                ),
              )
            ]),
          ),
        )),
  ]));
}
