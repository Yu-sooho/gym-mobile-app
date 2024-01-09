import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ExerciseAddItem extends StatefulWidget {
  final Function(double)? getHeight;
  final Function()? afterFunc;
  final Duration? duration;
  final Curve? curve;
  ExerciseAddItem(
      {super.key, this.getHeight, this.afterFunc, this.duration, this.curve});

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
  List<int> selectedPart = [];
  int? tempSelectedPart;
  String exerciseName = '';

  @override
  void initState() {
    super.initState();
    final Duration duration = widget.duration ?? Duration(milliseconds: 250);
    final Curve curve = widget.curve ?? Curves.linear;
    _textController = TextEditingController(text: '');
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
      selectedPart = [];
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
      await networkProviders.exerciseProvider.postCustomExercise(
          {'name': exerciseName, 'musclesId': selectedPart});
      if (!context.mounted) return;
      stores.appStateController.setIsLoading(false, context);
      setState(() {
        selectedPart = [];
        tempSelectedPart = null;
        _textController.text = '';
        exerciseName = '';
        stores.appStateController.showToast(
            stores.localizationController.localiztionExerciseScreen().success);
      });
      widget.getHeight!(274 - 48 + selectedPart.length * 32);
      if (widget.afterFunc != null) {
        widget.afterFunc!();
      }
    } catch (error) {
      widget.getHeight!(274 - 48 + selectedPart.length * 32);
      stores.appStateController.showToast(stores.localizationController
          .localiztionComponentError()
          .networkError);
    }
  }

  void onChangedItem(int index) {
    setState(() {
      tempSelectedPart = stores.exerciseStateController.muscles![index].id;
    });
  }

  void onPressOk() {
    final findSelected =
        selectedPart.where((element) => element == tempSelectedPart);
    if (findSelected.isNotEmpty) {
      setState(() {
        tempSelectedPart = null;
      });
      stores.appStateController.showToast(stores.localizationController
          .localiztionExerciseScreen()
          .alreadyPart);
      return;
    }

    if (selectedPart.length >= 10) {
      stores.appStateController.showToast(
          stores.localizationController.localiztionExerciseScreen().maxPart);
      return;
    }

    if (tempSelectedPart != null) {
      selectedPart.add(tempSelectedPart!);
      widget.getHeight!(274 - 48 + selectedPart.length * 32);
      setState(() {
        tempSelectedPart = null;
      });
    }
  }

  void onPressCancel() {
    if (tempSelectedPart != null) {
      setState(() {
        tempSelectedPart = null;
      });
    }
  }

  void onPressDelete(int selectedItem) {
    setState(() {
      selectedPart.remove(selectedItem);
    });
    widget.getHeight!(274 - 48 + selectedPart.length * 32);
  }

  void onPressAddPart() {
    setState(() {
      tempSelectedPart = 0;
    });
    stores.appStateController.showDialog(
        CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 32,
            onSelectedItemChanged: onChangedItem,
            children: List<Widget>.generate(
                stores.exerciseStateController.muscles?.length ?? 0,
                (int index) {
              return Center(
                  child: Center(
                      child: Text(
                          '${stores.exerciseStateController.muscles?[index].name}')));
            })),
        context,
        isHaveButton: true,
        barrierDismissible: false,
        onPressOk: onPressOk,
        onPressCancel: onPressCancel);
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
          duration: widget.duration ?? const Duration(milliseconds: 250),
          child: SizedBox(
            width: stores.appStateController.logicalWidth.value,
            height: _animation.value * (166 + selectedPart.length * 32),
            child: Column(children: [
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
                  onPress: onPressAddPart,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                                (tempSelectedPart != null &&
                                        stores.exerciseStateController
                                                .muscles !=
                                            null)
                                    ? stores.exerciseStateController
                                        .muscles![tempSelectedPart!].name
                                    : stores.localizationController
                                        .localiztionExerciseScreen()
                                        .partPlaceholder,
                                style:
                                    stores.fontController.customFont().bold12,
                              )
                            ],
                          )))),
              SizedBox(
                  height: _animation.value * selectedPart.length * 32,
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: selectedPart.length,
                    itemExtent: 32,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    itemBuilder: (BuildContext context, int index) {
                      final String? name = stores
                          .exerciseStateController.muscles
                          ?.firstWhere(
                              (element) => element.id == selectedPart[index])
                          .name;
                      return (partListItem(
                          context,
                          selectedPart[index],
                          onPressDelete,
                          Icon(
                            CupertinoIcons.clear,
                            color: stores.colorController
                                .customColor()
                                .bottomTabBarActiveItem,
                            size: 16,
                          ),
                          name ?? '',
                          stores.fontController.customFont().medium12));
                    },
                  )),
              SizedBox(
                  height: _animation.value * 56,
                  child: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: CompleteButton(
                          onPress: onPressAdd,
                          disabled:
                              exerciseName.isEmpty || selectedPart.isEmpty,
                          title: stores.localizationController
                              .localiztionExerciseScreen()
                              .add)))
            ]),
          )),
    ]);
  }
}

Widget partListItem(BuildContext context, int selectedItem,
    Function(int) onPress, Widget icon, String title, TextStyle style) {
  return (SizedBox(
    height: 32,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: style,
      ),
      CustomButton(
          onPress: () => {onPress(selectedItem)},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: SizedBox(
            height: 32,
            width: 64,
            child: Align(alignment: Alignment.centerRight, child: icon),
          ))
    ]),
  ));
}
