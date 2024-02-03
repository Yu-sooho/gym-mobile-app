import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

const _offsetToArmed = 100.0;

@override
Widget safeAreaView(BuildContext context, String title,
    {List<Widget>? children,
    final Widget? stickyWidget,
    final Function()? onPressRight,
    final bool? isRightInActive,
    final String? rightText,
    final bool noBackButton = false,
    final bool noHeader = false,
    final RefreshCallback? onRefresh,
    final ScrollPhysics? physics,
    final ScrollController? scrollController}) {
  final Stores stores = Get.put(Stores());
  return Stack(children: <Widget>[
    Obx(() => Scaffold(
            body: Container(
                decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0, -3),
              end: Alignment(0, 1),
              colors: <Color>[
                stores.colorController.customColor().defaultBackground2,
                stores.colorController.customColor().defaultBackground1,
              ],
              tileMode: TileMode.clamp),
        )))),
    Scaffold(
        backgroundColor: Colors.transparent,
        body: KeyboardDismisser(
            child: Column(children: [
          (noHeader)
              ? SizedBox()
              : CustomHeader(
                  title: title,
                  onPressRight: onPressRight,
                  rightText: rightText ?? '',
                  isRightInActive: isRightInActive ?? false,
                  onPressLeft: () => {
                    Navigator.of(context).pop(),
                  },
                ),
          stickyWidget ?? SizedBox(),
          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    stores.colorController.customColor().defaultBackground1,
                    Colors.transparent,
                    Colors.transparent,
                    stores.colorController.customColor().defaultBackground2,
                  ],
                  stops: [0.0, 0.01, 0.95, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: CustomRefreshIndicator(
                  offsetToArmed: _offsetToArmed,
                  autoRebuild: false,
                  onStateChanged: (change) {
                    if (change.didChange(
                      from: IndicatorState.armed,
                      to: IndicatorState.settling,
                    )) {
                      print(change);
                    }
                    if (change.didChange(
                      from: IndicatorState.loading,
                    )) {
                      print(change);
                    }
                    if (change.didChange(
                      to: IndicatorState.idle,
                    )) {
                      print(change);
                    }
                  },
                  onRefresh: onRefresh ??
                      () async {
                        return;
                      },
                  builder: (BuildContext context, Widget child,
                      IndicatorController controller) {
                    return Stack(
                        clipBehavior: Clip.hardEdge,
                        children: <Widget>[
                          AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) {
                                return (SizedBox(
                                    height: controller.value * _offsetToArmed,
                                    child: SpinKitFadingCircle(
                                      size: 25,
                                      color: stores.colorController
                                          .customColor()
                                          .loadingSpinnerColor,
                                    )));
                              }),
                          Container(child: child),
                        ]);
                  },
                  child: SingleChildScrollView(
                      controller: scrollController,
                      physics: physics,
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, 24 + MediaQuery.of(context).padding.bottom),
                      child: Column(children: children ?? []))),
            ),
          )
        ])))
  ]);
}
