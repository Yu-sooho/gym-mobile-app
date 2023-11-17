import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LocalizationController controller = Get.put(LocalizationController());
  final CustomColorController colorController =
      Get.put(CustomColorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: colorController.customColor().defaultBackground),
            child: SizedBox(
              child: Column(children: [
                CustomHeader(
                    title: controller.localiztionProfileScreen().title,
                    onPressLeft: () => {Navigator.of(context).pop()}),
              ]),
            )));
  }
}
