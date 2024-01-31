import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ExerciseAddScreen extends StatefulWidget {
  ExerciseAddScreen({super.key});

  @override
  State<ExerciseAddScreen> createState() => _ExerciseAddScreenState();
}

class _ExerciseAddScreenState extends State<ExerciseAddScreen> {
  Stores stores = Stores();
  NetworkProviders networkProviders = NetworkProviders();
  TextEditingController _textController = TextEditingController(text: '');
  var isOpen = false;
  List<int> selectedPart = [];
  int? tempSelectedPart;
  String exerciseName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onChangedTitle(String value) {
    setState(() {
      exerciseName = value;
    });
  }

  void onPressAdd(BuildContext context) async {
    try {
      stores.appStateController.setIsLoading(true, context);
      await networkProviders.exerciseProvider.postCustomExercise(
          {'name': exerciseName, 'musclesId': selectedPart});
      final result =
          await networkProviders.exerciseProvider.getExerciseList(limit: 1);
      if (result.list.isNotEmpty) {
        if (stores.exerciseStateController.exerciseList != null) {
          stores.exerciseStateController.exerciseList
              ?.insertAll(0, result.list);
        } else {
          stores.exerciseStateController.exerciseList =
              RxList<Exercise>.from(result.list);
        }
      }
      if (!context.mounted) return;
      stores.appStateController.setIsLoading(false, context);
      setState(() {
        selectedPart = [];
        tempSelectedPart = null;
        _textController.text = '';
        exerciseName = '';
      });
      stores.appStateController.showToast(
          stores.localizationController.localiztionExerciseAddScreen().success);
      Navigator.pop(context);
    } catch (error) {
      print('exercise_add_screen onPressAdd error:$error');
      stores.appStateController.setIsLoading(false, context);
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
          .localiztionExerciseAddScreen()
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

  bool checkCanSave() {
    if (exerciseName.isEmpty) {
      return true;
    }
    if (selectedPart.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return safeAreaView(context,
        stores.localizationController.localiztionExerciseAddScreen().title,
        rightText:
            stores.localizationController.localiztionExerciseScreen().add,
        isRightInActive: checkCanSave(),
        onPressRight: () => onPressAdd(context),
        children: [
          Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: SizedBox(
                  height: 32,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      stores.localizationController
                          .localiztionExerciseAddScreen()
                          .inputTitle,
                      style: stores.fontController.customFont().bold12,
                    ),
                  )),
            ),
            SizedBox(
                child: customTextInput(
              context,
              controller: _textController,
              maxLength: 20,
              counterText: '',
              placeholder: stores.localizationController
                  .localiztionExerciseAddScreen()
                  .inputTitlePlaceholder,
              title: stores.localizationController
                  .localiztionExerciseAddScreen()
                  .inputTitle,
              onChangedTitle,
            )),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: CustomButton(
                  onPress: onPressAddPart,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: SizedBox(
                          height: 52,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                stores.localizationController
                                    .localiztionExerciseAddScreen()
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
                                        .localiztionExerciseAddScreen()
                                        .partPlaceholder,
                                style:
                                    stores.fontController.customFont().bold12,
                              )
                            ],
                          )))),
            ),
            SizedBox(
                child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: selectedPart.length,
              itemExtent: 48,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              itemBuilder: (BuildContext context, int index) {
                final String? name = stores.exerciseStateController.muscles
                    ?.firstWhere((element) => element.id == selectedPart[index])
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
          ]),
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
