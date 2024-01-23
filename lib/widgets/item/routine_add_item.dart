import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/routine_models.dart';
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
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  String routineName = '';

  @override
  void initState() {
    super.initState();
    final Duration duration = widget.duration ?? Duration(milliseconds: 250);
    final Curve curve = widget.curve ?? Curves.linear;
    _titleController = TextEditingController(text: '');
    _dateController = TextEditingController(text: '');
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

  onChangedTitle(String value) {
    setState(() {
      routineName = value;
    });
  }

  void onPressChangeCycle() {
    setState(() {});
  }

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
      ),
      AnimatedOpacity(
          opacity: isOpen ? 1 : 0,
          curve: Curves.fastOutSlowIn,
          duration: widget.duration ?? const Duration(milliseconds: 250),
          child: SizedBox(
              width: stores.appStateController.logicalWidth.value,
              height: _animation.value * (166),
              child: Column(
                children: [
                  SizedBox(
                      height: _animation.value * 52,
                      child: customTextInput(
                          controller: _titleController,
                          maxLength: 20,
                          counterText: '',
                          context,
                          placeholder: stores.localizationController
                              .localiztionRoutineScreen()
                              .inputTitlePlaceholder,
                          title: stores.localizationController
                              .localiztionRoutineScreen()
                              .inputTitle,
                          onChangedTitle,
                          isAnimated: true)),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: SizedBox(
                          height: _animation.value * 48,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      stores.localizationController
                                          .localiztionRoutineScreen()
                                          .routineCycle,
                                      style: stores.fontController
                                          .customFont()
                                          .bold12,
                                    )),
                              ),
                              Container(
                                  width: 100,
                                  padding: EdgeInsets.only(top: 16),
                                  child: customTextInput(
                                      textAlign: TextAlign.center,
                                      controller: _dateController,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 12),
                                      maxLength: 2,
                                      counterText: '',
                                      context,
                                      placeholder: stores.localizationController
                                          .localiztionRoutineScreen()
                                          .date,
                                      title: null,
                                      onChangedTitle,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.transparent),
                                      ),
                                      keyboardType: TextInputType.number,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.transparent),
                                      ),
                                      isAnimated: true))
                            ],
                          ))),
                ],
              )))
    ]);
  }
}
