import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class ExerciseListItem extends StatefulWidget {
  late final Exercise item;
  ExerciseListItem({super.key, required this.item});

  @override
  State<ExerciseListItem> createState() => _ExerciseListItem();
}

class _ExerciseListItem extends State<ExerciseListItem> {
  final Stores stores = Get.put(Stores());
  @override
  Widget build(BuildContext context) {
    return (Container(
      height: 100,
      width: stores.appStateController.logicalWidth.value - 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: stores.colorController.customColor().buttonActiveText),
      child: Column(children: [
        SizedBox(
          width: stores.appStateController.logicalWidth.value - 20,
        )
      ]),
    ));
  }
}
