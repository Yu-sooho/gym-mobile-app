import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/stores/routine_state_controller.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineAddItem extends StatefulWidget {
  final Duration? duration;
  final Curve? curve;
  RoutineAddItem({super.key, this.duration, this.curve});

  @override
  State<RoutineAddItem> createState() => _RoutineAddItem();
}

class _RoutineAddItem extends State<RoutineAddItem>
    with TickerProviderStateMixin {
  final Stores stores = Get.put(Stores());

  final RoutineStateController routineStateController =
      Get.put(RoutineStateController());
  var title = '';
  var isOpen = false;
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    final Duration duration = widget.duration ?? Duration(milliseconds: 250);
    final Curve curve = widget.curve ?? Curves.linear;
    _controller = AnimationController(vsync: this, duration: duration);
    _animation = CurvedAnimation(parent: _controller, curve: curve);
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onPressTitleButton() {
    if (isOpen) {
      isOpen = false;
      _controller.reverse();
      return;
    }
    isOpen = true;
    _controller.forward();
  }

  onChangedTitle(String value) {}

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomButton(
        onPress: onPressTitleButton,
        child: SizedBox(
          height: 48,
          width: stores.appStateController.logicalWidth.value,
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stores.localizationController
                          .localiztionRoutineScreen()
                          .addRoutine,
                      style: stores.fontController.customFont().bold12,
                    ),
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                      child: Icon(
                        Icons.arrow_drop_up,
                        color: stores.colorController
                            .customColor()
                            .bottomTabBarActiveItem,
                        size: 24,
                      ),
                    )
                  ])),
        ),
      )
    ]);
  }
}
