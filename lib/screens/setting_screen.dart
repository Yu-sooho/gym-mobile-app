import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final AppStateController appStateController = Get.put(AppStateController());

  void onPressExerciseAlarm() {
    if (appStateController.exerciseAlarm.value) {
      appStateController.exerciseAlarm.value = false;
      appStateController.showToast(localizationController
          .localiztionSettingScreen()
          .exerciseAlarmCancelToast);
      return;
    }
    appStateController.showToast(
        localizationController.localiztionSettingScreen().exerciseAlarmToast);
    appStateController.exerciseAlarm.value = true;
  }

  void onPressScheduleAlarm() {
    if (appStateController.scheduleAlarm.value) {
      appStateController.scheduleAlarm.value = false;
      appStateController.showToast(localizationController
          .localiztionSettingScreen()
          .scheduleAlarmCancelToast);
      return;
    }
    appStateController.showToast(
        localizationController.localiztionSettingScreen().scheduleAlarmToast);
    appStateController.scheduleAlarm.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return safeAreaView(
        context, localizationController.localiztionSettingScreen().title,
        children: [
          Obx(() => customSwitchButton(context,
              value: appStateController.exerciseAlarm.value,
              title: localizationController
                  .localiztionSettingScreen()
                  .exerciseAlarm,
              onPress: onPressExerciseAlarm)),
          Obx(() => customSwitchButton(context,
              value: appStateController.scheduleAlarm.value,
              title: localizationController
                  .localiztionSettingScreen()
                  .scheduleAlarm,
              onPress: onPressScheduleAlarm)),
        ]);
  }
}
