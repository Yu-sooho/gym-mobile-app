import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/routine_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/screens/home/routine/package_routine.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:intl/intl.dart';

class ExerciseStartScreen extends StatefulWidget {
  ExerciseStartScreen({super.key});

  @override
  State<ExerciseStartScreen> createState() => _ExerciseStartScreenState();
}

class _ExerciseStartScreenState extends State<ExerciseStartScreen> {
  Stores stores = Stores();
  NetworkProviders networkProviders = NetworkProviders();
  List<Duration> rap = [];
  late List<Routine> routinesForDay;

  @override
  void initState() {
    super.initState();
    getRoutineToday();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getRoutineToday() {
    setState(() {
      routinesForDay = stores.routineStateController
          .findRoutinesForSelectedDay(DateTime.now());
    });
  }

  void rapButtonPressed(Duration duration) {
    setState(() {
      rap.add(duration);
      print(rap);
    });
  }

  void resetButtonPressed() {
    setState(() {
      rap.clear();
    });
  }

  void addRoutineInMap(Routine newRoutine) {
    stores.routineStateController.addRoutineInMap(newRoutine);
    getRoutineToday();
  }

  void updateRoutineInMap(Routine routineToUpdate) {
    stores.routineStateController.updateRoutineInMap(routineToUpdate);
    int dayIndex = routinesForDay
        .indexWhere((routine) => routine.id == routineToUpdate.id);
    if (dayIndex != -1) {
      setState(() {
        routinesForDay[dayIndex] = routineToUpdate;
      });
    }
  }

  void onPressAddRoutineToday() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => RoutineAddScreen(
                updateRoutineInMap: updateRoutineInMap,
                addRoutineInMap: addRoutineInMap,
                startDate: DateTime.now(),
              )),
    );
  }

  void onPressEdit(BuildContext context, Routine routine, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => RoutineAddScreen(
                routine: routine,
                updateRoutineInMap: updateRoutineInMap,
                addRoutineInMap: addRoutineInMap,
              )),
    );
  }

  void deleteRoutineFromMap(
      RxMap<String, RoutineList> routineMap, Routine routineToDelete) {
    stores.routineStateController
        .deleteRoutineFromMap(routineMap, routineToDelete);
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
                paddingTop: 24,
                header: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 32,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            DateFormat("yyyy년 MM월 dd일").format(DateTime.now()),
                            style: stores.fontController.customFont().medium14,
                          ),
                        ),
                      ),
                      CustomButton(
                          onPress: onPressAddRoutineToday,
                          child: SizedBox(
                            width: 32,
                            height: 32,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.add,
                                color: stores.colorController
                                    .customColor()
                                    .defaultTextColor,
                                size: 18,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                children: [
                  routinesForDay.isEmpty
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(16, 2, 16, 8),
                          child: routineAddButton(onPressAddRoutineToday),
                        )
                      : ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: routinesForDay.length,
                          padding: EdgeInsets.fromLTRB(16, 2, 16, 0),
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
