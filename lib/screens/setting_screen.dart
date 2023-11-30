import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final Stores stores = Get.put(Stores());

  void onPressExerciseAlarm() {
    if (stores.appStateController.exerciseAlarm.value) {
      stores.appStateController.exerciseAlarm.value = false;
      stores.appStateController.showToast(stores.localizationController
          .localiztionSettingScreen()
          .exerciseAlarmCancelToast);
      return;
    }
    stores.appStateController.showToast(stores.localizationController
        .localiztionSettingScreen()
        .exerciseAlarmToast);
    stores.appStateController.exerciseAlarm.value = true;
  }

  void onPressScheduleAlarm() {
    if (stores.appStateController.scheduleAlarm.value) {
      stores.appStateController.scheduleAlarm.value = false;
      stores.appStateController.showToast(stores.localizationController
          .localiztionSettingScreen()
          .scheduleAlarmCancelToast);
      return;
    }
    stores.appStateController.showToast(stores.localizationController
        .localiztionSettingScreen()
        .scheduleAlarmToast);
    stores.appStateController.scheduleAlarm.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return safeAreaView(
        context, stores.localizationController.localiztionSettingScreen().title,
        children: [
          SizedBox(
            height: 24,
          ),
          Obx(() => customSwitchButton(context,
              value: stores.appStateController.exerciseAlarm.value,
              title: stores.localizationController
                  .localiztionSettingScreen()
                  .exerciseAlarm,
              onPress: onPressExerciseAlarm)),
          Obx(() => customSwitchButton(context,
              value: stores.appStateController.scheduleAlarm.value,
              title: stores.localizationController
                  .localiztionSettingScreen()
                  .scheduleAlarm,
              onPress: onPressScheduleAlarm)),
        ]);
  }
}
