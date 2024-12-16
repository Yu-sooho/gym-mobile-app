import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

@immutable
class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final Stores stores = Get.put(Stores());

  bool exerciseAlarm = false;
  bool scheduleAlarm = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future init() async {
    setState(() {
      exerciseAlarm =
          stores.firebaseAuthController.currentUserData.notification1?.value ??
              false;
      scheduleAlarm =
          stores.firebaseAuthController.currentUserData.notification2?.value ??
              false;
    });
  }

  void onPressExerciseAlarm() async {
    Map<Object, Object> data = {};

    data = {...data, 'notification1': !exerciseAlarm};

    final res = await stores.authStateController
        .updateUser(data, stores.firebaseAuthController.docId!.value);

    if (!res) {
      exerciseAlarm = !exerciseAlarm;
      stores.appStateController.showToast(stores.localizationController
          .localiztionComponentError()
          .networkError);
      return;
    }

    setState(() {
      exerciseAlarm = !exerciseAlarm;
    });

    if (exerciseAlarm) {
      stores.appStateController.showToast(stores.localizationController
          .localiztionSettingScreen()
          .exerciseAlarmToast);
    } else {
      stores.appStateController.showToast(stores.localizationController
          .localiztionSettingScreen()
          .exerciseAlarmCancelToast);
    }
  }

  void onPressScheduleAlarm() async {
    Map<Object, Object> data = {};

    data = {...data, 'notification2': !scheduleAlarm};

    final res = await stores.authStateController
        .updateUser(data, stores.firebaseAuthController.docId!.value);

    if (!res) {
      stores.appStateController.showToast(stores.localizationController
          .localiztionComponentError()
          .networkError);
      return;
    }

    setState(() {
      scheduleAlarm = !scheduleAlarm;
    });

    if (scheduleAlarm) {
      stores.appStateController.showToast(stores.localizationController
          .localiztionSettingScreen()
          .scheduleAlarmToast);
    } else {
      stores.appStateController.showToast(stores.localizationController
          .localiztionSettingScreen()
          .scheduleAlarmCancelToast);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaView(
        title: stores.localizationController.localiztionSettingScreen().title,
        children: [
          SizedBox(
            height: 24,
          ),
          Obx(() => customSwitchButton(context,
              value: exerciseAlarm,
              title: stores.localizationController
                  .localiztionSettingScreen()
                  .exerciseAlarm,
              onPress: onPressExerciseAlarm)),
          Obx(() => customSwitchButton(context,
              value: scheduleAlarm,
              title: stores.localizationController
                  .localiztionSettingScreen()
                  .scheduleAlarm,
              onPress: onPressScheduleAlarm)),
        ]);
  }
}
