import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ExerciseAddItem extends StatefulWidget {
  ExerciseAddItem({super.key});

  @override
  State<ExerciseAddItem> createState() => _ExerciseAddItem();
}

class _ExerciseAddItem extends State<ExerciseAddItem>
    with TickerProviderStateMixin {
  final Stores stores = Stores();
  NetworkProviders networkProviders = NetworkProviders();
  late Animation<double> _animation;
  late AnimationController _controller;
  late TextEditingController _textController;
  var isOpen = false;
  bool isOpenPart = false;
  String selectedPart = '';
  String exerciseName = '';

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '');
    selectedPart = stores.localizationController
        .localiztionExerciseScreen()
        .partPlaceholder;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    selectedPart = '';
    _controller.dispose();
    super.dispose();
  }

  void selectPart(value) {
    setState(() {
      selectedPart = value;
    });
  }

  void onPressTitleButton() {
    if (isOpen) {
      isOpen = false;
      isOpenPart = false;
      _controller.reverse();
      return;
    }
    isOpen = true;
    _controller.forward();
  }

  void onPressPart() {
    if (isOpenPart) {
      setState(() {
        isOpenPart = false;
      });
    } else {
      setState(() {
        isOpenPart = true;
      });
    }
  }

  onChangedTitle(String value) {
    setState(() {
      exerciseName = value;
    });
  }

  void onPressAdd() async {
    try {
      stores.appStateController.setIsLoading(true, context);
      final muscle = stores.exerciseStateController.muscles
          ?.firstWhere((element) => element.name == selectedPart);
      await networkProviders.exerciseProvider
          .postCustomExercise({'name': exerciseName, 'muclesId': muscle?.id});
      if (!context.mounted) return;
      stores.appStateController.setIsLoading(false, context);
      setState(() {
        _textController.text = '';
        exerciseName = '';
        selectedPart = stores.localizationController
            .localiztionExerciseScreen()
            .partPlaceholder;
        stores.appStateController.showToast(
            stores.localizationController.localiztionExerciseScreen().success);
      });
    } catch (error) {
      stores.appStateController.showToast(stores.localizationController
          .localiztionComponentError()
          .networkError);
    }
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
      ),
      AnimatedOpacity(
          opacity: isOpen ? 1 : 0,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 250),
          child: SizedBox(
            width: stores.appStateController.logicalWidth.value,
            height: _animation.value * (isOpenPart ? 274 : 274 - 96),
            child: Column(
              children: [
                SizedBox(
                    height: _animation.value * 52,
                    child: customTextInput(
                        controller: _textController,
                        maxLength: 20,
                        counterText: '',
                        context,
                        placeholder: stores.localizationController
                            .localiztionExerciseScreen()
                            .inputTitlePlaceholder,
                        title: stores.localizationController
                            .localiztionExerciseScreen()
                            .inputTitle,
                        onChangedTitle,
                        isAnimated: true)),
                SizedBox(
                  height: _animation.value * 10,
                ),
                CustomButton(
                    onPress: onPressPart,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: SizedBox(
                            height: _animation.value * 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  stores.localizationController
                                      .localiztionExerciseScreen()
                                      .partName,
                                  style:
                                      stores.fontController.customFont().bold12,
                                ),
                                Text(
                                  selectedPart,
                                  style:
                                      stores.fontController.customFont().bold12,
                                )
                              ],
                            )))),
                isOpenPart
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Container(
                            height: 96,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: stores.colorController
                                        .customColor()
                                        .defaultBackground1
                                        .withOpacity(0.3),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.0,
                                    offset: const Offset(0, 7),
                                  )
                                ]),
                            child: CupertinoPicker.builder(
                                itemExtent: 32,
                                childCount: stores
                                    .exerciseStateController.muscles?.length,
                                onSelectedItemChanged: (index) {
                                  selectPart(stores.exerciseStateController
                                      .muscles?[index].name);
                                },
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                      height: 32,
                                      child: Align(
                                          child: Text(
                                        '${stores.exerciseStateController.muscles?[index].name}',
                                        style: stores.fontController
                                            .customFont()
                                            .bold18,
                                      )));
                                })))
                    : SizedBox(),
                Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 16,
                    )),
                Expanded(
                    flex: 8,
                    child: CompleteButton(
                        onPress: onPressAdd,
                        disabled: exerciseName.isEmpty ||
                            selectedPart ==
                                stores.localizationController
                                    .localiztionExerciseScreen()
                                    .partPlaceholder,
                        title: stores.localizationController
                            .localiztionExerciseScreen()
                            .add))
              ],
            ),
          )),
    ]);
  }
}
