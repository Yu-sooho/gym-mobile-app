import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineCycleScreen extends StatefulWidget {
  final Function(BuildContext context, List<List> selected) onPress;
  final List<List>? initRoutine;
  RoutineCycleScreen({super.key, required this.onPress, this.initRoutine});
  @override
  State<RoutineCycleScreen> createState() => _RoutineCycleScreen();
}

class _RoutineCycleScreen extends State<RoutineCycleScreen> {
  Stores stores = Stores();
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose(); // 컨트롤러 해제
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initRoutine != null) {
      setState(() {
        selected = widget.initRoutine!;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_controller.hasClients) {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  onPressDay(int week, int day) {
    setState(() {
      if (selected[week].contains(day)) {
        selected[week].remove(day);
      } else {
        selected[week].add(day);
      }
    });
  }

  int numberWeek = 1;
  List<List> selected = [[]];

  onPressAdd() {
    setState(() {
      selected.add([]);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    onPressSave() {
      widget.onPress(context, selected);
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 최소 크기로 설정
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '루틴 주기',
                  style: stores.fontController.customFont().bold14.copyWith(
                      color: stores.colorController
                          .customColor()
                          .defaultBackground1),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                      onPress: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        size: 20,
                      )),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text('루틴 시행 요일을 선택하세요',
                style: stores.fontController.customFont().medium12.copyWith(
                    color: stores.colorController
                        .customColor()
                        .defaultBackground2)),
            SizedBox(
              height: 10,
            ),
            ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300),
                child: ListView.separated(
                  controller: _controller,
                  shrinkWrap: true,
                  itemCount: selected.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (BuildContext context, int index) {
                    return HorizontalList(
                        key: ValueKey('${index}_${selected[index]}'),
                        week: index,
                        selected: selected[index],
                        onPress: onPressDay,
                        stores: stores);
                  },
                )),
            SizedBox(
              height: 12,
            ),
            Align(
                alignment: Alignment.center,
                child: CustomButton(
                    onPress: onPressAdd,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: stores.colorController
                              .customColor()
                              .buttonActiveColor),
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: stores.colorController
                            .customColor()
                            .buttonDefaultColor,
                      ),
                    ))),
            Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                    onPress: onPressSave,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Container(
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          width: 68,
                          height: 32,
                          child: Text(
                            '완료',
                            style: stores.fontController
                                .customFont()
                                .bold12
                                .copyWith(
                                    color: stores.colorController
                                        .customColor()
                                        .buttonActiveColor),
                          )),
                    ))),
          ],
        ),
      ),
    );
  }
}

class HorizontalList extends StatelessWidget {
  final int week;
  final List selected;
  final Function(int, int) onPress;
  final Stores stores;

  const HorizontalList({
    super.key,
    required this.week,
    required this.selected,
    required this.onPress,
    required this.stores,
  });

  @override
  Widget build(BuildContext context) {
    final data = ['월', '화', '수', '목', '금', '토', '일'];
    print(selected);
    return (SizedBox(
      height: 54,
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          child: Text('${week + 1}주차',
              style: stores.fontController.customFont().bold12.copyWith(
                  color:
                      stores.colorController.customColor().defaultBackground1)),
        ),
        SizedBox(
          height: 6,
        ),
        Expanded(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 6),
            itemBuilder: (BuildContext context, int index) {
              final isSelected =
                  selected.firstWhereOrNull((element) => element == index);
              return Container(
                width: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected != null
                        ? stores.colorController.customColor().buttonActiveColor
                        : null),
                alignment: Alignment.center,
                child: CustomButton(
                    onPress: () => {onPress(week, index)},
                    child: Align(
                        child: Text(data[index],
                            style: stores.fontController
                                .customFont()
                                .medium12
                                .copyWith(
                                    color: isSelected != null
                                        ? stores.colorController
                                            .customColor()
                                            .deleteButtonColor
                                        : stores.colorController
                                            .customColor()
                                            .defaultBackground1)))),
              );
            },
          ),
        ),
      ]),
    ));
  }
}
