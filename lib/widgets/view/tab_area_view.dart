import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class TabAreaView extends StatefulWidget {
  late final List<Widget>? children;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final RefreshCallback? onRefresh;
  final ScrollController? scrollController;
  final Widget? header;
  final double? headerSize;
  final double? maxHeaderSize;
  final double? minHeaderSize;
  final Duration? openDuration;
  final Duration? closeDuration;
  final Duration? openDelay;
  final Duration? closeDelay;

  TabAreaView(
      {super.key,
      this.children,
      this.paddingTop = 0,
      this.paddingBottom = 0,
      this.paddingLeft = 0,
      this.paddingRight = 0,
      this.marginTop = 0,
      this.marginBottom = 0,
      this.marginLeft = 0,
      this.marginRight = 0,
      this.onRefresh,
      this.scrollController,
      this.header,
      this.headerSize,
      this.maxHeaderSize,
      this.minHeaderSize,
      this.openDuration,
      this.closeDuration,
      this.openDelay,
      this.closeDelay});

  @override
  State<TabAreaView> createState() => _TabAreaViewState();
}

class _TabAreaViewState extends State<TabAreaView>
    with TickerProviderStateMixin {
  static const _offsetToArmed = 100.0;

  late AnimationController controller;
  late Animation<double> animation;
  late AnimationController controller2;
  late Animation<double> animation2;

  double lastHeaderSize = 0;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation.addListener(() {
      setState(() {});
    });
    controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animation2 = CurvedAnimation(parent: controller2, curve: Curves.linear);
    animation2.addListener(() {
      setState(() {});
    });
    controller.value = 0;
    controller2.value = 1;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? children = widget.children;
    final double paddingTop = widget.paddingTop;
    final double paddingBottom = widget.paddingBottom;
    final double paddingLeft = widget.paddingLeft;
    final double paddingRight = widget.paddingRight;
    final double marginTop = widget.marginTop;
    final double marginBottom = widget.marginBottom;
    final double marginLeft = widget.marginLeft;
    final double marginRight = widget.marginRight;
    final ScrollController? scrollController = widget.scrollController;
    final Widget? header = widget.header;
    final double headerSize = widget.headerSize ?? 0;
    final Duration openDuration =
        widget.openDuration ?? Duration(milliseconds: 250);
    final Duration closeDuration =
        widget.closeDuration ?? Duration(milliseconds: 250);
    final Duration openDelay = widget.openDelay ?? Duration(seconds: 0);
    final Duration closeDelay = widget.closeDelay ?? Duration(seconds: 0);

    final Stores stores = Get.put(Stores());

    if (lastHeaderSize != headerSize) {
      if (headerSize <= widget.maxHeaderSize!) {
        if (lastHeaderSize > headerSize) {
          controller2.duration = closeDuration;
          controller.reverseDuration = closeDuration;
          if (closeDelay == Duration(seconds: 0)) {
            controller.reverse();
            controller2.forward();
          } else {
            Future.delayed(closeDelay, () {
              controller.reverse();
              controller2.forward();
            });
          }
        } else if (lastHeaderSize != 0) {
          controller.duration = openDuration;
          controller2.reverseDuration = openDuration;
          if (openDelay == Duration(seconds: 0)) {
            controller.forward();
            controller2.reverse();
          } else {
            Future.delayed(openDelay, () {
              controller.forward();
              controller2.reverse();
            });
          }
        }
        lastHeaderSize = headerSize;
      }
    }

    Widget screenContent() {
      return (CustomRefreshIndicator(
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
          onRefresh: widget.onRefresh ??
              () async {
                return;
              },
          builder: (BuildContext context, Widget child,
              IndicatorController controller) {
            return Stack(clipBehavior: Clip.hardEdge, children: <Widget>[
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
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
                paddingLeft,
                paddingTop,
                paddingRight,
                120 +
                    24 +
                    MediaQuery.of(context).padding.bottom +
                    paddingBottom),
            child: Column(children: children ?? []),
          )));
    }

    Widget screenContainer() {
      return (Padding(
        padding: EdgeInsets.fromLTRB(
            marginLeft, marginTop, marginRight, marginBottom),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(children: [
            header ?? SizedBox(),
            SizedBox(
                height: stores.appStateController.logicalHeight.value -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom -
                    MediaQuery.of(context).viewInsets.bottom -
                    92 -
                    32 -
                    59 -
                    marginTop -
                    marginBottom -
                    (animation.value * (widget.maxHeaderSize ?? 0)) -
                    (animation2.value * (widget.minHeaderSize ?? 0)) -
                    (headerSize > (widget.maxHeaderSize ?? 0)
                        ? headerSize - (widget.maxHeaderSize ?? 0)
                        : 0),
                child: widget.onRefresh != null
                    ? header != null
                        ? ShaderMask(
                            shaderCallback: (Rect rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  stores.colorController
                                      .customColor()
                                      .defaultBackground1,
                                  Colors.transparent,
                                  Colors.transparent,
                                  stores.colorController
                                      .customColor()
                                      .defaultBackground2,
                                ],
                                stops: [0.0, 0.01, 0.95, 1.0],
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: screenContent())
                        : screenContent()
                    : SingleChildScrollView(
                        controller: scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                            paddingLeft,
                            paddingTop,
                            paddingRight,
                            24 +
                                MediaQuery.of(context).padding.bottom +
                                paddingBottom),
                        child: Column(children: children ?? [])))
          ]),
        ),
      ));
    }

    return (Stack(children: <Widget>[
      header == null
          ? ShaderMask(
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
              child: screenContainer())
          : screenContainer(),
    ]));
  }
}
