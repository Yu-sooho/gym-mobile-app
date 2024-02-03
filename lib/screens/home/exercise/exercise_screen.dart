import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/screens/home/exercise/exercise_add_screen.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final GlobalKey _containerkey = GlobalKey();
  NetworkProviders networkProviders = NetworkProviders();
  Stores stores = Stores();
  final _controller = ScrollController();

  int limit = 10;
  double headerHeight = 48 + 16;
  bool exerciseLoading = false;
  bool isRefresh = false;
  double sortBarHeight = 40;
  int selectedSort = 0;
  int tempSelectedSort = 0;
  double itemExtent = 32.0;
  late List<String> sortMethod = [
    stores.localizationController.localiztionExerciseScreen().latestSort
  ];

  final Duration duration = Duration(milliseconds: 250);

  void onPressAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExerciseAddScreen(),
          settings: RouteSettings(name: 'exerciseAdd')),
    );
  }

  void getMuscleList() async {
    if (stores.exerciseStateController.muscles == null) {
      await networkProviders.exerciseProvider.getMuscleList();
    }
    stores.exerciseStateController.muscles?.forEach((element) {
      sortMethod.add(element.name);
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

  Future onRefresh() async {
    setState(() {
      isRefresh = true;
      stores.exerciseStateController.startAfter = null;
      stores.exerciseStateController.exerciseList = null;
      stores.exerciseStateController.endExerciseList = false;
      exerciseLoading = false;
    });
    await getExerciseList();
    setState(() {
      isRefresh = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getMuscleList();
    getExerciseList();

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

  Size? getSize() {
    if (_containerkey.currentContext != null) {
      final RenderBox renderBox =
          _containerkey.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }
    return null;
  }

  void onPress(Exercise item) {}

  void onChangedSortMethod(int selectedItem) async {
    tempSelectedSort = selectedItem;
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

  Widget addButton(BuildContext context) {
    return (Padding(
        padding: EdgeInsets.only(top: 24),
        child: CustomButton(
          onPress: () => onPressAdd(context),
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
    return (TabAreaView(
        openDuration: duration,
        closeDuration: duration,
        minHeaderSize: sortBarHeight + 64,
        maxHeaderSize: sortBarHeight + 64,
        onRefresh: onRefresh,
        scrollController: _controller,
        paddingTop: 12,
        header: Column(children: [addButton(context), sortBar(context)]),
        headerSize: headerHeight,
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
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 20,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ExerciseListItem(
                              onPress: onPress,
                              onPressDelete: onPressDelete,
                              key: Key('$index'),
                              item: stores.exerciseStateController
                                  .exerciseList![index]);
                        },
                      );
                    })
        ]));
  }
}
