import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExerciseListItem extends StatefulWidget {
  late final Exercise item;
  late final Function(Exercise item)? onPress;
  late final Function(BuildContext context, Exercise item)? onPressDelete;
  ExerciseListItem(
      {super.key, required this.item, this.onPress, this.onPressDelete});

  @override
  State<ExerciseListItem> createState() => _ExerciseListItem();
}

class _ExerciseListItem extends State<ExerciseListItem> {
  final Stores stores = Get.put(Stores());

  void onPress(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return (Container(
        height: 100,
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
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: stores.colorController.customColor().buttonActiveText),
        child: Slidable(
            key: const ValueKey(0),
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
                  foregroundColor:
                      stores.colorController.customColor().defaultBackground1,
                  icon: Icons.delete,
                  iconSize: 20,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.zero,
                  //   topRight: Radius.circular(20.0),
                  //   bottomLeft: Radius.zero,
                  //   bottomRight: Radius.circular(20.0),
                  // ),
                  // label: 'Save',
                ),
              ],
            ),
            child: Container(
              height: 100,
              width: stores.appStateController.logicalWidth.value,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: stores.colorController.customColor().buttonActiveText),
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(item.name),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    width: 340,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      primary: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: item.musclesId.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String? name = stores
                            .exerciseStateController.muscles
                            ?.firstWhere((element) =>
                                element.id == item.musclesId[index])
                            .name;
                        return (Text('$name'));
                      },
                    ),
                  )
                ],
              ),
            ))));
  }
}
