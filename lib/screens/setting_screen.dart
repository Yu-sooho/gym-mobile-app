import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final LocalizationController controller = Get.put(LocalizationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: SizedBox(
              child: Column(children: [
                CustomHeader(
                    title: controller.localiztionSettingScreen().title,
                    onPressLeft: () => {Navigator.of(context).pop()}),
              ]),
            )));
  }
}
