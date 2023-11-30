import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

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
  TabAreaView({
    super.key,
    this.children,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
  });

  @override
  State<TabAreaView> createState() => _TabAreaViewState();
}

class _TabAreaViewState extends State<TabAreaView> {
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

    final Stores stores = Get.put(Stores());
    return (Stack(children: <Widget>[
      ShaderMask(
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
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                marginLeft, marginTop, marginRight, marginBottom),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Column(children: [
                SizedBox(
                  height: stores.appStateController.logicalHeight.value -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom -
                      MediaQuery.of(context).viewInsets.bottom -
                      92 -
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
}
