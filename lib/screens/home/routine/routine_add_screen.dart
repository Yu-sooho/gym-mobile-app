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

  final buttonMaxSize = 48.0;
  final listMaxSize = 120.0;

  @override
  void initState() {
    super.initState();

    if (stores.exerciseStateController.exerciseList.isEmpty) {
      getExerciseList();
    }
    if (stores.exerciseStateController.muscles.isEmpty) {
      getMuscleList();
    }

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

  void setStateifMounted(Function() afterFunc) {
    if (!mounted) return;
    afterFunc();
  }

  void getMuscleList() async {
    if (stores.exerciseStateController.muscles.isEmpty) {
      await networkProviders.exerciseProvider.getMuscleList();
    }
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

    if (now != null && target != null) {
      if (now > target) return false;
      return true;
    } else {
      return false;
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
        'startDate': '${_selectedDate ?? ''}'
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

  Widget sortBar(BuildContext context) {
    return Obx(() {
      return (Container(
          height: sortBarHeight,
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: CustomButton(
                onPress: () => stores.appStateController.showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: itemExtent,
                        scrollController: FixedExtentScrollController(
                          initialItem:
                              stores.exerciseStateController.exerciseSort.value,
                        ),
                        onSelectedItemChanged: onChangedSortMethod,
                        children: List<Widget>.generate(
                            stores.exerciseStateController.exerciseSortMethod
                                .length, (int index) {
                          return Center(
                              child: Text(stores.exerciseStateController
                                  .exerciseSortMethod[index]));
                        }),
                      ),
                      context,
                      isHaveButton: true,
                      onPressOk: onPressSortMethodOk,
                    ),
                highlightColor: Colors.transparent,
                child: Container(
                    height: 24,
                    width: 72,
                    alignment: Alignment.centerRight,
                    child: Text(
                      stores.exerciseStateController.exerciseSortMethod[
                          stores.exerciseStateController.exerciseSort.value],
                      style: stores.fontController.customFont().medium12,
                    ))),
          )));
    });
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
    );
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
                child: customTextInput(
              context,
              controller: _titleController,
              maxLength: 20,
              counterText: '',
              placeholder: stores.localizationController
                  .localiztionRoutineAddScreen()
                  .inputTitlePlaceholder,
              onChangedTitle,
            )),
            TwoTextInput(
              stores: stores,
              textController1: _dateController,
              textController2: _cycleController,
              title: stores.localizationController
                  .localiztionRoutineAddScreen()
                  .cycle,
              placeholder1: stores.localizationController
                  .localiztionRoutineAddScreen()
                  .repeat,
              placeholder2: stores.localizationController
                  .localiztionRoutineAddScreen()
                  .cycleDate,
              onChanged1: onChangedCycle,
              onChanged2: onChangedDate,
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
                              .buttonActiveText),
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
            sortBar(context),
          ],
        ),
        children: [
          Obx(() {
            if (stores.exerciseStateController.exerciseList.isEmpty) {
              return emptyContainer(exerciseLoading, isRefresh);
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
