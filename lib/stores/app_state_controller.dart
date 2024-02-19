import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/styles/color_controller.dart';
import 'package:gym_calendar/stores/styles/font_controller.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class AppStateController extends GetxController {
  final storage = FlutterSecureStorage();
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final CustomFontController fontController = Get.put(CustomFontController());

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

  late RxDouble fontSize = 0.0.obs;

  Future<bool> changeFontSize(size) async {
    try {
      await storage.write(key: 'fontSize', value: '$size');
      fontSize.value = size;
      return true;
    } catch (error) {
      print('changeLanguage $error');
      return false;
    }
  }

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

  void showDialog(Widget child, BuildContext context,
      {Function()? onPressOk,
      Function()? onPressCancel,
      bool? isHaveButton,
      bool barrierDismissible = true}) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              isHaveButton == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          CustomButton(
                              onPress: () {
                                Navigator.pop(context);
                                if (onPressCancel != null) {
                                  onPressCancel();
                                }
                              },
                              child: SizedBox(
                                height: 32,
                                width: 48,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '취소',
                                      style: fontController
                                          .customFont()
                                          .bold14
                                          .copyWith(
                                            decoration: TextDecoration.none,
                                            color: colorController
                                                .customColor()
                                                .defaultBackground1,
                                          ),
                                    )),
                              )),
                          CustomButton(
                              onPress: () {
                                Navigator.pop(context);
                                if (onPressOk != null) {
                                  onPressOk();
                                }
                              },
                              child: SizedBox(
                                height: 32,
                                width: 48,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('확인',
                                        style: fontController
                                            .customFont()
                                            .bold14
                                            .copyWith(
                                              decoration: TextDecoration.none,
                                              color: colorController
                                                  .customColor()
                                                  .defaultBackground1,
                                            ))),
                              ))
                        ])
                  : SizedBox(),
              Expanded(child: child)
            ],
          ),
        ),
      ),
    );
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
