import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/styles/color_controller.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class AppStateController extends GetxController {
  final CustomColorController colorController =
      Get.put(CustomColorController());

  final view = WidgetsBinding.instance.platformDispatcher.views.first;
  final size =
      WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
  final pixelRatio =
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

// Size in physical pixels:
  final width1 =
      WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width;
  final height1 = WidgetsBinding
      .instance.platformDispatcher.views.first.physicalSize.height;

// Size in logical pixels:
  final width2 = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
  final height2 = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.height /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  late RxDouble screenWidth = width1.obs;
  late RxDouble screenHeight = height1.obs;

  late RxDouble logicalWidth = width2.obs;
  late RxDouble logicalHeight = height2.obs;

  final OverlayEntry overlayEntrys = OverlayEntry(builder: loadingScreen);

  late RxBool exerciseAlarm = true.obs;
  late RxBool scheduleAlarm = true.obs;

  RxBool isLoading = false.obs;
  void setIsLoading(bool value, BuildContext context) {
    isLoading.value = value;
    if (value) {
      OverlayState overlayState = Overlay.of(context);
      overlayState.insert(overlayEntrys);
    } else if (overlayEntrys.mounted) {
      overlayEntrys.remove();
    }
  }

  void showToast(String text) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: colorController.customColor().toastText,
        backgroundColor: colorController.customColor().toastBackground,
        fontSize: 14.0);
  }

  // isGranted - 권한 동의 상태 시 true
  // isLimited - 권한이 제한적으로 동의 상태 시 true (ios 14버전 이상)
  // isPermanentlyDeined - 영구적으로 권한 거부 상태 시 true (android 전용, 다시 묻지 않음)
  // openAppSettings() - 앱 설정 화면으로 이동
  // isRestricted - 권한 요청을 표시하지 않도록 선택 시 true (ios 전용)
  // isDenied - 권한 거부 상태 시 ture

  Future<bool> permissionCheck(Permission permission) async {
    final permissionStatus = await permission.status;
    print('permissionCheck $permission $permissionStatus');
    if (permissionStatus.isGranted) {
      return true;
    }
    if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    }
    permissionRequest(permission);
    return false;
  }

  Future<bool> permissionRequest(Permission permission) async {
    final permissionStatus = await permission.request();
    print('permissionRequest $permission $permissionStatus');
    if (permissionStatus.isGranted) {
      return true;
    }
    return false;
  }
}
