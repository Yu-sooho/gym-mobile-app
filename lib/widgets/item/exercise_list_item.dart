import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExerciseListItem extends StatefulWidget {
  late final Exercise item;
  late final Function(Exercise item)? onPress;
  late final Function(BuildContext context, Exercise item)? onPressDelete;
  final bool? isSelected;
  final bool disabledDelete;
  final bool disabledButton;

  ExerciseListItem(
      {super.key,
      required this.item,
      this.onPress,
      this.onPressDelete,
      this.isSelected,
      this.disabledDelete = false,
      this.disabledButton = false});

  @override
  State<ExerciseListItem> createState() => _ExerciseListItem();
}

class _ExerciseListItem extends State<ExerciseListItem> {
  final Stores stores = Get.put(Stores());

  void onPress(BuildContext context) {
    if (widget.disabledButton) return;
    widget.onPress!(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    bool? isSelected = widget.isSelected ?? false;

    return InkWell(
      onTap: () => onPress(context),
      child: (Container(
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
              color: stores.colorController.customColor().buttonActiveText),
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
                        onPressed: (BuildContext context) => {
                          if (widget.onPressDelete != null)
                            widget.onPressDelete!(context, item)
                        },
                        backgroundColor:
                            stores.colorController.customColor().transparent,
                        foregroundColor: stores.colorController
                            .customColor()
                            .defaultBackground1,
                        icon: Icons.delete,
                        iconSize: 20,
                      ),
                    ],
                  ),
                  child: Container(
                    width: stores.appStateController.logicalWidth.value,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: isSelected
                            ? stores.colorController
                                .customColor()
                                .buttonActiveColor
                            : stores.colorController
                                .customColor()
                                .buttonActiveText),
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
                                      .fontSize),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 170,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(widget.item.weight ?? ''),
                                )),
                            SizedBox(
                                width: 170,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(widget.item.targetWeight ?? ''),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                          width: 340,
                          child: ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: item.musclesNames.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              width: 5,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return (Text(
                                '${item.musclesNames[index]}',
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
                                        .fontSize),
                              ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ))))),
    );
  }
}
