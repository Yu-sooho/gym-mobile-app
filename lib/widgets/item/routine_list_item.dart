import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/stores/styles/color_controller.dart';

class RoutineListItem extends StatefulWidget {
  RoutineListItem({super.key});

  @override
  State<RoutineListItem> createState() => _RoutineListItem();
}

class _RoutineListItem extends State<RoutineListItem> {
  final Stores stores = Get.put(Stores());
  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
          color: stores.colorController.customColor().transparent),
      child: Column(children: [Text('123')]),
    ));
  }
}
