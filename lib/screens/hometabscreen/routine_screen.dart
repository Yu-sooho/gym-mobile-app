import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_calendar/models/routine_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineScreen extends StatefulWidget {
  RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  Stores stores = Stores();
  QueryDocumentSnapshot<Object?>? startAfter;
  List<Routine>? routineList;
  bool endRoutineList = false;
  bool routineLoading = false;

  final _controller = ScrollController();

  double headerHeight = 48 + 16;
  double sortBarHeight = 40;

  double itemExtent = 32.0;
  int selectedSort = 0;
  int tempSelectedSort = 0;
  late List<String> sortMethod = [
    stores.localizationController.localiztionRoutineScreen().latestSort
  ];

  final Duration duration = Duration(milliseconds: 250);

  Future onRefresh() async {}

  void onChangedSortMethod(int selectedItem) async {
    tempSelectedSort = selectedItem;
  }

  void onPressSortMethodOk() async {
    setState(() {
      selectedSort = tempSelectedSort;
      startAfter = null;
      routineList = null;
      endRoutineList = false;
      routineLoading = false;
    });
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
        paddingTop: 12,
        openDuration: duration,
        closeDuration: duration,
        minHeaderSize: 64 + sortBarHeight,
        maxHeaderSize: 234 + sortBarHeight,
        onRefresh: onRefresh,
        scrollController: _controller,
        headerSize: headerHeight,
        header: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: RoutineAddItem(
                duration: duration,
                // key: _containerkey,
                // afterFunc: afterAdd,
                // getHeight: getHeight,
              )),
          sortBar(context)
        ]),
        children: []));
  }
}
