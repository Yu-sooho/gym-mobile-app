import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

@immutable
class HomeCalendar extends StatefulWidget {
  HomeCalendar({
    super.key,
  });

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  final Stores stores = Get.put(Stores());

  DateTime now = DateTime.now();
  DateTime last = DateTime(DateTime.now().year + 20, 12, 31);
  DateTime first = DateTime(DateTime.now().year - 20, 1, 1);

  DateTime showTableDate = DateTime.now();

  onPageChanged(DateTime dateTime) {
    setState(() {
      showTableDate = dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Stack(
      children: <Widget>[
        header(showTableDate),
        dayWeeks(),
        Padding(
          padding: EdgeInsets.only(top: 84),
          child: TableCalendar(
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
                selectedTextStyle: stores.fontController.customFont().bold12,
                outsideTextStyle: stores.fontController.customFont().regular12,
                weekendTextStyle: stores.fontController.customFont().medium12,
                holidayTextStyle: stores.fontController.customFont().medium12,
                defaultTextStyle: stores.fontController.customFont().medium12),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: last,
            focusedDay: showTableDate,
          ),
        )
      ],
    ));
  }
}

Widget header(DateTime date) {
  final Stores stores = Get.put(Stores());
  String formattedDate = DateFormat.yMMMd().format(date);
  return (SizedBox(
    height: 40,
    child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            formattedDate,
            style: stores.fontController.customFont().bold16,
          )
        ])),
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
