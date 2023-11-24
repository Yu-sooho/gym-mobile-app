import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

Widget customModalScreen(
    {BuildContext? context,
    Color? backgroundColor,
    Color? modalBackground,
    Function()? onPressOk,
    Function()? onPressCancel,
    String? title,
    String? description,
    String? okText,
    String? cancelText}) {
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final AppStateController appStateController = Get.put(AppStateController());
  final CustomFontController fontController = Get.put(CustomFontController());

  return Obx(() => Scaffold(
      backgroundColor: backgroundColor ??
          colorController.customColor().loadingSpinnerOpacity,
      body: Align(
        child: Container(
          width: appStateController.logicalWidth.value * 0.7,
          height: appStateController.logicalHeight.value * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: modalBackground ??
                  colorController.customColor().modalBackground),
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(children: [
              Text(
                title ?? 'title',
                style: fontController.customFont().modalTitle,
              ),
              Expanded(
                child: Align(
                    child: Text(
                  description ?? 'text',
                  textAlign: TextAlign.center,
                  style: fontController.customFont().modalText,
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      highlightColor: colorController.customColor().transparent,
                      onPress: onPressCancel,
                      child: SizedBox(
                        width:
                            (appStateController.logicalWidth.value * 0.7) / 2,
                        height: appStateController.logicalHeight.value * 0.07,
                        child: Align(
                          child: Text(
                            okText ??
                                localizationController
                                    .localiztionModalScreenText()
                                    .cancel,
                            style: fontController.customFont().modalCancel,
                          ),
                        ),
                      )),
                  CustomButton(
                      highlightColor: colorController.customColor().transparent,
                      onPress: onPressOk,
                      child: SizedBox(
                        width:
                            (appStateController.logicalWidth.value * 0.7) / 2,
                        height: appStateController.logicalHeight.value * 0.07,
                        child: Align(
                          child: Text(
                            okText ??
                                localizationController
                                    .localiztionModalScreenText()
                                    .ok,
                            style: fontController.customFont().modalOk,
                          ),
                        ),
                      ))
                ],
              )
            ]),
          ),
        ),
      )));
}
