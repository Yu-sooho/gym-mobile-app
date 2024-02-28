import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/routine_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/screens/home/routine/package_routine.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineScreen extends StatefulWidget {
  RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  NetworkProviders networkProviders = NetworkProviders();
  Stores stores = Stores();
  final _controller = ScrollController();
  bool isRefresh = false;
  bool routineLoading = false;
  String searchKeyword = '';

  int limit = 10;

  double headerHeight = 48 + 16;
  double sortBarHeight = 40;

  double itemExtent = 32.0;
  int tempSelectedSort = 0;
  final Duration duration = Duration(milliseconds: 250);

  Future onRefresh() async {
    setState(() {
      isRefresh = true;
      stores.routineStateController.startAfterRoutine = null;
      stores.routineStateController.routineList = RxList<Routine>.empty();
      stores.routineStateController.endRoutineList = false;
      routineLoading = false;
    });
    await getRoutineList();
    setState(() {
      isRefresh = false;
    });
  }

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
          if (routineLoading || isRefresh) return;
          getRoutineList();
        }
      }
    });
  }

  Future init() async {
    setState(() {
      stores.routineStateController.startAfterRoutine = null;
      stores.routineStateController.routineList = RxList<Routine>.empty();
      stores.routineStateController.endRoutineList = false;
      routineLoading = false;
    });
    await getRoutineList();
  }

  Future<bool> getRoutineList() async {
    if (stores.routineStateController.endRoutineList || routineLoading) {
      return false;
    }
    setState(() {
      routineLoading = true;
    });
    final result = await networkProviders.routineProvider.getRoutineList(
        startAfter: stores.routineStateController.startAfterRoutine,
        searchKeyword: searchKeyword,
        limit: limit,
        sort: stores.routineStateController.routineSortMethod[
            stores.routineStateController.routineSort.value]);
    setState(() {
      routineLoading = false;
    });
    if (result.list.isNotEmpty) {
      if (result.length < limit) {
        stores.routineStateController.endRoutineList = true;
      }
      stores.routineStateController.startAfterRoutine = result.lastDoc;
      stores.routineStateController.routineList.addAll(result.list);
    } else {
      stores.routineStateController.endRoutineList = true;
    }
    return true;
  }

  void onChangedSortMethod(int selectedItem) async {
    tempSelectedSort = selectedItem;
  }

  void onPressSortMethodOk() async {
    setState(() {
      stores.routineStateController.routineSort = tempSelectedSort.obs;
      stores.routineStateController.startAfterRoutine = null;
      stores.routineStateController.routineList = RxList<Routine>.empty();
      stores.routineStateController.endRoutineList = false;
      routineLoading = false;
    });
    getRoutineList();
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
                        initialItem:
                            stores.routineStateController.routineSort.value,
                      ),
                      onSelectedItemChanged: onChangedSortMethod,
                      children: List<Widget>.generate(
                          stores.routineStateController.routineSortMethod
                              .length, (int index) {
                        return Center(
                            child: Text(stores.routineStateController
                                .routineSortMethod[index]));
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
                    stores.routineStateController.routineSortMethod[
                        stores.routineStateController.routineSort.value],
                    style: stores.fontController.customFont().medium12,
                  ))),
        )));
  }

  onPressAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RoutineAddScreen(),
          settings: RouteSettings(name: 'routineAdd')),
    );
  }

  Widget addButton(BuildContext context) {
    return (Padding(
        padding: EdgeInsets.only(top: 12),
        child: CustomButton(
          onPress: onPressAdd,
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
                            .localiztionRoutineScreen()
                            .addRoutine,
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
    stores.routineStateController.startAfterRoutine = null;
    stores.routineStateController.routineList = RxList<Routine>.empty();
    stores.routineStateController.endRoutineList = false;
    setState(() {
      searchKeyword = value;
    });
    getRoutineList();
  }

  void onPressDelete(BuildContext context, Routine routine) {
    showDialog(
        context: context,
        builder: (context) => CustomModalScreen(
            description: stores.localizationController
                .localiztionModalScreenText()
                .deleteRoutine,
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
                routineLoading = true;
              });
              final result = await networkProviders.routineProvider
                  .deleteCustomRoutine(routine.id);
              if (result) {
                stores.routineStateController.routineList.remove(routine);
                if (stores.routineStateController.routineList.isEmpty) {
                  stores.routineStateController.routineList =
                      RxList<Routine>.empty();
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
                routineLoading = false;
              });
              Get.back();
            }));
  }

  void onPressEdit(BuildContext context, Routine routine, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RoutineAddScreen(routine: routine)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (TabAreaView(
        paddingTop: 12,
        openDuration: duration,
        closeDuration: duration,
        minHeaderSize: sortBarHeight + 64 - 12,
        maxHeaderSize: sortBarHeight + 64 - 12,
        onRefresh: onRefresh,
        scrollController: _controller,
        headerSize: headerHeight,
        header: Column(children: [
          addButton(context),
          CustomSortBar(
              sortValue: stores.routineStateController.routineSort.value,
              initialItem: stores.routineStateController.routineSort.value,
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
        children: [
          Obx(() {
            if (stores.routineStateController.routineList.isEmpty) {
              return emptyContainer(routineLoading, isRefresh,
                  text: searchKeyword.isNotEmpty
                      ? stores.localizationController
                          .localiztionComponentError()
                          .noSearchData
                      : stores.localizationController
                          .localiztionRoutineScreen()
                          .noRoutine);
            }
            return (ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: stores.routineStateController.routineList.length,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                return RoutineListItem(
                    index: index,
                    item: stores.routineStateController.routineList[index],
                    onPressDelete: onPressDelete,
                    onPressEdit: onPressEdit);
              },
            ));
          }),
          loadingFotter(routineLoading, isRefresh,
              stores.routineStateController.routineList.isNotEmpty),
        ]));
  }
}
