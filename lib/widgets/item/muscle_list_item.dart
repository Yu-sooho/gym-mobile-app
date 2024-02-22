import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MuscleListItem extends StatelessWidget {
  final Muscles item;
  final Function(Muscles item)? onPress;
  final Function(BuildContext context, Muscles item)? onPressDelete;
  final bool? isSelected;
  final bool? isCanSelected;
  final bool disabledDelete;

  MuscleListItem({
    required this.item,
    this.onPress,
    this.onPressDelete,
    this.disabledDelete = false,
    this.isSelected,
    this.isCanSelected,
    super.key,
  });

  final Stores stores = Get.put(Stores());

  void onPressed(BuildContext context) {
    if (onPress == null) return;
    onPress!(item);
  }

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MuscleListItem &&
        other.isSelected == isSelected &&
        other.isCanSelected == isCanSelected &&
        other.disabledDelete == disabledDelete &&
        other.item == item;
  }

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      isCanSelected.hashCode ^
      isSelected.hashCode ^
      disabledDelete.hashCode ^
      item.hashCode;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = this.isSelected ?? false;
    final bool isCanSelected = this.isCanSelected ?? false;

    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () => onPressed(context),
      child: Container(
        height: 48,
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
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: stores.colorController.customColor().deleteButtonColor,
        ),
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: Slidable(
            enabled: !disabledDelete,
            key: const ValueKey(0),
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
                      stores.colorController.customColor().buttonInActiveColor,
                  icon: Icons.delete,
                  iconSize: 20,
                ),
              ],
            ),
            child: Container(
              height: 48,
              width: stores.appStateController.logicalWidth.value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: stores.colorController.customColor().buttonDefaultColor,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
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
                                          .buttonActiveColor,
                                      size: 24,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank_rounded,
                                      color: stores.colorController
                                          .customColor()
                                          .buttonInActiveColor,
                                      size: 24,
                                    ),
                            ))
                        : SizedBox(
                            width: 18,
                          ),
                    SizedBox(
                      height: 48,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(item.name,
                            style: stores.fontController
                                .customFont()
                                .bold12
                                .copyWith(
                                    color: stores.colorController
                                        .customColor()
                                        .buttonActiveColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
