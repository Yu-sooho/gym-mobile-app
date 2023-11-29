import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class RoutineAddItem extends StatefulWidget {
  RoutineAddItem({super.key});

  @override
  State<RoutineAddItem> createState() => _RoutineAddItem();
}

class _RoutineAddItem extends State<RoutineAddItem> {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration:
          BoxDecoration(color: colorController.customColor().transparent),
      child: Column(children: [Text('123')]),
    ));
  }
}
