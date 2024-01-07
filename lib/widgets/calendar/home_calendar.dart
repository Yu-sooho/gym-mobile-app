import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

@immutable
class HomeCalendar extends StatefulWidget {
  final Function(DateTime?) onChangedSelectedDate;
  final Function(double)? onChangedSize;
  final Function(int)? onChangedLength;
  HomeCalendar(
      {super.key,
      required this.onChangedSelectedDate,
      this.onChangedSize,
      this.onChangedLength});

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  final Stores stores = Get.put(Stores());

  DateTime now = DateTime.now();
  DateTime last = DateTime(DateTime.now().year + 20, 12, 31);
  DateTime first = DateTime(DateTime.now().year - 20, 1, 1);

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final GlobalKey calendarkey = GlobalKey();

  onPageChanged(DateTime dateTime) {
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
    return null;
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
            calendarStyle: CalendarStyle(
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
