import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/screens/home/package_home.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:intl/intl.dart';

class RoutineAddScreen extends StatefulWidget {
  RoutineAddScreen({super.key});

  @override
  State<RoutineAddScreen> createState() => _RoutineAddScreenState();
}

class _RoutineAddScreenState extends State<RoutineAddScreen> {
  Stores stores = Stores();

  final _controller = ScrollController();
  NetworkProviders networkProviders = NetworkProviders();
  TextEditingController _titleController = TextEditingController(text: '');
  TextEditingController _dateController = TextEditingController(text: '');
  TextEditingController _cycleController = TextEditingController(text: '');
  var isOpen = false;
  String routineName = '';
  String cycle = '';
  String date = '';
  String searchKeyword = '';

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

  late String standard;

  final buttonMaxSize = 48.0;
  final listMaxSize = 120.0;

  @override
  void initState() {
    super.initState();
    init();
    standard = stores.localizationController.localiztionRoutineAddScreen().day;
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
    });
    await getExerciseList();
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
    setState(() {
      exerciseLoading = true;
    });
    final result = await networkProviders.exerciseProvider
        .deleteCustomExercise(exercise.id);
    if (result) {
      stores.exerciseStateController.exerciseList.remove(exercise);
      if (stores.exerciseStateController.exerciseList.isEmpty) {
        stores.exerciseStateController.exerciseList = RxList<Exercise>.empty();
      }
      stores.appStateController.showToast(stores.localizationController
          .localiztionExerciseScreen()
          .successDelete);
    } else {
      stores.appStateController.showToast(stores.localizationController
          .localiztionExerciseScreen()
          .errorDelete);
    }
    setState(() {
      exerciseLoading = false;
    });
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
        date != '' &&
        cycle != '') return false;
    return true;
  }

  bool checkCycle() {
    num? now = num.tryParse(cycle);
    num? target = num.tryParse(date);

    if (standard ==
        stores.localizationController.localiztionRoutineAddScreen().day) {
      if (now != null && target != null) {
        if (now > target) return false;
        return true;
      } else {
        return false;
      }
    } else {
      if (now != null && target != null) {
        if (now > target * 7) return false;
        return true;
      } else {
        return false;
      }
    }
  }

  void onPressAdd(BuildContext context) async {
    try {
      if (!checkCycle()) {
        stores.appStateController.showToast(stores.localizationController
            .localiztionRoutineAddScreen()
            .errorCycle);
        return;
      }
      stores.appStateController.setIsLoading(true, context);
      await networkProviders.routineProvider.postCustomRoutine({
        'name': routineName,
        'cycle': cycle,
        'date': date,
        'exercises': selectExercise,
        'standard': standard,
        'startDate': _selectedDate != null ? '$_selectedDate' : null
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
                cursorColor: stores.colorController
                    .customColor()
                    .defaultBackground1, // 커서 색상
                // selectionColor: stores.colorController
                //     .customColor()
                //     .defaultBackground1
                //     .withAlpha(100), // 선택 영역 색상
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

  onChangedCycle(String value) {
    setState(() {
      cycle = value;
    });
  }

  onChangedDate(String value) {
    setState(() {
      date = value;
    });
  }

  void onPressExerciseAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExerciseAddScreen(),
          settings: RouteSettings(name: 'exerciseAdd')),
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

  void onChanged(String value) {
    stores.exerciseStateController.exerciseSort = tempSelectedSort.obs;
    stores.exerciseStateController.startAfter = null;
    stores.exerciseStateController.exerciseList = RxList<Exercise>.empty();
    stores.exerciseStateController.endExerciseList = false;
    setState(() {
      searchKeyword = value;
    });

    getExerciseList();
  }

  onChangedDropdown(value) {
    setState(() {
      standard = value;
    });
  }

  onPressCycle() {
    print('123');
  }

  @override
  Widget build(BuildContext context) {
    return safeAreaView(context,
        stores.localizationController.localiztionRoutineAddScreen().title,
        physics: AlwaysScrollableScrollPhysics(),
        rightText:
            stores.localizationController.localiztionRoutineAddScreen().add,
        isRightInActive: checkCanSave(),
        onPressRight: () => onPressAdd(context),
        scrollController: _controller,
        onRefresh: onRefresh,
        stickyWidget: Column(
          children: [
            addButton(context),
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
                  .localiztionRoutineAddScreen()
                  .inputTitlePlaceholder,
              onChanged: onChangedTitle,
            )),
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
                  onPress: onPressCycle,
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
                          '123',
                          style: stores.fontController.customFont().medium12,
                        ),
                      ),
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
