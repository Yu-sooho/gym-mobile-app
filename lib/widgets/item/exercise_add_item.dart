import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ExerciseAddItem extends StatefulWidget {
  final Function(double)? getHeight;
  final Function()? afterFunc;
  ExerciseAddItem({super.key, this.getHeight, this.afterFunc});

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
  String selectedPart = '';
  String tempSelectedPart = '';
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

  void onPressTitleButton() {
    if (isOpen) {
      isOpen = false;
      widget.getHeight!(48);
      _controller.reverse();
      return;
    }
    widget.getHeight!(274 - 48);
    isOpen = true;
    _controller.forward();
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
          .postCustomExercise({'name': exerciseName, 'muscleId': muscle?.id});
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
      if (widget.afterFunc != null) {
        widget.afterFunc!();
      }
    } catch (error) {
      stores.appStateController.showToast(stores.localizationController
          .localiztionComponentError()
          .networkError);
    }
  }

  void onChangedItem(int index) {
    setState(() {
      tempSelectedPart = stores.exerciseStateController.muscles![index].name;
    });
  }

  void onPressOk() {
    setState(() {
      selectedPart = tempSelectedPart;
    });
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
            height: _animation.value * 178,
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
                    onPress: () => stores.appStateController.showDialog(
                        CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32,
                            scrollController: FixedExtentScrollController(
                                initialItem: (stores
                                        .exerciseStateController.muscles
                                        ?.indexWhere((element) =>
                                            element.name == selectedPart) ??
                                    0)),
                            onSelectedItemChanged: onChangedItem,
                            children: List<Widget>.generate(
                                stores.exerciseStateController.muscles
                                        ?.length ??
                                    0, (int index) {
                              return Center(
                                  child: Center(
                                      child: Text(
                                          '${stores.exerciseStateController.muscles?[index].name}')));
                            })),
                        context,
                        isHaveButton: true,
                        onPressOk: onPressOk),
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
