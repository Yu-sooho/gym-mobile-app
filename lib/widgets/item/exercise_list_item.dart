import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ExerciseListItem extends StatefulWidget {
  late final Exercise item;
  late final Function(Exercise item)? onPress;
  ExerciseListItem({super.key, required this.item, this.onPress});

  @override
  State<ExerciseListItem> createState() => _ExerciseListItem();
}

class _ExerciseListItem extends State<ExerciseListItem> {
  final Stores stores = Get.put(Stores());
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    // final Muscles? muscle = stores.exerciseStateController.muscles
    //     ?.firstWhere((element) => element.id == item.muscleId);

    return (Container(
      height: 100,
      width: stores.appStateController.logicalWidth.value - 200,
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
      child: CustomButton(
        onPress: () => {if (widget.onPress != null) widget.onPress!(item)},
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(children: [
              Row(
                children: [
                  Text(item.name),
                ],
              ),
              // Text('${muscle?.name}'),
              SizedBox(
                width: stores.appStateController.logicalWidth.value - 20,
              )
            ])),
      ),
    ));
  }
}
