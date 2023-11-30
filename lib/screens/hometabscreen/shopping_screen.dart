import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ShoppingScreen extends StatefulWidget {
  ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final AppStateController appStateController = Get.put(AppStateController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
  @override
  Widget build(BuildContext context) {
    return (TabAreaView(paddingTop: 24, children: []));
  }
}
