import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/routine_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/screens/home/routine/package_routine.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/utils/package_util.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Stores stores = Stores();
  NetworkProviders networkProviders = NetworkProviders();

  final _controller = ScrollController();
  DateTime? selectedDay;
  DateTime nowDate = DateTime.now();
  bool routineLoading = false;
  late List<Routine> routinesForDay;

  Future onRefresh() async {
    setState(() {
      selectedDay = null;
      routinesForDay = findRoutinesForSelectedDay(DateTime.now());
    });
  }

  onChangedSelectedDate(DateTime? selected) {
    routinesForDay = findRoutinesForSelectedDay(selected ?? DateTime.now());
    setState(() {
      selectedDay = selected;
    });
  }

  final double insetSize = 28;
  final double dateTextSize = 64;
  double calendarMinHeight = 312;
  double calendarMaxHeight = 364;
  double calendarHeight = 0;

  @override
  void initState() {
    super.initState();
    init();
    calendarMinHeight = calendarMinHeight + insetSize + dateTextSize;
    calendarMaxHeight = calendarMaxHeight + insetSize + dateTextSize;
  }

  init() {
    setState(() {
      routinesForDay = findRoutinesForSelectedDay(DateTime.now());
    });
  }

  onChangedLength(int length) {
    // print(length * 52);
  }

  onChangedSize(double height) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        calendarHeight = height + 52 + 28 + 40;
      });
    });
  }

  onPressAdd() {}

  onPageChanged(DateTime dateTime) {
    // print(dateTime);
  }

  List<Routine> findRoutinesForSelectedDay(DateTime selectedDay) {
    final List<Routine>? routines = stores.routineStateController
        .calendarRoutineList['${selectedDay.year}']?.list;

    if (routines == null) return [];

    List<Routine> routinesForSelectedDay = [];

    for (var routine in routines) {
      if (routine.routineCycle == null || routine.startDate == null) continue;

      final startDate = routine.startDate!.toDate();
      final DateTime? endDate =
          routine.endDate != null ? routine.endDate!.toDate() : null;
      final List<List<int?>> cycleArray =
          Math().convertedRecycle(routine.routineCycle!);

      if (cycleArray.isEmpty) continue;

      DateTime weekStart =
          startDate.subtract(Duration(days: startDate.weekday - 1));
      if (cycleArray[0].first! < startDate.weekday - 1) {
        weekStart = weekStart.add(Duration(days: 7));
      }

      int weeksSinceStart =
          ((selectedDay.difference(weekStart).inDays) / 7).floor();
      if (weeksSinceStart < 0 ||
          (endDate != null && selectedDay.isAfter(endDate))) continue;

      int cycleWeekIndex = weeksSinceStart % cycleArray.length;
      int dayOfWeekIndex = selectedDay.weekday - 1;

      if (cycleArray[cycleWeekIndex].contains(dayOfWeekIndex)) {
        routinesForSelectedDay.add(routine);
      }
    }

    return routinesForSelectedDay;
  }

  void updateRoutineInMap(Routine routineToUpdate) {
    for (String key in stores.routineStateController.calendarRoutineList.keys) {
      var routineList = stores.routineStateController.calendarRoutineList[key];
      var index = routineList?.list
          .indexWhere((routine) => routine.id == routineToUpdate.id);
      if (index != null && index != -1) {
        routineList?.list[index] = routineToUpdate;
        if (routineList != null) {
          stores.routineStateController.calendarRoutineList[key] = routineList;
        }
      }
    }

    int routineListIndex = stores.routineStateController.routineList
        .indexWhere((routine) => routine.id == routineToUpdate.id);
    if (routineListIndex != -1) {
      stores.routineStateController.routineList[routineListIndex] =
          routineToUpdate;
    }

    int dayIndex = routinesForDay
        .indexWhere((routine) => routine.id == routineToUpdate.id);
    if (dayIndex != -1) {
      setState(() {
        routinesForDay[dayIndex] = routineToUpdate;
      });
    }
  }

  void onPressEdit(BuildContext context, Routine routine, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => RoutineAddScreen(
                routine: routine,
                updateRoutineInMap: updateRoutineInMap,
              )),
    );
  }

  void deleteRoutineFromMap(
      RxMap<String, RoutineList> routineMap, Routine routineToDelete) {
    for (String key in routineMap.keys) {
      var routineList = routineMap[key];
      routineList?.list
          .removeWhere((routine) => routine.id == routineToDelete.id);
      if (routineList != null) {
        routineMap[key] = routineList;
      }
    }

    stores.routineStateController.routineList
        .removeWhere((routine) => routine.id == routineToDelete.id);
    setState(() {
      routinesForDay.removeWhere((routine) => routine.id == routineToDelete.id);
    });
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

                deleteRoutineFromMap(
                    stores.routineStateController.calendarRoutineList, routine);
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

  @override
  Widget build(BuildContext context) {
    return (ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              stores.colorController.customColor().defaultBackground1,
              Colors.transparent,
              Colors.transparent,
              stores.colorController.customColor().defaultBackground2,
            ],
            stops: [0.0, 0.01, 0.95, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: Scaffold(
            backgroundColor: stores.colorController.customColor().transparent,
            body: TabAreaView(
                minHeaderSize: calendarMinHeight,
                maxHeaderSize: calendarMaxHeight,
                headerSize: calendarHeight,
                openDuration: Duration(microseconds: 0),
                closeDuration: Duration(microseconds: 200000),
                onRefresh: onRefresh,
                scrollController: _controller,
                header: Column(
                  children: [
                    HomeCalendar(
                      onChangedSelectedDate: onChangedSelectedDate,
                      onChangedSize: onChangedSize,
                      onChangedLength: onChangedLength,
                      onPageChanged: onPageChanged,
                      nowDate: nowDate,
                    ),
                    header(selectedDay ?? DateTime.now(), dateTextSize),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: routineAddButton(onPressAdd),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
                children: [
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: routinesForDay.length,
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return RoutineListItem(
                          index: index,
                          item: routinesForDay[index],
                          onPressDelete: onPressDelete,
                          onPressEdit: onPressEdit);
                    },
                  ),
                ]))));
  }
}

Widget routineAddButton(Function() onPress) {
  Stores stores = Stores();
  return (InkWell(
    onTap: onPress,
    child: Container(
        height: 48,
        width: stores.appStateController.logicalWidth.value,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: stores.colorController
                  .customColor()
                  .buttonShadowColor
                  .withOpacity(0.8),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: const Offset(5, 7),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: stores.colorController.customColor().deleteButtonColor,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                stores.localizationController
                    .localiztionComponentButton()
                    .addToday,
                style: stores.fontController.customFont().bold12.copyWith(
                    color:
                        stores.colorController.customColor().buttonActiveText),
              ),
              Icon(
                Icons.add,
                color: stores.colorController.customColor().buttonActiveColor,
                size: 20,
              ),
            ],
          ),
        )),
  ));
}

Widget header(DateTime date, double size) {
  final Stores stores = Get.put(Stores());
  String formattedDate = DateFormat("yyyy년 MM월 dd일").format(date);
  return (SizedBox(
    height: size,
    child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            formattedDate,
            style: stores.fontController.customFont().medium14,
          )
        ])),
  ));
}
