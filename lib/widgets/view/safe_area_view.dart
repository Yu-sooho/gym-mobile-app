import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

const _offsetToArmed = 100.0;

class SafeAreaView extends StatefulWidget {
  final String title;
  final List<Widget>? children;
  final Widget? stickyWidget;
  final Function()? onPressRight;
  final bool? isRightInActive;
  final String? rightText;
  final bool noBackButton;
  final bool noHeader;
  final RefreshCallback? onRefresh;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;

  SafeAreaView({
    super.key,
    required this.title,
    this.children,
    this.stickyWidget,
    this.onPressRight,
    this.isRightInActive,
    this.rightText,
    this.noBackButton = false,
    this.noHeader = false,
    this.onRefresh,
    this.physics,
    this.scrollController,
  });

  @override
  _SafeAreaViewState createState() => _SafeAreaViewState();
}

class _SafeAreaViewState extends State<SafeAreaView> {
  late Stores stores;

  @override
  void initState() {
    super.initState();
    stores = Get.put(Stores());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: KeyboardDismisser(
            child: Column(
              children: [
                (widget.noHeader)
                    ? SizedBox()
                    : CustomHeader(
                        title: widget.title,
                        onPressRight: widget.onPressRight,
                        rightText: widget.rightText ?? '',
                        isRightInActive: widget.isRightInActive ?? false,
                        onPressLeft: () => Navigator.of(context).pop(),
                      ),
                widget.stickyWidget ?? SizedBox(),
                Expanded(
                  child: ShaderMask(
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
                      onRefresh: widget.onRefresh ?? () async {},
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
                                  ),
                                ));
                              },
                            ),
                            Container(child: child),
                          ],
                        );
                      },
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        physics: widget.physics,
                        padding: EdgeInsets.fromLTRB(
                          0,
                          0,
                          0,
                          24 + MediaQuery.of(context).padding.bottom,
                        ),
                        child: Column(children: widget.children ?? []),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
