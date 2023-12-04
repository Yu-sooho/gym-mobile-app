import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ExerciseAddItem extends StatefulWidget {
  ExerciseAddItem({super.key});

  @override
  State<ExerciseAddItem> createState() => _ExerciseAddItem();
}

class _ExerciseAddItem extends State<ExerciseAddItem>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  var isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final Stores stores = Get.put(Stores());
  var title = '';
  onChangedTitle(String value) {}

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomButton(
        child: SizedBox(
          height: 48,
          width: stores.appStateController.logicalWidth.value,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stores.localizationController
                          .localiztionExerciseScreen()
                          .addExercise,
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
        onPress: () {
          if (isOpen) {
            isOpen = false;
            _controller.reverse();
            return;
          }
          isOpen = true;
          _controller.forward();
        },
      ),
      AnimatedOpacity(
          opacity: isOpen ? 1 : 0,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 1000),
          child: Container(
            height: _animation.value * 200,
            width: stores.appStateController.logicalWidth.value,
            decoration: BoxDecoration(color: Colors.red),
          )),
    ]);
  }
}
