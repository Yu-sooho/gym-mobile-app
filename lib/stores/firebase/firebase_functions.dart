import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/app_state_controller.dart';
import 'package:gym_calendar/stores/localization/localization_controller.dart';

class FirebaseController extends GetxController {
  Future<bool> firebaseAsync(Function networkFunction) async {
    final LocalizationController localizationController =
        Get.put(LocalizationController());
    final AppStateController appStateController = Get.put(AppStateController());
    try {
      return await networkFunction();
    } on TimeoutException catch (_) {
      print('TimeoutException');
      appStateController.showToast(
          localizationController.localiztionComponentError().networkError);
      return false;
    } on SocketException catch (_) {
      print('SocketException');
      appStateController.showToast(
          localizationController.localiztionComponentError().networkError);
      return false;
    } catch (error) {
      print('updateUser $error');
      return false;
    }
  }
}
