import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
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

  Future onRefresh() async {}

  onChangedSelectedDate(DateTime? selected) {
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
    calendarMinHeight = calendarMinHeight + insetSize + dateTextSize;
    calendarMaxHeight = calendarMaxHeight + insetSize + dateTextSize;
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

  @override
  Widget build(BuildContext context) {
    return (TabAreaView(
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
          ],
        ),
        children: [
          // RoutineListItem(),
          // RoutineListItem(),
          // RoutineListItem()
          // calendarHeight > 0
          //     ? Column(
          //         children: [
          //           RoutineListItem(),
          //           RoutineListItem(),
          //           RoutineListItem()
          //         ],
          //       )
          //     : SizedBox()
        ]));
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
