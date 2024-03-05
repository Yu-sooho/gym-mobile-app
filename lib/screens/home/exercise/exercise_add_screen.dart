import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ExerciseAddScreen extends StatefulWidget {
  final Exercise? exercise;
  ExerciseAddScreen({super.key, this.exercise});

  @override
  State<ExerciseAddScreen> createState() => _ExerciseAddScreenState();
}

class _ExerciseAddScreenState extends State<ExerciseAddScreen> {
  Stores stores = Stores();
  NetworkProviders networkProviders = NetworkProviders();

  final _controller = ScrollController();

  TextEditingController _muscleTextController = TextEditingController(text: '');
  TextEditingController _titleController = TextEditingController(text: '');
  TextEditingController _nowWeightController = TextEditingController(text: '');
  TextEditingController _targetWeightController =
      TextEditingController(text: '');
  var isOpen = false;

  List<String> selectedMuscles = [];
  List<Muscles> selectedMusclesDetail = [];

  String exerciseName = '';
  String weight = '';
  String targetWeight = '';
  String muscleName = '';

  bool muscleLoading = false;
  bool isRefresh = false;

  double muscleAddArrowRotateValue = 0.25;
  double muscleAddSize = 0.0;
  double muscleAddOpacity = 0.0;
  double openButtonSize = 0.0;
  double muscleListSize = 0.0;
  double openButtonOpacity = 0.0;
  double muscleListOpacity = 0.0;
  bool isShow = false;
  Duration duration = Duration(milliseconds: 250);
  String searchKeyword = '';

  final muscleTextInputMaxSize = 32.0;
  final buttonMaxSize = 48.0;
  final listMaxSize = 108.0;

  final limit = 20;

