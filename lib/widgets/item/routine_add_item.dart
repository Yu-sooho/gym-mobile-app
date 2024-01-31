import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class RoutineAddItem extends StatefulWidget {
  final Duration? duration;
  final Curve? curve;

  RoutineAddItem({super.key, this.duration, this.curve});

  @override
  State<RoutineAddItem> createState() => _RoutineAddItemState();
}

class _RoutineAddItemState extends State<RoutineAddItem>
    with SingleTickerProviderStateMixin {
  Stores stores = Stores();
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  List<String> selectedExercises = ['벤치프레스', '스쿼트', '턱걸이'];

  @override
  void initState() {
    super.initState();
    final Duration duration = widget.duration ?? Duration(milliseconds: 250);
    final Curve curve = widget.curve ?? Curves.linear;
    _controller = AnimationController(vsync: this, duration: duration);
    _animation = CurvedAnimation(parent: _controller, curve: curve);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
              if (isExpanded) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('루틴설정'),
              AnimatedIcon(
                icon: AnimatedIcons.arrow_menu,
                progress: _animation,
              ),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: _animation,
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: '루틴 이름'),
                ),
                DropdownButton<String>(
                  value: '일주일에 한 번',
                  onChanged: (String? newValue) {
                    // 주기가 변경되었을 때의 처리 로직 추가
                  },
                  items: <String>[
                    '일주일에 한 번',
                    '일주일에 두 번',
                    '일주일에 세 번',
                    // 다른 주기 옵션들을 추가하세요.
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showExercisePicker();
                  },
                  child: Text('운동 추가'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: selectedExercises
                      .map((exercise) => _buildExerciseItem(exercise))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseItem(String exercise) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(exercise),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                selectedExercises.remove(exercise);
              });
            },
          ),
        ],
      ),
    );
  }

  void onChangedItem(value) {}

  void onPressOk() {}

  onPressCancel() {}
  void _showExercisePicker() {
    List<String> exerciseList = ['벤치프레스', '스쿼트', '턱걸이']; // 원하는 운동 목록으로 수정하세요.

    stores.appStateController.showDialog(
        CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 32,
            onSelectedItemChanged: onChangedItem,
            children: List<Widget>.generate(exerciseList.length, (int index) {
              return Center(child: Center(child: Text(exerciseList[index])));
            })),
        context,
        isHaveButton: true,
        barrierDismissible: false,
        onPressOk: onPressOk,
        onPressCancel: onPressCancel);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: RoutineAddItem(),
    ),
  ));
}
