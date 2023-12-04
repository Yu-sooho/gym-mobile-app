import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class ExerciseAddItem extends StatefulWidget {
  ExerciseAddItem({super.key});

  @override
  State<ExerciseAddItem> createState() => _ExerciseAddItem();
}

class _ExerciseAddItem extends State<ExerciseAddItem> {
  final Stores stores = Get.put(Stores());
  var title = '';

  onChangedTitle(String value) {}

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
          color: stores.colorController.customColor().transparent),
    ));
  }
}
