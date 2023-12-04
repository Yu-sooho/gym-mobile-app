import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class ExerciseListItem extends StatefulWidget {
  ExerciseListItem({super.key});

  @override
  State<ExerciseListItem> createState() => _ExerciseListItem();
}

class _ExerciseListItem extends State<ExerciseListItem> {
  final Stores stores = Get.put(Stores());
  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
          color: stores.colorController.customColor().transparent),
      child: Column(children: []),
    ));
  }
}
