import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final _controller = ScrollController();
  Stores stores = Stores();

  Future onRefresh() async {
    print(123);
  }

  onChangedSelectedDate(DateTime? selected) {
    print(selected);
  }

  double calendarMinHeight = 312 + 26;
  double calendarMaxHeight = 364 + 26;
  double calendarHeight = 0;

  onChangedLength(int length) {
    // print(length * 52);
  }

  onChangedSize(double height) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        calendarHeight = height + 52 + 26;
        print('$calendarMinHeight $calendarMaxHeight $calendarHeight');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (TabAreaView(
        minHeaderSize: calendarMinHeight,
        maxHeaderSize: calendarMaxHeight,
        headerSize: calendarHeight,
        openDuration: Duration(microseconds: 0),
        closeDuration: Duration(microseconds: 200000),
        // openDelay: Duration(microseconds: 250),
        // closeDelay: Duration(microseconds: 250),
        onRefresh: onRefresh,
        scrollController: _controller,
        paddingTop: 24,
        header: HomeCalendar(
          onChangedSelectedDate: onChangedSelectedDate,
          onChangedSize: onChangedSize,
          onChangedLength: onChangedLength,
        ),
        children: [
          calendarHeight > 0
              ? Column(
                  children: [
                    RoutineListItem(),
                    RoutineListItem(),
                    RoutineListItem()
                  ],
                )
              : SizedBox()
        ]));
  }
}
