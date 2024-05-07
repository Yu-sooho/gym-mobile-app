import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/screens/home/routine/package_routine.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineSettingScreen extends StatefulWidget {
  final String? docName;

  RoutineSettingScreen({super.key, this.docName});

  @override
  State<RoutineSettingScreen> createState() => _RoutineSettingScreenState();
}

class _RoutineSettingScreenState extends State<RoutineSettingScreen> {
  Stores stores = Stores();
  NetworkProviders networkProviders = NetworkProviders();
  List executionDates = [];
  Routine? routine;
  bool isRefreshing = true;
  bool isLoading = false;

  Future onRefresh() async {
    setState(() {
      routine = null;
      isRefreshing = true;
    });
    final result = await networkProviders.routineProvider
        .getRoutineByDocName(widget.docName!);
    setState(() {
      routine = result;
      isRefreshing = false;
    });
  }

  Future getRoutine() async {
    if (widget.docName != null) {
      setState(() {
        isLoading = true;
      });
      final result = await networkProviders.routineProvider
          .getRoutineByDocName(widget.docName!);
      if (!context.mounted) return;
      setState(() {
        routine = result;
        isLoading = false;
        isRefreshing = false;
      });
    }
  }

  init() async {
    await getRoutine();
  }

  @override
  void initState() {
    super.initState();
    init();
    // if (widget.routine?.executionDate != null) {
    //   executionDates = widget.routine!.executionDate!;
    // }
  }

  onPressComplete(Exercise? exercise) async {
    // final docName = widget.routine?.docName;
    // print(widget.routine.toString());
    // if (docName == null) return;
    // try {
    //   DateTime now = DateTime.now();
    //   DateTime targetDateOnly = DateTime(now.year, now.month, now.day);
    //   Timestamp executionDate = Timestamp.fromDate(targetDateOnly);
    //   final execution = executionDates.where((element) {
    //     DateTime targetDate =
    //         DateTime(element.year, element.month, element.day);
    //     return targetDateOnly == targetDate;
    //   });
    //   if (execution.isNotEmpty) {
    //     stores.appStateController.showToast('이미 완료된 운동입니다');
    //     return;
    //   }

    //   setState(() {
    //     executionDates.add(targetDateOnly);
    //   });
    //   stores.appStateController.setIsLoading(true, context);
    //   await networkProviders.routineProvider.putCustomRoutine({
    //     'executionDate': [executionDate]
    //   }, docName);

    //   final result =
    //       await networkProviders.routineProvider.getRoutineByDocName(docName);
    //   if (result != null) {
    //     final temp = stores.routineStateController.routineList
    //         .indexWhere((element) => element.id == widget.routine?.id);
    //     if (temp >= 0) {
    //       stores.routineStateController.routineList[temp] = result;
    //     }
    //   }
    //   if (!context.mounted) return;
    //   stores.appStateController.setIsLoading(false, context);
    // } catch (error) {
    //   print('routine_add_screen onPressEdit error:$error');
    //   stores.appStateController.setIsLoading(false, context);
    //   stores.appStateController.showToast(stores.localizationController
    //       .localiztionComponentError()
    //       .networkError);
    // }
  }

  onPressStart(Exercise? exercise) {}

  void addRoutineInMap(Routine newRoutine) {
    stores.routineStateController.addRoutineInMap(newRoutine);
  }

  void updateRoutineInMap(Routine routineToUpdate) {
    stores.routineStateController.updateRoutineInMap(routineToUpdate);
  }

  onPressAdd() {
    if (routine != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => RoutineAddScreen(
                  routine: routine,
                  updateRoutineInMap: updateRoutineInMap,
                  addRoutineInMap: addRoutineInMap,
                  onRefresh: onRefresh,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return (SafeAreaView(
      onRefresh: onRefresh,
      physics: AlwaysScrollableScrollPhysics(),
      title: routine?.name ?? '',
      children: [
        isRefreshing
            ? SizedBox()
            : routine?.exercises == null || routine!.exercises.isEmpty
                ? Column(children: [
                    Container(
                      height: 240,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(),
                      child: Text(
                        stores.localizationController
                            .localiztionComponentError()
                            .noData,
                        style: stores.fontController.customFont().medium12,
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 360),
                        child: CustomButton(
                            onPress: onPressAdd,
                            child: Text(
                              stores.localizationController
                                  .localiztionRoutineSettingScreen()
                                  .addExercise,
                              style:
                                  stores.fontController.customFont().medium12,
                            )),
                      ),
                    ),
                  ])
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ShaderMask(
                        shaderCallback: (Rect rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              stores.colorController
                                  .customColor()
                                  .defaultBackground1,
                              Colors.transparent,
                              Colors.transparent,
                              stores.colorController
                                  .customColor()
                                  .defaultBackground2,
                            ],
                            stops: [0.0, 0.01, 0.95, 1.0],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: routine?.exercises.length,
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return (Padding(
                                  padding: EdgeInsets.only(top: 24),
                                  child: exerciseItem(
                                    routine?.exercises[index],
                                    onPressStart,
                                    onPressComplete,
                                  )));
                            }
                            return (exerciseItem(
                              routine?.exercises[index],
                              onPressStart,
                              onPressComplete,
                            ));
                          },
                        )),
                  )
      ],
    ));
  }
}

