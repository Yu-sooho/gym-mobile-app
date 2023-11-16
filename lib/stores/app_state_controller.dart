import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class AppStateController extends GetxController {
  final CustomColorController customColorController =
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

  late double screenWidth = width1;
  late double screenHeight = height1;

  late double logicalWidth = width2;
  late double logicalHeight = height2;

  final OverlayEntry overlayEntrys = OverlayEntry(builder: loadingScreen);

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
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: customColorController.customColor().toastText,
        backgroundColor: customColorController.customColor().toastBackground,
        fontSize: 16.0);
  }
}
