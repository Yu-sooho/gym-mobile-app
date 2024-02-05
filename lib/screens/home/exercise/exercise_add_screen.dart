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
  TextEditingController _nowWeightController = TextEditingController(text: '');
  TextEditingController _targetWeightController =
      TextEditingController(text: '');
  var isOpen = false;

  List<int> selectedMuscles = [];
  List<Muscles> selectedMusclesDetail = [];

  String exerciseName = '';
  String weight = '';
  String targetWeight = '';

  double openButtonSize = 0.0;
  double muscleListSize = 0.0;
  double openButtonOpacity = 0.0;
  double muscleListOpacity = 0.0;
  bool isShow = false;
  Duration duration = Duration(milliseconds: 250);

  final buttonMaxSize = 48.0;
  final listMaxSize = 108.0;

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

  onChangeNowWegiht(String value) {
    setState(() {
      weight = value;
    });
  }

  onChangeTargetWegiht(String value) {
    setState(() {
      targetWeight = value;
    });
  }

  void onPressAdd(BuildContext context) async {
    try {
      stores.appStateController.setIsLoading(true, context);
      await networkProviders.exerciseProvider.postCustomExercise({
        'name': exerciseName,
        'musclesId': selectedMuscles,
        'weight': weight,
        'targetWeight': targetWeight
      });
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
        selectedMuscles = [];
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

  void onPressDelete(int selectedItem) {
    setState(() {
      selectedMuscles.remove(selectedItem);
    });
  }

  bool checkCanSave() {
    if (exerciseName.isEmpty) {
      return true;
    }
    if (selectedMuscles.isEmpty) {
      return true;
    }
    return false;
  }

  Widget addButton(BuildContext context, Function() onPress, String text) {
    return (Padding(
        padding: EdgeInsets.only(top: 12),
        child: CustomButton(
          onPress: onPress,
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
                        text,
                        style: stores.fontController.customFont().bold12,
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: stores.colorController
                            .customColor()
                            .bottomTabBarActiveItem,
                        size: 24,
                      ),
                    ])),
          ),
        )));
  }

  onPressExercise(Muscles muscles) {
    if (selectedMuscles.isEmpty) {
      setState(() {
        selectedMuscles.add(muscles.id);
        selectedMusclesDetail.add(muscles);
      });
      setState(() {
        openButtonSize = buttonMaxSize;
        openButtonOpacity = 1.0;
      });
      return;
    }
    int? find = selectedMuscles.firstWhereOrNull(
      (element) => element == muscles.id,
    );
    if (find != null) {
      if (selectedMuscles.length == 1) {
        setState(() {
          openButtonSize = 0.0;
          openButtonOpacity = 0.0;
        });
      }
      setState(() {
        selectedMuscles.remove(find);
        selectedMusclesDetail.remove(muscles);
      });
    } else {
      setState(() {
        selectedMuscles.add(muscles.id);
        selectedMusclesDetail.add(muscles);
        openButtonSize = buttonMaxSize;
        openButtonOpacity = 1.0;
      });
    }
  }

  showList() {
    setState(() {
      isShow = !isShow;
      muscleListSize = isShow ? 0 : listMaxSize;
      muscleListOpacity = isShow ? 0.0 : 1.0;
    });
  }

  onPressSelectedList(Muscles muscles) {
    onPressExercise(muscles);
    if (selectedMuscles.isEmpty) {
      showList();
    }
  }

  Widget selectedList(List<int> list) {
    return (Column(
      children: [
        AnimatedOpacity(
            duration: duration,
            opacity: openButtonOpacity,
            child: AnimatedContainer(
              duration: duration,
              height: openButtonSize,
              child: CustomButton(
                  onPress: showList,
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
                                    .localiztionRoutineAddScreen()
                                    .exerciseListCheck,
                                style:
                                    stores.fontController.customFont().bold12,
                              ),
                              Text(
                                '(${selectedMuscles.length})',
                                style:
                                    stores.fontController.customFont().bold12,
                              )
                            ],
                          )))),
            )),
        AnimatedOpacity(
          duration: duration,
          opacity: muscleListOpacity,
          child: AnimatedContainer(
            duration: duration,
            height: muscleListSize,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: selectedMuscles.length,
              itemExtent: 32,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              itemBuilder: (BuildContext context, int index) {
                final String? name = stores.exerciseStateController.muscles
                    ?.firstWhere(
                        (element) => element.id == selectedMuscles[index])
                    .name;
                return (partListItem(
                    context,
                    selectedMuscles[index],
                    onPressDelete,
                    Icon(
                      CupertinoIcons.clear,
                      color: stores.colorController
                          .customColor()
                          .bottomTabBarActiveItem,
                      size: 16,
                    ),
                    name ?? '123',
                    stores.fontController.customFont().medium12));
              },
            ),
          ),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return safeAreaView(context,
        stores.localizationController.localiztionExerciseAddScreen().title,
        rightText:
            stores.localizationController.localiztionExerciseScreen().add,
        isRightInActive: checkCanSave(),
        onPressRight: () => onPressAdd(context),
        stickyWidget: Column(
          children: [
            Column(children: [
              addButton(
                  context,
                  () => onPressAdd(context),
                  stores.localizationController
                      .localiztionExerciseScreen()
                      .addPart),
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
              TwoTextInput(
                  stores: stores,
                  textController1: _nowWeightController,
                  textController2: _targetWeightController,
                  title: stores.localizationController
                      .localiztionExerciseAddScreen()
                      .weight,
                  placeholder1: stores.localizationController
                      .localiztionExerciseAddScreen()
                      .nowWeight,
                  placeholder2: stores.localizationController
                      .localiztionExerciseAddScreen()
                      .targetWeight,
                  onChanged1: onChangeNowWegiht,
                  onChanged2: onChangeTargetWegiht),
              SizedBox(
                height: 12,
              ),
              selectedList(selectedMuscles),
              SizedBox(
                height: 12,
              ),
            ]),
          ],
        ),
        children: [
          Obx(() {
            return ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: stores.exerciseStateController.muscles?.length ?? 0,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                return MuscleListItem(
                    onPress: onPressExercise,
                    item: stores.exerciseStateController.muscles![index]);
              },
            );
          })
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