Widget exerciseItem(
    Exercise? exercise,
    Function(Exercise? exercise)? onPressStart,
    Function(Exercise? exercise)? onPressComplete) {
  Stores stores = Stores();
  return (Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: stores.colorController.customColor().buttonDefaultColor),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Column(children: [
        Text(exercise?.name ?? '',
            style: stores.fontController.customFont().bold14.copyWith(
                color: stores.colorController.customColor().buttonActiveText)),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    stores.localizationController
                        .localiztionExerciseItem()
                        .lastSet,
                    style: stores.fontController.customFont().bold12.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      exercise?.count ?? '-',
                      style: stores.fontController.customFont().bold14.copyWith(
                          color: stores.colorController
                              .customColor()
                              .buttonActiveText),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  stores.localizationController
                      .localiztionExerciseItem()
                      .nowSet,
                  style: stores.fontController.customFont().bold12.copyWith(
                      color: stores.colorController
                          .customColor()
                          .buttonActiveText),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    '10',
                    style: stores.fontController.customFont().bold14.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
                  ),
                ),
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Text(
                  stores.localizationController
                      .localiztionExerciseItem()
                      .targetSet,
                  style: stores.fontController.customFont().bold12.copyWith(
                      color: stores.colorController
                          .customColor()
                          .buttonActiveText),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    exercise?.targetCount ?? '-',
                    style: stores.fontController.customFont().bold14.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
                  ),
                ),
              ],
            ))
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    stores.localizationController
                        .localiztionExerciseItem()
                        .lastWeight,
                    style: stores.fontController.customFont().bold12.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      exercise?.weight ?? '',
                      style: stores.fontController.customFont().bold14.copyWith(
                          color: stores.colorController
                              .customColor()
                              .buttonActiveText),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    stores.localizationController
                        .localiztionExerciseItem()
                        .nowWeight,
                    style: stores.fontController.customFont().bold12.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      '123',
                      style: stores.fontController.customFont().bold14.copyWith(
                          color: stores.colorController
                              .customColor()
                              .buttonActiveText),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    stores.localizationController
                        .localiztionExerciseItem()
                        .targetWeight,
                    style: stores.fontController.customFont().bold12.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      exercise?.targetWeight ?? '',
                      style: stores.fontController.customFont().bold14.copyWith(
                          color: stores.colorController
                              .customColor()
                              .buttonActiveText),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: SizedBox(
                  height: 16,
                  child: Text(
                    stores.localizationController
                        .localiztionRoutineSettingScreen()
                        .part,
                    style: stores.fontController.customFont().bold12.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
                  )),
            ),
            Expanded(
              child: SizedBox(
                height: 16,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // 여기에 추가
                  primary: true,
                  shrinkWrap: true,
                  itemCount: exercise?.musclesNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (Text(
                      exercise?.musclesNames[index] ?? '',
                      style: stores.fontController.customFont().bold12.copyWith(
                          color: stores.colorController
                              .customColor()
                              .buttonActiveText),
                    ));
                  },
                ),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  child: InkWell(
                    onTap: () => {
                      if (onPressStart != null) {onPressStart(exercise)}
                    },
                    child: (Text(
                        stores.localizationController
                            .localiztionExerciseItem()
                            .exerciseStart,
                        style: stores.fontController
                            .customFont()
                            .bold14
                            .copyWith(
                                color: stores.colorController
                                    .customColor()
                                    .buttonActiveText))),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  child: InkWell(
                    onTap: () => {
                      if (onPressComplete != null) {onPressComplete(exercise)}
                    },
                    child: (Text(
                        stores.localizationController
                            .localiztionExerciseItem()
                            .exerciseFinish,
                        style: stores.fontController
                            .customFont()
                            .bold14
                            .copyWith(
                                color: stores.colorController
                                    .customColor()
                                    .buttonActiveText))),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    ),
  ));
}
