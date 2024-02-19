import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineListItem extends StatefulWidget {
  final Routine item;
  final Function(Routine item)? onPress;
  final Function(BuildContext context, Routine item)? onPressDelete;
  final bool? isSelected;
  final bool? isCanSelected;
  final bool disabledDelete;
  final bool disabledButton;
  final bool? isVisabled;

  RoutineListItem({
    required this.item,
    this.onPress,
    this.onPressDelete,
    this.isCanSelected,
    this.isSelected,
    this.disabledDelete = false,
    this.disabledButton = false,
    this.isVisabled = false,
    super.key,
  });

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RoutineListItem &&
        other.isSelected == isSelected &&
        other.disabledDelete == disabledDelete &&
        other.isCanSelected == isCanSelected &&
        other.item == item &&
        other.isVisabled == isVisabled;
  }

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      isSelected.hashCode ^
      disabledDelete.hashCode ^
      isCanSelected.hashCode ^
      item.hashCode ^
      isVisabled.hashCode;

  @override
  State<RoutineListItem> createState() => _RoutineListItem();
}

class _RoutineListItem extends State<RoutineListItem> {
  final Stores stores = Get.put(Stores());

  void onPressed(BuildContext context) {
    if (widget.disabledButton) return;
    if (widget.onPress != null) widget.onPress!(widget.item);
  }

  double isVisiableHeight = 0.0;
  double isVisiableArrowRotation = 0.25;
  double isVisiableOpacity = 0.0;
  Duration duration = Duration(milliseconds: 200);

  void onPressVisiable() {
    if (isVisiableArrowRotation == 0.25) {
      setState(() {
        isVisiableArrowRotation = -0.25;
        isVisiableHeight = 68.0;
        isVisiableOpacity = 1.0;
      });
    } else {
      setState(() {
        isVisiableArrowRotation = 0.25;
        isVisiableHeight = 0.0;
        isVisiableOpacity = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.isSelected ?? false;
    final bool isCanSelected = widget.isCanSelected ?? false;

    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () => onPressed(context),
      child: Container(
        width: stores.appStateController.logicalWidth.value,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: stores.colorController
                  .customColor()
                  .defaultBackground1
                  .withOpacity(0.8),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: const Offset(5, 7),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: stores.colorController.customColor().buttonActiveText,
        ),
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: Slidable(
            key: const ValueKey(0),
            enabled: !widget.disabledDelete,
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (BuildContext context) {
                    if (widget.onPressDelete != null) {
                      widget.onPressDelete!(context, widget.item);
                    }
                  },
                  backgroundColor:
                      stores.colorController.customColor().transparent,
                  foregroundColor:
                      stores.colorController.customColor().defaultBackground1,
                  icon: Icons.delete,
                  iconSize: 20,
                ),
              ],
            ),
            child: Container(
              width: stores.appStateController.logicalWidth.value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: stores.colorController.customColor().buttonActiveText,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 48,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(children: [
                        isCanSelected
                            ? Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(),
                                child: Align(
                                  child: isSelected
                                      ? Icon(
                                          Icons.check_box,
                                          color: stores.colorController
                                              .customColor()
                                              .defaultBackground1,
                                          size: 24,
                                        )
                                      : Icon(
                                          Icons.check_box_outline_blank_rounded,
                                          color: stores.colorController
                                              .customColor()
                                              .defaultBackground2,
                                          size: 24,
                                        ),
                                ))
                            : SizedBox(
                                width: 18,
                              ),
                        Text(widget.item.name,
                            style: stores.fontController
                                .customFont()
                                .bold14
                                .copyWith(
                                    color: stores.colorController
                                        .customColor()
                                        .defaultBackground1)),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                                onTap: onPressVisiable,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 18),
                                  child: AnimatedRotation(
                                    turns: isVisiableArrowRotation,
                                    duration: duration,
                                    child: Icon(
                                      Icons.arrow_right,
                                      color: stores.colorController
                                          .customColor()
                                          .defaultBackground1,
                                      size: 24,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  AnimatedContainer(
                      duration: duration,
                      height: isVisiableHeight,
                      child: Column(children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      '${stores.localizationController.localiztionRoutineAddScreen().exercise} : ',
                                      style: stores.fontController
                                          .customFont()
                                          .medium12
                                          .copyWith(
                                              color: stores.colorController
                                                  .customColor()
                                                  .defaultBackground1)),
                                  widget.item.exercises.isEmpty
                                      ? Expanded(
                                          child: SizedBox(
                                              child: Text('-',
                                                  style: stores.fontController
                                                      .customFont()
                                                      .medium12
                                                      .copyWith(
                                                          color: stores
                                                              .colorController
                                                              .customColor()
                                                              .defaultBackground1))))
                                      : Expanded(
                                          child: ListView.separated(
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                widget.item.exercises.length,
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    const SizedBox(
                                              width: 5,
                                            ),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Align(
                                                child: Text(
                                                    widget.item.exercises[index]
                                                        .name,
                                                    style: stores.fontController
                                                        .customFont()
                                                        .bold12
                                                        .copyWith(
                                                            color: stores
                                                                .colorController
                                                                .customColor()
                                                                .defaultBackground1)),
                                              );
                                            },
                                          ),
                                        )
                                ]),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        '${stores.localizationController.localiztionRoutineAddScreen().repeat} : ',
                                        style: stores.fontController
                                            .customFont()
                                            .medium12
                                            .copyWith(
                                                color: stores.colorController
                                                    .customColor()
                                                    .defaultBackground1),
                                      ),
                                      Text(
                                          '${widget.item.cycle}${stores.localizationController.localiztionRoutineAddScreen().repeatDes}',
                                          style: stores.fontController
                                              .customFont()
                                              .bold12
                                              .copyWith(
                                                  color: stores.colorController
                                                      .customColor()
                                                      .defaultBackground1)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        '${stores.localizationController.localiztionRoutineAddScreen().cycleDate} : ',
                                        style: stores.fontController
                                            .customFont()
                                            .medium12
                                            .copyWith(
                                                color: stores.colorController
                                                    .customColor()
                                                    .defaultBackground1),
                                      ),
                                      Text(
                                        '${widget.item.date}${stores.localizationController.localiztionRoutineAddScreen().cycleDes}',
                                        style: stores.fontController
                                            .customFont()
                                            .bold12
                                            .copyWith(
                                                color: stores.colorController
                                                    .customColor()
                                                    .defaultBackground1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
