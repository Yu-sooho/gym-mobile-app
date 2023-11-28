import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final AppStateController appStateController = Get.put(AppStateController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
  @override
  Widget build(BuildContext context) {
    return (tabAreaView(context, paddingTop: 24, children: []));
  }
}
