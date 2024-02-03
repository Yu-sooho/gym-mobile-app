import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

const buttonMaxSize = 48.0;
const listMaxSize = 120.0;

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
  int selectedSort = 0;
  int tempSelectedSort = 0;
  double itemExtent = 32.0;

  double openButtonSize = 0.0;
  double exerciseListSize = 0.0;
  double openButtonOpacity = 0.0;
  double exerciseListOpacity = 0.0;
  bool isShow = false;
  Duration duration = Duration(milliseconds: 250);

  List<String> selectExercise = [];
  List<Exercise> selectExerciseDetail = [];

  late List<String> sortMethod = [
    stores.localizationController.localiztionExerciseScreen().latestSort
  ];

  @override
  void initState() {
    super.initState();

    if (stores.exerciseStateController.exerciseList == null) {
      getExerciseList();
    }
    if (stores.exerciseStateController.muscles == null) {
      getMuscleList();
    } else {
      stores.exerciseStateController.muscles?.forEach((element) {
        sortMethod.add(element.name);
      });
    }

    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;
      double delta = 200.0;
      if (maxScroll - currentScroll <= delta) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
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
    if (stores.exerciseStateController.muscles == null) {
      await networkProviders.exerciseProvider.getMuscleList();
    }
    stores.exerciseStateController.muscles?.forEach((element) {
      sortMethod.add(element.name);
    });
  }

  Future<bool> getExerciseList() async {
    if (stores.exerciseStateController.endExerciseList || exerciseLoading) {
      return false;
    }
    setStateifMounted(() {
      exerciseLoading = true;
    });
    var musclesId = selectedSort != 0 ? selectedSort - 1 : null;
    final result = await networkProviders.exerciseProvider.getExerciseList(
        startAfter: stores.exerciseStateController.startAfter,
        limit: limit,
        musclesId: musclesId);
    setStateifMounted(() {
      exerciseLoading = false;
    });
    if (result.list.isNotEmpty) {
      if (result.length < limit) {
        setStateifMounted(() {
          stores.exerciseStateController.endExerciseList = true;
        });
      }
      setState(() {
        stores.exerciseStateController.startAfter = result.lastDoc;
        if (stores.exerciseStateController.exerciseList != null) {
          setStateifMounted(() {
            stores.exerciseStateController.exerciseList?.addAll(result.list);
          });
        } else if (result.list.isNotEmpty) {
          setStateifMounted(() {
            stores.exerciseStateController.exerciseList =
                RxList<Exercise>.from(result.list);
          });
        }
      });
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
      stores.exerciseStateController.exerciseList?.remove(exercise);
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
    print(exercise.name);
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
      stores.exerciseStateController.exerciseList = null;
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

  void onPressAdd(BuildContext context) async {
    try {
      stores.appStateController.setIsLoading(true, context);
      await networkProviders.routineProvider.postCustomRoutine({
        'name': routineName,
        'cycle': cycle,
        'date': date,
        'exercises': selectExercise,
      });
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
      selectedSort = tempSelectedSort;
      stores.exerciseStateController.startAfter = null;
      stores.exerciseStateController.exerciseList = null;
      stores.exerciseStateController.endExerciseList = false;
      exerciseLoading = false;
    });
    getExerciseList();
  }

  void onChangedSortMethod(int selectedItem) async {
    tempSelectedSort = selectedItem;
  }

  Widget sortBar(BuildContext context) {
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
                        initialItem: selectedSort,
                      ),
                      onSelectedItemChanged: onChangedSortMethod,
                      children:
                          List<Widget>.generate(sortMethod.length, (int index) {
                        return Center(child: Text(sortMethod[index]));
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
                    sortMethod[selectedSort],
                    style: stores.fontController.customFont().medium12,
                  ))),
        )));
  }

  showList() {
    setState(() {
      isShow = !isShow;
      exerciseListSize = isShow ? 0 : listMaxSize;
      exerciseListOpacity = isShow ? 0.0 : 1.0;
    });
  }

  onPressSelectedList(Exercise exercise) {
    onPressExercise(exercise);
    if (selectExercise.isEmpty) {
      showList();
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
        stores.exerciseStateController.exerciseList != null
            ? AnimatedOpacity(
                duration: duration,
                opacity: exerciseListOpacity,
                child: AnimatedContainer(
                    duration: duration,
                    height: exerciseListSize,
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: selectExercise.length,
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 20,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return ExerciseSelectedListItem(
                            onPress: onPressSelectedList,
                            key: Key('$index'),
                            item: selectExerciseDetail.firstWhere((element) =>
                                element.id == selectExercise[index]));
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
            SizedBox(
              height: 24,
            ),
            selectedList(selectExercise),
            sortBar(context),
          ],
        ),
        children: [
          stores.exerciseStateController.exerciseList == null &&
                  exerciseLoading == false
              ? SizedBox(
                  height: 120,
                  child: Align(
                      child: Text(
                    stores.localizationController
                        .localiztionExerciseScreen()
                        .noExercise,
                    style: stores.fontController.customFont().medium12,
                  )),
                )
              : stores.exerciseStateController.exerciseList == null &&
                      exerciseLoading == true &&
                      !isRefresh
                  ? SizedBox(
                      height: 120,
                      child: Align(
                        alignment: Alignment.center,
                        child: SpinKitFadingCircle(
                          size: 24,
                          color: stores.colorController
                              .customColor()
                              .loadingSpinnerColor,
                        ),
                      ),
                    )
                  : Obx(() {
                      return ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: stores
                                .exerciseStateController.exerciseList?.length ??
                            0,
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 20,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          bool? isActive = selectExercise.any((element) =>
                              stores.exerciseStateController
                                  .exerciseList![index].id ==
                              element);
                          return ExerciseListItem(
                              isSelected: isActive,
                              onPress: onPressExercise,
                              onPressDelete: onPressDelete,
                              key: Key('$index'),
                              item: stores.exerciseStateController
                                  .exerciseList![index]);
                        },
                      );
                    })
        ]);
  }
}
