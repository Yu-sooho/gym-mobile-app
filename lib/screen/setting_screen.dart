import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/source/localization/localization_controller.dart';
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
                    rightText: '',
                    onPressLeft: () => {Navigator.of(context).pop()}),
              ]),
            )));
  }
}
