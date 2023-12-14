import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
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

  QueryDocumentSnapshot<Object?>? startAfter;
  List<Exercise>? exerciseList;
  bool endExerciseList = false;
  int limit = 10;
  double headerHeight = 48 + 16;
  bool exerciseLoading = false;

  double sortBarHeight = 40;

  int selectedSort = 0;
  int tempSelectedSort = 0;
  double itemExtent = 32.0;
  late List<String> sortMethod = [
    stores.localizationController.localiztionExerciseScreen().latestSort
  ];

  void getMuscleList() async {
    if (stores.exerciseStateController.muscles == null) {
      await networkProviders.exerciseProvider.getMuscleList();
    }
    stores.exerciseStateController.muscles?.forEach((element) {
      sortMethod.add(element.name);
    });
  }

  void getExerciseList() async {
    if (endExerciseList || exerciseLoading) return;
    setState(() {
      exerciseLoading = true;
    });
    var musclesId = selectedSort != 0 ? selectedSort - 1 : null;
    final result = await networkProviders.exerciseProvider.getExerciseList(
        startAfter: startAfter, limit: limit, musclesId: musclesId);
    setState(() {
      exerciseLoading = false;
    });
    if (result.list.isNotEmpty) {
      if (result.length < limit) {
        setState(() {
          endExerciseList = true;
        });
      }
      setState(() {
        startAfter = result.lastDoc;
        if (exerciseList != null) {
          setState(() {
            exerciseList?.addAll(result.list);
          });
        } else if (result.list.isNotEmpty) {
          setState(() {
            exerciseList = result.list;
          });
        }
      });
    }
  }

  void afterAdd() async {
    setState(() {
      exerciseLoading = true;
    });
    final result =
        await networkProviders.exerciseProvider.getExerciseList(limit: 1);
    setState(() {
      exerciseLoading = false;
    });
    if (result.list.isNotEmpty) {
      setState(() {
        if (exerciseList != null) {
          exerciseList?.insertAll(0, result.list);
        }
      });
    }
  }

  Future onRefresh() async {
    setState(() {
      startAfter = null;
      exerciseList = null;
      endExerciseList = false;
      exerciseLoading = false;
    });
    getExerciseList();
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

  void getHeight(double height) {
    setState(() {
      headerHeight = height + 16 + 32;
    });
  }

  void onPress(Exercise item) {}

  void onChangedSortMethod(int selectedItem) async {
    setState(() {
      tempSelectedSort = selectedItem;
    });
  }

  void onPressSortMethodOk() async {
    setState(() {
      selectedSort = tempSelectedSort;
      startAfter = null;
      exerciseList = null;
      endExerciseList = false;
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

  @override
  Widget build(BuildContext context) {
    return (TabAreaView(
        minHeaderSize: 64 + sortBarHeight,
        maxHeaderSize: 242 + sortBarHeight,
        onRefresh: onRefresh,
        scrollController: _controller,
        paddingTop: 12,
        header: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: ExerciseAddItem(
                key: _containerkey,
                afterFunc: afterAdd,
                getHeight: getHeight,
              )),
          sortBar(context)
        ]),
        headerSize: headerHeight,
        children: [
          exerciseList == null && exerciseLoading == false
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
              : ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: exerciseList?.length ?? 0,
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ExerciseListItem(
                        onPress: onPress,
                        key: Key('$index'),
                        item: exerciseList![index]);
                  },
                )
        ]));
  }
}
