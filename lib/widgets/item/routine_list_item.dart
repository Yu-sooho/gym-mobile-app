import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class RoutineListItem extends StatefulWidget {
  RoutineListItem({super.key});

  @override
  State<RoutineListItem> createState() => _RoutineListItem();
}

class _RoutineListItem extends State<RoutineListItem> {
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
