import 'package:flutter/material.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineColorScreen extends StatefulWidget {
  final Function(BuildContext context, Color selected) onPress;
  final Color? initColor;
  final Function()? onPressCustomColor;
  RoutineColorScreen(
      {super.key,
      required this.onPress,
      this.initColor,
      this.onPressCustomColor});
  @override
  State<RoutineColorScreen> createState() => _RoutineColorScreen();
}

class _RoutineColorScreen extends State<RoutineColorScreen> {
  Stores stores = Stores();
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  onPressColor(BuildContext context, Color selected) {
    widget.onPress(context, selected);
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      stores.localizationController
                          .localiztionRoutineAddScreen()
                          .colorTitle,
                      style: stores.fontController.customFont().bold14.copyWith(
                          color: stores.colorController
                              .customColor()
                              .defaultBackground1)),
                  widget.onPressCustomColor != null
                      ? CustomButton(
                          onPress: widget.onPressCustomColor,
                          child: Container(
                            padding: EdgeInsets.only(left: 24),
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: stores.colorController
                                  .customColor()
                                  .defaultBackground1,
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: SizedBox(
                  height: 132,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6, // 가로 방향으로 4개의 아이템을 표시
                      crossAxisSpacing: 6, // 가로 방향의 스페이스
                      mainAxisSpacing: 0, // 세로 방향의 스페이스
                      childAspectRatio: 1, // 아이템의 가로세로 비율
                    ),
                    itemCount: stores.colorController
                        .customColor()
                        .routineColors
                        .length, // 아이템의 총 갯수
                    itemBuilder: (context, index) {
                      // 각 아이템의 빌더
                      final isActive = stores.colorController
                              .customColor()
                              .routineColors[index] ==
                          widget.initColor;
                      return CustomButton(
                        onPress: () => onPressColor(
                            context,
                            stores.colorController
                                .customColor()
                                .routineColors[index]),
                        child: Align(
                            child: Container(
                          width: isActive ? 15 : 10,
                          height: isActive ? 15 : 10,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(isActive ? 15 : 10),
                            color: stores.colorController
                                .customColor()
                                .routineColors[index],
                          ),
                        )),
                      );
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