  @override
  void initState() {
    super.initState();
    init();

    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;
      double delta = 200.0;
      if (maxScroll - currentScroll <= delta) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else if (_controller.position.pixels >=
            _controller.position.maxScrollExtent - 20) {
          getMuscleList();
        }
      }
    });
  }

  Future init() async {
    setState(() {
      stores.exerciseStateController.startAfterMuscle = null;
      stores.exerciseStateController.muscleList = RxList<Muscles>.empty();
      stores.exerciseStateController.endMuscleList = false;
      muscleLoading = false;
    });
    if (widget.exercise != null) {
      isEditSetting();
    }
    await getMuscleList();
  }

  void isEditSetting() {
    _titleController.text = widget.exercise!.name;
    _nowWeightController.text = widget.exercise!.weight!;
    _targetWeightController.text = widget.exercise!.targetWeight!;

    exerciseName = widget.exercise!.name;
    targetWeight = widget.exercise!.targetWeight!;
    weight = widget.exercise!.weight!;

    print(widget.exercise?.muscles);

    if (widget.exercise?.musclesNames != null) {
      widget.exercise?.musclesNames.forEach((element) {
        selectedMuscles.add(element);
      });
    }

    if (widget.exercise?.muscles != null) {
      widget.exercise?.muscles?.forEach((element) {
        selectedMusclesDetail.add(element);
      });
      setState(() {
        openButtonSize = buttonMaxSize;
        openButtonOpacity = 1.0;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchKeyword = '';
  }

  void setStateifMounted(Function() afterFunc) {
    if (!mounted) return;
    afterFunc();
  }

  Future onRefresh() async {
    setState(() {
      isRefresh = true;
      stores.exerciseStateController.startAfterMuscle = null;
      stores.exerciseStateController.muscleList = RxList<Muscles>.empty();
      stores.exerciseStateController.endMuscleList = false;
      muscleLoading = false;
    });
    await getMuscleList();
    setState(() {
      isRefresh = false;
    });
  }

  Future<bool> getMuscleList() async {
    if (stores.exerciseStateController.endMuscleList || muscleLoading) {
      return false;
    }
    setState(() {
      muscleLoading = true;
    });
    final result = await networkProviders.exerciseProvider.getUserMuscleList(
        sort: stores.exerciseStateController.exerciseSortMethod[
            stores.exerciseStateController.muscleSort.value],
        startAfter: stores.exerciseStateController.startAfterMuscle,
        limit: limit,
        searchKeyword: searchKeyword);
    if (result.list.isNotEmpty) {
      if (result.length < limit) {
        stores.exerciseStateController.endMuscleList = true;
      }
      stores.exerciseStateController.startAfterMuscle = result.lastDoc;
      stores.exerciseStateController.muscleList.addAll(result.list);
    } else {
      stores.exerciseStateController.endMuscleList = true;
    }
    setState(() {
      muscleLoading = false;
    });
    return true;
  }

  onChangedMuscle(String value) {
    setState(() {
      muscleName = value;
    });
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

  bool checkWeight() {
    num? now = num.tryParse(weight);
    num? target = num.tryParse(targetWeight);

    if (now != null && target != null) {
      if (now > target) return false;
      return true;
    } else {
      return false;
    }
  }

  void onPressAdd(BuildContext context) async {
    try {
      if (!checkWeight()) {
        stores.appStateController.showToast(stores.localizationController
            .localiztionExerciseAddScreen()
            .errorWeight);
        return;
      }
      stores.appStateController.setIsLoading(true, context);
      await networkProviders.exerciseProvider.postCustomExercise({
        'name': exerciseName,
        'musclesNames': selectedMuscles,
        'weight': weight,
        'targetWeight': targetWeight
      });
      final result =
          await networkProviders.exerciseProvider.getExerciseList(limit: 1);

      if (result.list.isNotEmpty) {
        if (stores.exerciseStateController.exerciseSort.value == 0) {
          stores.exerciseStateController.exerciseList.insertAll(0, result.list);
        } else if (stores.exerciseStateController.exerciseSort.value == 1) {
          stores.exerciseStateController.exerciseList.addAll(result.list);
        } else {
          int index = 0;
          while (index < stores.exerciseStateController.exerciseList.length &&
              stores.exerciseStateController.exerciseList[index].name
                      .compareTo(result.list[0].name) <
                  0) {
            index++;
          }
          stores.exerciseStateController.exerciseList
              .insert(index, result.list[0]);
        }
      }
      if (!context.mounted) return;
      stores.appStateController.setIsLoading(false, context);
      setState(() {
        selectedMuscles = [];
        _titleController.text = '';
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

  void onPressEdit(BuildContext context) async {
    final docName = widget.exercise?.docName;
    if (docName == null) return;
    try {
      stores.appStateController.setIsLoading(true, context);
      await networkProviders.exerciseProvider.putCustomExercise({
        'name': exerciseName,
        'musclesNames': selectedMuscles,
        'weight': weight,
        'targetWeight': targetWeight
      }, docName);
      final result =
          await networkProviders.exerciseProvider.getExerciseList(limit: 1);
      print(result);
      if (result.list.isNotEmpty) {
        final temp = stores.exerciseStateController.exerciseList
            .indexWhere((element) => element.id == widget.exercise?.id);
        if (temp >= 0) {
          stores.exerciseStateController.exerciseList[temp] = result.list[0];
        }
      }
      if (!context.mounted) return;
      stores.appStateController.setIsLoading(false, context);
      stores.appStateController.showToast(stores.localizationController
          .localiztionExerciseAddScreen()
          .editSuccess);
      Navigator.pop(context);
    } catch (error) {
      print('exercise_add_screen onPressEdit error:$error');
      stores.appStateController.setIsLoading(false, context);
      stores.appStateController.showToast(stores.localizationController
          .localiztionComponentError()
          .networkError);
    }
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
                      AnimatedRotation(
                        turns: muscleAddArrowRotateValue,
                        duration: duration,
                        child: Icon(
                          Icons.arrow_right,
                          color: stores.colorController
                              .customColor()
                              .bottomTabBarActiveItem,
                          size: 24,
                        ),
                      )
                    ])),
          ),
        )));
  }

  onPressExercise(Muscles muscles) {
    if (selectedMuscles.isEmpty) {
      setState(() {
        selectedMuscles.add(muscles.name);
        selectedMusclesDetail.add(muscles);
      });
      setState(() {
        openButtonSize = buttonMaxSize;
        openButtonOpacity = 1.0;
      });
      return;
    }
    String? find = selectedMuscles.firstWhereOrNull(
      (element) => element == muscles.name,
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
        selectedMuscles.add(muscles.name);
        selectedMusclesDetail.add(muscles);
        openButtonSize = buttonMaxSize;
        openButtonOpacity = 1.0;
      });
    }
  }

  showList() {
    if (isShow) {
      setState(() {
        isShow = false;
        muscleListSize = 0;
        muscleListOpacity = 0;
      });
    } else {
      setState(() {
        isShow = true;
        muscleListSize = listMaxSize;
        muscleListOpacity = 1;
      });
    }
  }

  onPressSelectedList(Muscles muscles) {
    onPressExercise(muscles);
    if (selectedMuscles.isEmpty) {
      setState(() {
        isShow = false;
        muscleListSize = 0;
        muscleListOpacity = 0;
      });
    }
  }

  Widget selectedList(List<String> list) {
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
                                    .localiztionExerciseAddScreen()
                                    .addMuscle,
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
                final Muscles item = selectedMusclesDetail.firstWhere(
                    (element) => element.name == selectedMuscles[index]);
                final String name = item.name;
                return SelectListItem(
                  selectedItem: selectedMuscles[index],
                  onPress: () => onPressSelectedList(item),
                  icon: Icon(
                    CupertinoIcons.clear,
                    color: stores.colorController
                        .customColor()
                        .bottomTabBarActiveItem,
                    size: 16,
                  ),
                  title: name,
                  style: stores.fontController.customFont().medium12,
                );
              },
            ),
          ),
        )
      ],
    ));
  }

  void onPressOpenAddMuscle(context) {
    FocusScope.of(context).unfocus();
    if (muscleAddSize == muscleTextInputMaxSize) {
      setState(() {
        muscleAddSize = 0.0;
        muscleAddOpacity = 0.0;
        muscleAddArrowRotateValue = 0.25;
      });
    } else {
      setState(() {
        muscleAddSize = muscleTextInputMaxSize;
        muscleAddOpacity = 1;
        muscleAddArrowRotateValue = 0.75;
      });
    }
  }

  void onPressAddMuscle(BuildContext context) async {
    // stores.appStateController.setIsLoading(true, context);
    // await networkProviders.exerciseProvider.postCustomExercise({
    //   'name': exerciseName,
    //   'musclesNames': selectedMuscles,
    //   'weight': weight,
    //   'targetWeight': targetWeight
    // });
    // final result =
    //     await networkProviders.exerciseProvider.getExerciseList(limit: 1);

    // if (result.list.isNotEmpty) {
    //   if (stores.exerciseStateController.exerciseSort.value == 0) {
    //     stores.exerciseStateController.exerciseList.insertAll(0, result.list);
    //   } else if (stores.exerciseStateController.exerciseSort.value == 1) {
    //     stores.exerciseStateController.exerciseList.addAll(result.list);
    //   } else {
    //     int index = 0;
    //     while (index < stores.exerciseStateController.exerciseList.length &&
    //         stores.exerciseStateController.exerciseList[index].name
    //                 .compareTo(result.list[0].name) <
    //             0) {
    //       index++;
    //     }
    //     stores.exerciseStateController.exerciseList
    //         .insert(index, result.list[0]);
    //   }
    // }

    try {
      stores.appStateController.setIsLoading(true, context);
      final post = await networkProviders.exerciseProvider.postCustomMuscle({
        'name': muscleName,
      });

      if (!post) {
        stores.appStateController.showToast(stores.localizationController
            .localiztionExerciseAddScreen()
            .alreadyPart);
        if (!context.mounted) return;
        stores.appStateController.setIsLoading(false, context);
        return;
      }

      final result =
          await networkProviders.exerciseProvider.getUserMuscleList(limit: 1);

      if (result.list.isNotEmpty) {
        if (stores.exerciseStateController.muscleSort.value == 0) {
          stores.exerciseStateController.muscleList.insertAll(0, result.list);
        } else if (stores.exerciseStateController.muscleSort.value == 1) {
          stores.exerciseStateController.muscleList.addAll(result.list);
        } else {
          int index = 0;
          while (index < stores.exerciseStateController.muscleList.length &&
              stores.exerciseStateController.muscleList[index].name
                      .compareTo(result.list[0].name) <
                  0) {
            index++;
          }
          stores.exerciseStateController.muscleList
              .insert(index, result.list[0]);
        }
      }

      stores.exerciseStateController.startAfterMuscle = result.lastDoc;

      if (!context.mounted) return;
      stores.appStateController.setIsLoading(false, context);
      stores.appStateController.showToast(stores.localizationController
          .localiztionExerciseAddScreen()
          .muscleSuccess);

      setState(() {
        muscleAddOpacity = 0;
        muscleAddSize = 0;
        muscleName = '';
        _muscleTextController.text = '';
      });
    } catch (error) {
      print('exercise_add_screen onPressAddMuscle error:$error');
      stores.appStateController.setIsLoading(false, context);
      stores.appStateController.showToast(stores.localizationController
          .localiztionComponentError()
          .networkError);
    }
  }

  onPressDeleteMuscle(BuildContext context, Muscles muscles) async {
    showDialog(
        context: context,
        builder: (context) => CustomModalScreen(
            description: stores.localizationController
                .localiztionModalScreenText()
                .deleteMuscle,
            okText: stores.localizationController
                .localiztionModalScreenText()
                .delete,
            okTextStyle: stores.fontController.customFont().bold12.copyWith(
                color: stores.colorController.customColor().errorText),
            onPressCancel: () {
              Navigator.pop(context);
            },
            onPressOk: () async {
              setState(() {
                muscleLoading = true;
              });
              final result = await networkProviders.exerciseProvider
                  .deleteCustomMuscle(muscles.id);
              if (result) {
                stores.exerciseStateController.muscleList.remove(muscles);
                stores.appStateController.showToast(stores
                    .localizationController
                    .localiztionExerciseScreen()
                    .successDelete);
              } else {
                stores.appStateController.showToast(stores
                    .localizationController
                    .localiztionExerciseScreen()
                    .errorDelete);
              }
              setState(() {
                muscleLoading = false;
              });
              Get.back();
            }));
  }

  int tempSelectedSort = 0;

  void onChangedSortMethod(int selectedItem) async {
    tempSelectedSort = selectedItem;
  }

  void onPressSortMethodOk() async {
    setState(() {
      stores.exerciseStateController.muscleSort = tempSelectedSort.obs;
      stores.exerciseStateController.startAfterMuscle = null;
      stores.exerciseStateController.muscleList = RxList<Muscles>.empty();
      stores.exerciseStateController.endMuscleList = false;
      muscleLoading = false;
    });
    getMuscleList();
  }

  onChangedSearchKeyword(String value) {
    stores.exerciseStateController.muscleSort = tempSelectedSort.obs;
    stores.exerciseStateController.startAfterMuscle = null;
    stores.exerciseStateController.muscleList = RxList<Muscles>.empty();
    stores.exerciseStateController.endMuscleList = false;
    setState(() {
      searchKeyword = value;
    });

    getMuscleList();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: SafeAreaView(
          physics: AlwaysScrollableScrollPhysics(),
          title: stores.localizationController
              .localiztionExerciseAddScreen()
              .title,
          rightText:
              stores.localizationController.localiztionExerciseScreen().add,
          isRightInActive: checkCanSave(),
          onPressRight: () => widget.exercise != null
              ? onPressEdit(context)
              : onPressAdd(context),
          stickyWidget: Column(
            children: [
              Column(children: [
                addButton(
                    context,
                    () => onPressOpenAddMuscle(context),
                    stores.localizationController
                        .localiztionExerciseScreen()
                        .addPart),
                AnimatedOpacity(
                  opacity: muscleAddOpacity,
                  duration: duration,
                  child: AnimatedContainer(
                    duration: duration,
                    height: muscleAddSize,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: _muscleTextController,
                            onChanged: onChangedMuscle,
                            cursorColor: stores.colorController
                                .customColor()
                                .textInputCursor,
                            style: stores.fontController.customFont().medium12,
                            decoration: InputDecoration(
                              counterStyle:
                                  stores.fontController.customFont().medium12,
                              contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 10),
                              isDense: true,
                              hintText: stores.localizationController
                                  .localiztionExerciseAddScreen()
                                  .partName,
                              hintStyle: stores.fontController
                                  .customFont()
                                  .medium12
                                  .copyWith(
                                    color: stores.colorController
                                        .customColor()
                                        .placeholder,
                                  ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: stores.colorController
                                      .customColor()
                                      .textInputCursor,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: stores.colorController
                                      .customColor()
                                      .textInputFocusCursor,
                                ),
                              ),
                              focusColor: stores.colorController
                                  .customColor()
                                  .textInputCursor,
                            ),
                          )),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => onPressAddMuscle(context),
                            child: SizedBox(
                                width: 48,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    stores.localizationController
                                        .localiztionExerciseAddScreen()
                                        .add,
                                    style: stores.fontController
                                        .customFont()
                                        .bold12,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
                    child: CustomTextInput(
                  controller: _titleController,
                  maxLength: 20,
                  counterText: '',
                  placeholder: stores.localizationController
                      .localiztionExerciseAddScreen()
                      .inputTitlePlaceholder,
                  title: stores.localizationController
                      .localiztionExerciseAddScreen()
                      .inputTitle,
                  onChanged: onChangedTitle,
                )),
                TwoTextInput(
                    stores: stores,
                    textController1: _nowWeightController,
                    textController2: _targetWeightController,
                    title: stores.localizationController
                        .localiztionExerciseAddScreen()
                        .weight,
                    placeholder1:
                        '${stores.localizationController.localiztionExerciseAddScreen().nowWeight}  (kg)',
                    placeholder2:
                        '${stores.localizationController.localiztionExerciseAddScreen().targetWeight}  (kg)',
                    onChanged1: onChangeNowWegiht,
                    onChanged2: onChangeTargetWegiht),
                SizedBox(
                  height: 12,
                ),
                selectedList(selectedMuscles),
                SizedBox(
                  height: 4,
                ),
                CustomSortBar(
                    sortValue: stores.exerciseStateController.muscleSort.value,
                    initialItem:
                        stores.exerciseStateController.muscleSort.value,
                    onChangedSortMethod: onChangedSortMethod,
                    onPressSortMethodOk: onPressSortMethodOk,
                    isSearch: true,
                    itemExtent: 32,
                    sortBarHeight: 40,
                    onChanged: onChangedSearchKeyword),
                SizedBox(
                  height: 6,
                ),
              ]),
            ],
          ),
          scrollController: _controller,
          onRefresh: onRefresh,
          children: [
            Obx(() {
              if (stores.exerciseStateController.muscleList.isEmpty) {
                return emptyContainer(muscleLoading, isRefresh,
                    text: searchKeyword.isNotEmpty
                        ? stores.localizationController
                            .localiztionComponentError()
                            .noSearchData
                        : stores.localizationController
                            .localiztionExerciseAddScreen()
                            .noMuscle);
              }
              return ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: stores.exerciseStateController.muscleList.length,
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  bool? isActive = selectedMuscles.any((element) =>
                      stores.exerciseStateController.muscleList[index].name ==
                      element);
                  return MuscleListItem(
                      isSelected: isActive,
                      onPress: onPressSelectedList,
                      onPressDelete: onPressDeleteMuscle,
                      isCanSelected: true,
                      item: stores.exerciseStateController.muscleList[index]);
                },
              );
            }),
            loadingFotter(muscleLoading, isRefresh,
                stores.exerciseStateController.muscleList.isNotEmpty),
          ]),
    );
  }
}
