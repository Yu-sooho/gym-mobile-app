import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RoutineListItem extends StatelessWidget {
  final Routine item;
  final Function(Routine item)? onPress;
  final Function(BuildContext context, Routine item)? onPressDelete;
  final bool? isSelected;
  final bool disabledDelete;
  final bool disabledButton;

  RoutineListItem({
    required this.item,
    this.onPress,
    this.onPressDelete,
    this.isSelected,
    this.disabledDelete = false,
    this.disabledButton = false,
    super.key,
  });

  final Stores stores = Get.put(Stores());

  void onPressed(BuildContext context) {
    if (disabledButton || onPress == null) return;
    onPress!(item);
  }

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RoutineListItem &&
        other.isSelected == isSelected &&
        other.disabledDelete == disabledDelete &&
        other.item == item;
  }

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      isSelected.hashCode ^ disabledDelete.hashCode ^ item.hashCode;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = this.isSelected ?? false;

    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () => onPressed(context),
      child: Container(
        height: 64,
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
            enabled: !disabledDelete,
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (BuildContext context) {
                    if (onPressDelete != null) onPressDelete!(context, item);
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
              height: 100,
              width: stores.appStateController.logicalWidth.value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: isSelected
                    ? stores.colorController.customColor().buttonActiveColor
                    : stores.colorController.customColor().buttonActiveText,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontFamily: stores.fontController
                              .customFont()
                              .bold12
                              .fontFamily,
                          fontWeight: stores.fontController
                              .customFont()
                              .bold12
                              .fontWeight,
                          fontSize: stores.fontController
                              .customFont()
                              .bold12
                              .fontSize,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    width: 340,
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: item.exercises.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          item.exercises[index].name,
                          style: TextStyle(
                            fontFamily: stores.fontController
                                .customFont()
                                .medium12
                                .fontFamily,
                            fontWeight: stores.fontController
                                .customFont()
                                .medium12
                                .fontWeight,
                            fontSize: stores.fontController
                                .customFont()
                                .medium12
                                .fontSize,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
