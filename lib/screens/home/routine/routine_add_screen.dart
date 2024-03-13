import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/screens/home/package_home.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/utils/package_util.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:intl/intl.dart';

class RoutineAddScreen extends StatefulWidget {
  final Routine? routine;
  final Function? updateRoutineInMap;
  RoutineAddScreen({super.key, this.routine, this.updateRoutineInMap});

  @override
  State<RoutineAddScreen> createState() => _RoutineAddScreenState();
}

class _RoutineAddScreenState extends State<RoutineAddScreen> {
  Stores stores = Stores();

  final _controller = ScrollController();
  NetworkProviders networkProviders = NetworkProviders();
  TextEditingController _titleController = TextEditingController(text: '');
  var isOpen = false;
  String routineName = '';
  String searchKeyword = '';
  late Color selectedColor;

  int limit = 10;
  bool exerciseLoading = false;
  bool isRefresh = false;
  double sortBarHeight = 40;
  int tempSelectedSort = 0;
  double itemExtent = 32.0;

  double openButtonSize = 0.0;
  double exerciseListSize = 0.0;
  double openButtonOpacity = 0.0;
  double exerciseListOpacity = 0.0;
  bool isShow = false;
  Duration duration = Duration(milliseconds: 250);

  DateTime? _selectedDate;

  List<String> selectExercise = [];
  List<Exercise> selectExerciseDetail = [];
  List<List>? routineCycle;

  final buttonMaxSize = 48.0;
  final listMaxSize = 120.0;

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
          getExerciseList();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future init() async {
    setState(() {
      stores.exerciseStateController.startAfter = null;
      stores.exerciseStateController.exerciseList = RxList<Exercise>.empty();
      stores.exerciseStateController.endExerciseList = false;
      exerciseLoading = false;
      selectExercise = [];
      selectExerciseDetail = [];
      selectedColor = stores.colorController.customColor().routineColors[0];
    });
    if (widget.routine != null) {
      isEditSetting();
    }
    await getExerciseList();
  }

  void isEditSetting() {
    _titleController.text = widget.routine!.name;
    if (widget.routine?.color != null) {
      setState(() {
        selectedColor = stringToColor(widget.routine!.color);
      });
    }

    if (widget.routine!.startDate != null) {
      setState(() {
        _selectedDate = widget.routine!.startDate?.toDate();
      });
    }
    if (widget.routine?.exercises != null) {
      widget.routine?.exercises.forEach((element) =>
          {selectExercise.add(element.id), selectExerciseDetail.add(element)});
      setState(() {
        openButtonSize = buttonMaxSize;
        openButtonOpacity = 1.0;
      });
    }
    setState(() {
      routineName = widget.routine!.name;
      routineCycle =
          Math().convertedRecycle(widget.routine?.routineCycle ?? '');
    });
  }

  void setStateifMounted(Function() afterFunc) {
    if (!mounted) return;
    afterFunc();
  }

  Future<bool> getExerciseList() async {
    if (stores.exerciseStateController.endExerciseList || exerciseLoading) {
      return false;
    }
    setState(() {
      exerciseLoading = true;
    });
    final result = await networkProviders.exerciseProvider.getExerciseList(
        startAfter: stores.exerciseStateController.startAfter,
        limit: limit,
        searchKeyword: searchKeyword,
        sort: stores.exerciseStateController.exerciseSortMethod[
            stores.exerciseStateController.exerciseSort.value]);
    setState(() {
      exerciseLoading = false;
    });
    if (result.list.isNotEmpty) {
      if (result.length < limit) {
        stores.exerciseStateController.endExerciseList = true;
      }
      stores.exerciseStateController.startAfter = result.lastDoc;
      stores.exerciseStateController.exerciseList.addAll(result.list);
    } else {
      stores.exerciseStateController.endExerciseList = true;
    }
    return true;
  }

