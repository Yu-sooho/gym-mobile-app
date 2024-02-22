import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/screens/home/exercise/exercise_add_screen.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  NetworkProviders networkProviders = NetworkProviders();
  Stores stores = Stores();
  final _controller = ScrollController();

  int limit = 10;
  double headerHeight = 48 + 16;
  bool exerciseLoading = false;
  bool isRefresh = false;
  double sortBarHeight = 40;
  int tempSelectedSort = 0;
  double itemExtent = 32.0;
  String searchKeyword = '';

  final Duration duration = Duration(milliseconds: 250);

  void onPressAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExerciseAddScreen(),
          settings: RouteSettings(name: 'exerciseAdd')),
    );
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
        sort: stores.exerciseStateController.exerciseSortMethod[
            stores.exerciseStateController.exerciseSort.value],
        startAfter: stores.exerciseStateController.startAfter,
        limit: limit,
        searchKeyword: searchKeyword);
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

  Future onRefresh() async {
    setState(() {
      isRefresh = true;
      stores.exerciseStateController.startAfter = null;
      stores.exerciseStateController.exerciseList = RxList<Exercise>.empty();
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
    getExerciseList();

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
          if (exerciseLoading || isRefresh) return;
          getExerciseList();
        }
      }
    });
  }

  void onPress(Exercise item) {}

  void onChangedSortMethod(int selectedItem) async {
    tempSelectedSort = selectedItem;
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

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: (TabAreaView(
          openDuration: duration,
          closeDuration: duration,
          minHeaderSize: sortBarHeight + 64 - 12,
          maxHeaderSize: sortBarHeight + 64 - 12,
          onRefresh: onRefresh,
          scrollController: _controller,
          paddingTop: 12,
          header: Column(children: [
            addButton(
                context,
                () => onPressAdd(context),
                stores.localizationController
                    .localiztionExerciseScreen()
                    .addExercise),
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
              height: 4,
            )
          ]),
          headerSize: headerHeight,
          children: [
            Obx(() {
              if (stores.exerciseStateController.exerciseList.isEmpty) {
                return emptyContainer(exerciseLoading, isRefresh);
              }
              return (ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: stores.exerciseStateController.exerciseList.length,
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
                      item: stores.exerciseStateController.exerciseList[index]);
                },
              ));
            }),
            loadingFotter(exerciseLoading, isRefresh,
                stores.exerciseStateController.exerciseList.isNotEmpty),
          ])),
    );
  }
}
