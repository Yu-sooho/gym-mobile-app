import 'package:flutter/material.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class StopWatchScreen extends StatefulWidget {
  StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Stores stores = Stores();

  void rapButtonPressed(Duration duration) {
    setState(() {
      stores.exerciseStateController.rap.add(duration);
    });
  }

  void resetButtonPressed() {
    setState(() {
      stores.exerciseStateController.rap.clear();
    });
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
          body: Column(children: [
            CustomStopWatch(
                rapButtonPressed: rapButtonPressed,
                resetButtonPressed: resetButtonPressed,
                stopwatch: stores.exerciseStateController.stopwatch),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: stores.exerciseStateController.rap.length,
                itemExtent: 32,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 42,
                    width: 320,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 32,
                            child: Text(
                              '$index',
                              style: stores.fontController
                                  .customFont()
                                  .bold14
                                  .copyWith(
                                      color: stores.colorController
                                          .customColor()
                                          .defaultTextColor),
                            )),
                        Text(
                          (stores.exerciseStateController.rap[index].inMinutes)
                              .toString()
                              .padLeft(2, '0'),
                          style: stores.fontController
                              .customFont()
                              .medium14
                              .copyWith(
                                  color: stores.colorController
                                      .customColor()
                                      .defaultTextColor),
                        ),
                        Text(
                          ' : ',
                          style: stores.fontController
                              .customFont()
                              .medium14
                              .copyWith(
                                  color: stores.colorController
                                      .customColor()
                                      .defaultTextColor),
                        ),
                        Text(
                          (stores.exerciseStateController.rap[index].inSeconds %
                                  60)
                              .toString()
                              .padLeft(2, '0'),
                          style: stores.fontController
                              .customFont()
                              .medium14
                              .copyWith(
                                  color: stores.colorController
                                      .customColor()
                                      .defaultTextColor),
                        ),
                        Text(
                          ' : ',
                          style: stores.fontController
                              .customFont()
                              .medium14
                              .copyWith(
                                  color: stores.colorController
                                      .customColor()
                                      .defaultTextColor),
                        ),
                        Text(
                          (stores.exerciseStateController.rap[index]
                                      .inMilliseconds %
                                  1000)
                              .toString()
                              .padLeft(3, '0'),
                          style: stores.fontController
                              .customFont()
                              .medium14
                              .copyWith(
                                  color: stores.colorController
                                      .customColor()
                                      .defaultTextColor),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 12,
            )
          ]),
        )));
  }
}

Widget tabheader(Function(Duration duration) rapButtonPressed,
    Function() resetButtonPressed, stopwatch) {
  return (Column(
    children: [
      CustomStopWatch(
          rapButtonPressed: rapButtonPressed,
          resetButtonPressed: resetButtonPressed,
          stopwatch: stopwatch)
    ],
  ));
}