  Future onPressDelete(BuildContext context, Exercise exercise) async {
    showDialog(
        context: context,
        builder: (context) => CustomModalScreen(
            description: stores.localizationController
                .localiztionModalScreenText()
                .deleteExercise,
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
                exerciseLoading = true;
              });
              final result = await networkProviders.exerciseProvider
                  .deleteCustomExercise(exercise.id);
              if (result) {
                stores.exerciseStateController.exerciseList.remove(exercise);
                if (stores.exerciseStateController.exerciseList.isEmpty) {
                  stores.exerciseStateController.exerciseList =
                      RxList<Exercise>.empty();
                }
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
                exerciseLoading = false;
              });
              Get.back();
            }));
  }

  onPressExercise(Exercise exercise) {
    if (selectExercise.isEmpty) {
      setState(() {
        selectExercise.add(exercise.id);
        selectExerciseDetail.add(exercise);
      });
      setState(() {
        openButtonSize = buttonMaxSize;
        openButtonOpacity = 1.0;
      });
      return;
    }
    String? find = selectExercise.firstWhereOrNull(
      (element) => element == exercise.id,
    );
    if (find != null) {
      if (selectExercise.length == 1) {
        setState(() {
          openButtonSize = 0.0;
          openButtonOpacity = 0.0;
          isShow = false;
          exerciseListSize = 0;
          exerciseListOpacity = 0;
        });
      }
      setState(() {
        selectExercise.remove(find);
        selectExerciseDetail.remove(exercise);
      });
    } else {
      setState(() {
        selectExercise.add(exercise.id);
        selectExerciseDetail.add(exercise);
        openButtonSize = buttonMaxSize;
        openButtonOpacity = 1.0;
      });
    }
  }

  Future onRefresh() async {
    setState(() {
      isRefresh = true;
      stores.exerciseStateController.startAfter = null;
      stores.exerciseStateController.exerciseList = RxList<Exercise>.empty();
      stores.exerciseStateController.endExerciseList = false;
      exerciseLoading = false;
      selectExercise = [];
      selectExerciseDetail = [];
    });
    await getExerciseList();
    setState(() {
      isRefresh = false;
    });
  }

  onChangedTitle(String value) {
    setState(() {
      routineName = value;
    });
  }

  checkCanSave() {
    if (routineName != '' &&
        selectExercise.isNotEmpty &&
        routineCycle != null) {
      return false;
    }
    return true;
  }

  void onPressAdd(BuildContext context) async {
    try {
      stores.appStateController.setIsLoading(true, context);

      await networkProviders.routineProvider.postCustomRoutine({
        'name': routineName,
        'routineCycle': '$routineCycle',
        'exercises': selectExercise,
        'color': colorToString(selectedColor),
        'startDate':
            _selectedDate != null ? DateTime.parse('$_selectedDate') : null,
        'endDate': null,
        'isEnded': null,
        'executionDate': null,
      });
      final result =
          await networkProviders.routineProvider.getRoutineList(limit: 1);
      if (result.list.isNotEmpty) {
        stores.routineStateController.routineList.insertAll(0, result.list);
      }
      if (!context.mounted) return;
      stores.appStateController.setIsLoading(false, context);
      stores.appStateController.showToast(
          stores.localizationController.localiztionRoutineAddScreen().success);
      Navigator.pop(context);
    } catch (error) {
      print('routine_add_screen onPressAdd error:$error');
      stores.appStateController.setIsLoading(false, context);
      stores.appStateController.showToast(stores.localizationController
          .localiztionComponentError()
          .networkError);
    }
  }

  void onPressEdit(BuildContext context) async {
    final docName = widget.routine?.docName;
    if (docName == null) return;
    try {
      stores.appStateController.setIsLoading(true, context);

      await networkProviders.routineProvider.putCustomRoutine({
        'name': routineName,
        'routineCycle': '$routineCycle',
        'exercises': selectExercise,
        'color': colorToString(selectedColor),
        'startDate':
            _selectedDate != null ? DateTime.parse('$_selectedDate') : null,
        'endDate': null,
        'isEnded': null,
        'executionDate': null,
      }, docName);
      final result =
          await networkProviders.routineProvider.getRoutineList(limit: 1);
      if (result.list.isNotEmpty) {
        final temp = stores.routineStateController.routineList
            .indexWhere((element) => element.id == widget.routine?.id);
        if (temp >= 0) {
          stores.routineStateController.routineList[temp] = result.list[0];
        }
      }
      if (!context.mounted) return;
      stores.appStateController.setIsLoading(false, context);
      stores.appStateController.showToast(stores.localizationController
          .localiztionRoutineAddScreen()
          .editSuccess);
      if (widget.updateRoutineInMap != null) {
        widget.updateRoutineInMap!(result.list[0]);
      }
      Navigator.pop(context);
    } catch (error) {
      print('routine_add_screen onPressEdit error:$error');
      stores.appStateController.setIsLoading(false, context);
      stores.appStateController.showToast(stores.localizationController
          .localiztionComponentError()
          .networkError);
    }
  }

  void onPressSortMethodOk() async {
    setState(() {
      stores.exerciseStateController.exerciseSort = tempSelectedSort.obs;
      stores.exerciseStateController.startAfter = null;
      stores.exerciseStateController.exerciseList = RxList<Exercise>.empty();
      stores.exerciseStateController.endExerciseList = false;
      exerciseLoading = false;
    });
    getExerciseList();
  }

  void onChangedSortMethod(int selectedItem) async {
    tempSelectedSort = selectedItem;
  }

  showList() {
    if (isShow) {
      setState(() {
        isShow = false;
        exerciseListSize = 0;
        exerciseListOpacity = 0;
      });
    } else {
      setState(() {
        isShow = true;
        exerciseListSize = listMaxSize;
        exerciseListOpacity = 1.0;
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        locale: stores.localizationController.language.value == 0
            ? Locale('en', 'US')
            : Locale('ko', 'KR'),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor:
                    stores.colorController.customColor().defaultBackground1,
              ),
              textTheme: TextTheme(
                titleLarge: TextStyle(
                    color: stores.colorController
                        .customColor()
                        .defaultBackground1),
                titleSmall: TextStyle(
                    color: stores.colorController
                        .customColor()
                        .defaultBackground1),
                bodyLarge: TextStyle(
                    color: stores.colorController
                        .customColor()
                        .defaultBackground1),
                bodySmall: TextStyle(
                    color: stores.colorController
                        .customColor()
                        .defaultBackground1),
                bodyMedium: TextStyle(
                    color: stores.colorController
                        .customColor()
                        .defaultBackground1),
                titleMedium: TextStyle(
                    color: stores.colorController
                        .customColor()
                        .defaultBackground1), // 입력창 텍스트 색상
              ),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(
                    color: stores.colorController
                        .customColor()
                        .defaultBackground1), // 레이블 텍스트 색상
                hintStyle: TextStyle(color: Colors.grey), // 힌트 텍스트 색상
              ),
              colorScheme: ColorScheme.dark(
                primary: stores.colorController
                    .customColor()
                    .defaultBackground1, // header background color
                onPrimary: stores.colorController
                    .customColor()
                    .buttonDefaultColor, // header text color
                surface: stores.colorController
                    .customColor()
                    .buttonDefaultColor, // calendar background color
                onSurface: stores.colorController
                    .customColor()
                    .defaultBackground1, // calendar text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor:
                        stores.colorController.customColor().defaultBackground1,
                    backgroundColor: stores.colorController
                        .customColor()
                        .buttonDefaultColor // Background color of the buttons
                    ),
              ),
              dialogBackgroundColor: stores.colorController
                  .customColor()
                  .buttonDefaultColor, // overall background color
            ),
            child: child!,
          );
        });
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
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
                                    .localiztionRoutineAddScreen()
                                    .exerciseListCheck,
                                style:
                                    stores.fontController.customFont().bold12,
                              ),
                              Text(
                                '(${selectExercise.length})',
                                style:
                                    stores.fontController.customFont().bold12,
                              )
                            ],
                          )))),
            )),
        stores.exerciseStateController.exerciseList.isNotEmpty
            ? AnimatedOpacity(
                duration: duration,
                opacity: exerciseListOpacity,
                child: AnimatedContainer(
                    duration: duration,
                    height: exerciseListSize,
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: selectExercise.length,
                      itemExtent: 32,
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      itemBuilder: (BuildContext context, int index) {
                        final Exercise item = selectExerciseDetail.firstWhere(
                            (element) => element.id == selectExercise[index]);
                        final String name = item.name;
                        return SelectListItem(
                          selectedItem: selectExercise[index],
                          onPress: () => {onPressExercise(item)},
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
                    )),
              )
            : SizedBox(),
      ],
    ));
  }

  onPressExerciseAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExerciseAddScreen(),
          settings: RouteSettings(name: 'exerciseAdd')),
    );
  }

  onChanged(String value) {
    stores.exerciseStateController.exerciseSort = tempSelectedSort.obs;
    stores.exerciseStateController.startAfter = null;
    stores.exerciseStateController.exerciseList = RxList<Exercise>.empty();
    stores.exerciseStateController.endExerciseList = false;
    setState(() {
      searchKeyword = value;
    });

    getExerciseList();
  }

  onPressSaveCycle(BuildContext context, List<List> list) {
    setState(() {
      routineCycle = list;
    });

    Navigator.pop(context);
  }

  onPressCycle(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RoutineCycleScreen(
        onPress: onPressSaveCycle,
        initRoutine: routineCycle,
      ),
    );
  }

  onPressSaveColor(BuildContext context, Color color) {
    setState(() {
      selectedColor = color;
    });

    Navigator.pop(context);
  }

  onPressColor() {
    showDialog(
      context: context,
      builder: (context) => RoutineColorScreen(
        onPress: onPressSaveColor,
        initColor: selectedColor,
      ),
    );
  }

  Widget addButton(BuildContext context) {
    return (Padding(
        padding: EdgeInsets.only(top: 12),
        child: CustomButton(
          onPress: () => onPressExerciseAdd(context),
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

  @override
  Widget build(BuildContext context) {
    return SafeAreaView(
        title: widget.routine != null
            ? stores.localizationController
                .localiztionRoutineAddScreen()
                .editTitle
            : stores.localizationController.localiztionRoutineAddScreen().title,
        physics: AlwaysScrollableScrollPhysics(),
        rightText: widget.routine != null
            ? stores.localizationController.localiztionComponentButton().edit
            : stores.localizationController.localiztionComponentButton().add,
        isRightInActive: checkCanSave(),
        onPressRight: () =>
            widget.routine != null ? onPressEdit(context) : onPressAdd(context),
        scrollController: _controller,
        onRefresh: onRefresh,
        stickyWidget: Column(
          children: [
            addButton(context),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Flexible(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                        child: SizedBox(
                            height: 32,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                stores.localizationController
                                    .localiztionRoutineAddScreen()
                                    .inputTitle,
                                style:
                                    stores.fontController.customFont().bold12,
                              ),
                            )),
                      ),
                      SizedBox(
                          child: CustomTextInput(
                        controller: _titleController,
                        maxLength: 20,
                        counterText: '',
                        placeholder: widget.routine?.name ??
                            stores.localizationController
                                .localiztionRoutineAddScreen()
                                .inputTitlePlaceholder,
                        onChanged: onChangedTitle,
                      )),
                    ],
                  )),
                  SizedBox(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: SizedBox(
                            height: 32,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                stores.localizationController
                                    .localiztionRoutineAddScreen()
                                    .colorTitle,
                                style:
                                    stores.fontController.customFont().bold12,
                              ),
                            )),
                      ),
                      CustomButton(
                          onPress: onPressColor,
                          child: SizedBox(
                              width: 48,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                                child: Align(
                                    // 여기 Align 위젯을 추가합니다.
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: selectedColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      width: 10,
                                      height: 10,
                                    )),
                              )))
                    ],
                  ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: SizedBox(
                  height: 32,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      stores.localizationController
                          .localiztionRoutineAddScreen()
                          .cycle,
                      style: stores.fontController.customFont().bold12,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: InkWell(
                splashColor: stores.colorController.customColor().transparent,
                hoverColor: stores.colorController.customColor().buttonOpacity,
                onTap: () {},
                child: CustomButton(
                  onPress: () => {onPressCycle(context)},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: stores.colorController
                                .customColor()
                                .buttonDefaultColor),
                      ),
                    ),
                    width: double.infinity,
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child:
                          Align(child: routineCycleItem(stores, routineCycle)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: SizedBox(
                  height: 32,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      stores.localizationController
                          .localiztionRoutineAddScreen()
                          .startDate,
                      style: stores.fontController.customFont().bold12,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: InkWell(
                onTap: () => selectDate(context),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: stores.colorController
                              .customColor()
                              .buttonDefaultColor),
                    ),
                  ),
                  width: double.infinity,
                  height: 40,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Align(
                      child: Text(
                        _selectedDate != null
                            ? DateFormat(stores.localizationController
                                    .localiztionRoutineAddScreen()
                                    .dateFormat)
                                .format(_selectedDate!)
                            : stores.localizationController
                                .localiztionRoutineAddScreen()
                                .selectedDate,
                        style: _selectedDate != null
                            ? stores.fontController.customFont().bold12
                            : stores.fontController.customFont().medium12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            selectedList(selectExercise),
            CustomSortBar(
                sortValue: stores.exerciseStateController.exerciseSort.value,
                initialItem: stores.exerciseStateController.exerciseSort.value,
                onChangedSortMethod: onChangedSortMethod,
                onPressSortMethodOk: onPressSortMethodOk,
                isSearch: true,
                itemExtent: itemExtent,
                sortBarHeight: sortBarHeight,
                onChanged: onChanged),
            SizedBox(
              height: 6,
            ),
          ],
        ),
        children: [
          Obx(() {
            if (stores.exerciseStateController.exerciseList.isEmpty) {
              return emptyContainer(exerciseLoading, isRefresh,
                  text: searchKeyword.isNotEmpty
                      ? stores.localizationController
                          .localiztionComponentError()
                          .noSearchData
                      : null);
            }
            return (ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: stores.exerciseStateController.exerciseList.length,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                bool? isActive = selectExercise.any((element) =>
                    stores.exerciseStateController.exerciseList[index].id ==
                    element);
                return ExerciseListItem(
                    index: index,
                    isCanSelected: true,
                    isSelected: isActive,
                    disabledDelete: isActive,
                    onPress: onPressExercise,
                    onPressDelete: onPressDelete,
                    key: Key('$index'),
                    item: stores.exerciseStateController.exerciseList[index]);
              },
            ));
          }),
          loadingFotter(exerciseLoading, isRefresh,
              stores.exerciseStateController.exerciseList.isNotEmpty),
        ]);
  }
}

Widget routineCycleItem(Stores stores, List<List>? routineCycle) {
  final totalItems = routineCycle?.expand((innerList) => innerList).length;

  if (routineCycle != null) {
    return (SizedBox(
      child: Text(
        '${routineCycle.length}${stores.localizationController.localiztionRoutineAddScreen().week} $totalItems${stores.localizationController.localiztionRoutineAddScreen().count} ${stores.localizationController.localiztionRoutineAddScreen().routineCycle}',
        style: stores.fontController.customFont().medium12,
      ),
    ));
  }
  return (SizedBox(
    child: Text(
      stores.localizationController
          .localiztionRoutineAddScreen()
          .startDateHintText,
      style: stores.fontController.customFont().medium12,
    ),
  ));
}
