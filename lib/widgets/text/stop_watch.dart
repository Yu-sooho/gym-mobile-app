import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class CustomStopWatch extends StatefulWidget {
  final Function(Duration duration) rapButtonPressed;
  final Function() resetButtonPressed;
  CustomStopWatch(
      {super.key,
      required this.rapButtonPressed,
      required this.resetButtonPressed});

  @override
  State<CustomStopWatch> createState() => _CustomStopWatchState();
}

class _CustomStopWatchState extends State<CustomStopWatch> {
  Stores stores = Stores();
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startStopButtonPressed() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
        setState(() {});
      });
    }
  }

  void _resetButtonPressed() {
    _stopwatch.reset();
    widget.resetButtonPressed();
    setState(() {});
  }

  void _rapButtonPressed() {
    widget.rapButtonPressed(_stopwatch.elapsed);
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (_stopwatch.elapsed.inMinutes).toString().padLeft(2, '0'),
                  style: stores.fontController.customFont().bold40.copyWith(
                      color: stores.colorController
                          .customColor()
                          .defaultTextColor),
                ),
                Text(
                  ' : ',
                  style: stores.fontController.customFont().bold40.copyWith(
                      color: stores.colorController
                          .customColor()
                          .defaultTextColor),
                ),
                Text(
                  (_stopwatch.elapsed.inSeconds % 60)
                      .toString()
                      .padLeft(2, '0'),
                  style: stores.fontController.customFont().bold40.copyWith(
                      color: stores.colorController
                          .customColor()
                          .defaultTextColor),
                ),
                Text(
                  ' : ',
                  style: stores.fontController.customFont().bold40.copyWith(
                      color: stores.colorController
                          .customColor()
                          .defaultTextColor),
                ),
                Text(
                  (_stopwatch.elapsed.inMilliseconds % 1000)
                      .toString()
                      .padLeft(3, '0'),
                  style: stores.fontController.customFont().bold40.copyWith(
                      color: stores.colorController
                          .customColor()
                          .defaultTextColor),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomButton(
                  onPress: _startStopButtonPressed,
                  child: SizedBox(
                      width: 58,
                      height: 48,
                      child: Align(
                        child: Text(_stopwatch.isRunning ? 'Stop' : 'Start'),
                      )),
                ),
                SizedBox(
                  width: 20,
                  height: 48,
                ),
                CustomButton(
                  onPress: _resetButtonPressed,
                  child: SizedBox(
                      width: 58,
                      height: 48,
                      child: Align(child: Text('Reset'))),
                ),
                SizedBox(
                  width: 20,
                  height: 48,
                ),
                CustomButton(
                  onPress: _rapButtonPressed,
                  child: SizedBox(
                      width: 58, height: 48, child: Align(child: Text('Rap'))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
