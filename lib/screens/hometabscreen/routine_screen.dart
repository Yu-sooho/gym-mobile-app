import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineScreen extends StatefulWidget {
  RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  final AppStateController appStateController = Get.put(AppStateController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
  @override
  Widget build(BuildContext context) {
    return (TabAreaView(paddingTop: 24, children: [RoutineAddItem()]));
  }
}
