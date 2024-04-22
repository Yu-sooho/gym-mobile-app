import 'package:flutter/material.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineSettingScreen extends StatefulWidget {
  final Routine? routine;

  RoutineSettingScreen({super.key, this.routine});

  @override
  State<RoutineSettingScreen> createState() => _RoutineSettingScreenState();
}

class _RoutineSettingScreenState extends State<RoutineSettingScreen> {
  Stores stores = Stores();

  @override
  void initState() {
    super.initState();
    print(widget.routine?.exercises[0].name);
  }

  onPressComplete(Exercise? exercise) {}

  onPressStart(Exercise? exercise) {}

  @override
  Widget build(BuildContext context) {
    return (SafeAreaView(
      title: widget.routine?.name ?? '',
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: ListView.builder(
              primary: true,
              shrinkWrap: true,
              itemCount: widget.routine?.exercises.length,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              itemBuilder: (BuildContext context, int index) {
                return (exerciseItem(
                  widget.routine?.exercises[index],
                  onPressStart,
                  onPressComplete,
                ));
              },
            ),
          ),
        ),
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
                  Text(
                    exercise?.count ?? '-',
                    style: stores.fontController.customFont().bold14.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
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
                Text(
                  '10',
                  style: stores.fontController.customFont().bold14.copyWith(
                      color: stores.colorController
                          .customColor()
                          .buttonActiveText),
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
                Text(
                  exercise?.targetCount ?? '-',
                  style: stores.fontController.customFont().bold14.copyWith(
                      color: stores.colorController
                          .customColor()
                          .buttonActiveText),
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
                  Text(
                    exercise?.weight ?? '',
                    style: stores.fontController.customFont().bold14.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
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
                  Text(
                    '123',
                    style: stores.fontController.customFont().bold14.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
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
                  Text(
                    exercise?.targetWeight ?? '',
                    style: stores.fontController.customFont().bold14.copyWith(
                        color: stores.colorController
                            .customColor()
                            .buttonActiveText),
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
