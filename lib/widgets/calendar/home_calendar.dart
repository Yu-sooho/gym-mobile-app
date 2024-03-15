import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/routine_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/utils/package_util.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

@immutable
class HomeCalendar extends StatefulWidget {
  final Function(DateTime?) onChangedSelectedDate;
  final Function(double)? onChangedSize;
  final Function(int)? onChangedLength;
  final Function(DateTime)? onPageChanged;
  final DateTime nowDate;

  HomeCalendar(
      {super.key,
      required this.onChangedSelectedDate,
      required this.nowDate,
      this.onChangedSize,
      this.onPageChanged,
      this.onChangedLength});

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  final Stores stores = Get.put(Stores());
  NetworkProviders networkProviders = NetworkProviders();

  DateTime now = DateTime.now();
  DateTime last = DateTime(DateTime.now().year + 20, 12, 31);
  DateTime first = DateTime(DateTime.now().year - 20, 1, 1);

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final GlobalKey calendarkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final result = await networkProviders.routineProvider
        .getRoutineInCalendar(year: DateTime.now().year);
    if (stores.routineStateController.calendarRoutineList.isEmpty &&
        result != null) {
      stores.routineStateController.calendarRoutineList.value = {
        '${DateTime.now().year}': result,
      };
      widget.onChangedSelectedDate(DateTime.now());
    }
  }

  onPageChanged(DateTime dateTime) {
    if (widget.onPageChanged != null) {
      widget.onPageChanged!(dateTime);
    }
    setState(() {
      focusedDay = dateTime;
    });
  }

  onPressDay(DateTime selected, DateTime focused) {
    if (selectedDay == selected ||
        (selected.month == DateTime.now().month &&
            selected.year == DateTime.now().year &&
            selected.day == DateTime.now().day)) {
      setState(() {
        selectedDay = null;
        widget.onChangedSelectedDate(null);
      });
      return;
    }
    setState(() {
      selectedDay = selected;
      widget.onChangedSelectedDate(selected);
    });
  }

  bool selectedDayPredicate(DateTime day) {
    if (day == selectedDay) {
      return true;
    }
    return false;
  }

  getRowLength(int length) {
    widget.onChangedLength?.call(length);
  }

  getPageHeight(double height) {
    widget.onChangedSize?.call(height);
  }

  Future onPressRefresh() async {
    setState(() {
      focusedDay = DateTime.now();
      selectedDay = DateTime.now();
      widget.onChangedSelectedDate(DateTime.now());
    });
    stores.appStateController.isLoading.value = true;
    final result = await networkProviders.routineProvider
        .getRoutineInCalendar(year: DateTime.now().year);
    if (result != null) {
      stores.routineStateController.calendarRoutineList.value = {
        '${DateTime.now().year}': result,
      };
    }
    stores.appStateController.isLoading.value = false;
  }

  Widget buildMarker(BuildContext context, DateTime day, List<dynamic> events) {
    return Obx(() {
      final List<Routine>? routines = stores.routineStateController
          .calendarRoutineList['${widget.nowDate.year}']?.list;

      if (routines == null) return SizedBox();

      List<Widget> markers = [];

      for (var routine in routines) {
        if (routine.routineCycle == null || routine.startDate == null) continue;

        final startDate = routine.startDate!.toDate();
        final DateTime? endDate =
            routine.endDate != null ? routine.endDate!.toDate() : null;
        final List<List<int?>> cycleArray =
            Math().convertedRecycle(routine.routineCycle!);

        if (cycleArray.isEmpty || cycleArray[0].isEmpty) continue;

        DateTime weekStart =
            startDate.subtract(Duration(days: startDate.weekday - 1));
        if (cycleArray[0].first! < startDate.weekday - 1) {
          weekStart = weekStart.add(Duration(days: 7));
        }

        int weeksSinceStart = ((day.difference(weekStart).inDays) / 7).floor();
        if (weeksSinceStart < 0 || (endDate != null && day.isAfter(endDate))) {
          continue;
        }

        int cycleWeekIndex = weeksSinceStart % cycleArray.length;
        int dayOfWeekIndex = day.weekday - 1;

        if (cycleArray[cycleWeekIndex].contains(dayOfWeekIndex)) {
          markers.add(Container(
            margin: EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: stringToColor(routine.color)),
            width: 7,
            height: 7,
          ));
        }
      }

      return Row(mainAxisSize: MainAxisSize.min, children: markers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Stack(
      children: <Widget>[
        header(focusedDay, onPressRefresh),
        dayWeeks(),
        Padding(
          key: calendarkey,
          padding: EdgeInsets.only(top: 84),
          child: TableCalendar(
            formatAnimationDuration: Duration(milliseconds: 250),
            formatAnimationCurve: Curves.linear,
            getRowLength: getRowLength,
            getPageHeight: getPageHeight,
            onDaySelected: onPressDay,
            selectedDayPredicate: selectedDayPredicate,
            onPageChanged: onPageChanged,
            headerVisible: false,
            daysOfWeekVisible: false,
            calendarBuilders: CalendarBuilders(
              markerBuilder: buildMarker,
            ),
            calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: Colors.blue, // 점의 색상 설정
                  shape: BoxShape.circle, // 점의 모양 설정
                ),
                todayDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: stores.colorController
                        .customColor()
                        .defaultBackground2),
                todayTextStyle: stores.fontController.customFont().bold12,
                selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: stores.colorController
                        .customColor()
                        .defaultBackground2),
                selectedTextStyle: stores.fontController.customFont().bold12,
                outsideTextStyle: stores.fontController.customFont().regular12,
                weekendTextStyle: stores.fontController.customFont().medium12,
                holidayTextStyle: stores.fontController.customFont().medium12,
                defaultTextStyle: stores.fontController.customFont().medium12),
            firstDay: first,
            lastDay: last,
            focusedDay: focusedDay,
          ),
        )
      ],
    ));
  }
}

Widget header(DateTime date, Function onPressRefresh) {
  final Stores stores = Get.put(Stores());
  String formattedDate = DateFormat("yyyy년 MM월").format(date);

  return (Row(
    children: [
      SizedBox(
        height: 40,
        child: Padding(
            padding: EdgeInsets.only(left: 16),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                formattedDate,
                style: stores.fontController.customFont().bold16,
              )
            ])),
      ),
      CustomButton(
          onPress: () => {onPressRefresh()},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: SizedBox(
              height: 32,
              width: 64,
              child: Padding(
                padding: EdgeInsets.only(left: 6),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.refresh,
                      color: stores.colorController
                          .customColor()
                          .bottomTabBarActiveItem,
                      size: 20,
                    )),
              )))
    ],
  ));
}

Widget dayWeeks() {
  final Stores stores = Get.put(Stores());

  Widget dayText(String text) {
    return (SizedBox(
        width: stores.appStateController.logicalWidth / 7,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: stores.fontController.customFont().bold12,
          ),
        )));
  }

  return (Container(
      height: 84,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          dayText('SUN'),
          dayText('MON'),
          dayText('TUE'),
          dayText('WED'),
          dayText('THU'),
          dayText('FRI'),
          dayText('SAT'),
        ]),
      )));
}
