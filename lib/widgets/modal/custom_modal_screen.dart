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
  final Stores stores = Get.put(Stores());

  return Obx(() => Scaffold(
      backgroundColor: backgroundColor ??
          stores.colorController.customColor().loadingSpinnerOpacity,
      body: Align(
        child: Container(
          width: stores.appStateController.logicalWidth.value * 0.7,
          height: stores.appStateController.logicalHeight.value * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: modalBackground ??
                  stores.colorController.customColor().modalBackground),
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(children: [
              Text(
                title ?? 'title',
                style: stores.fontController.customFont().modalTitle,
              ),
              Expanded(
                child: Align(
                    child: Text(
                  description ?? 'text',
                  textAlign: TextAlign.center,
                  style: stores.fontController.customFont().modalText,
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      highlightColor:
                          stores.colorController.customColor().transparent,
                      onPress: onPressCancel,
                      child: SizedBox(
                        width: (stores.appStateController.logicalWidth.value *
                                0.7) /
                            2,
                        height: stores.appStateController.logicalHeight.value *
                            0.07,
                        child: Align(
                          child: Text(
                            okText ??
                                stores.localizationController
                                    .localiztionModalScreenText()
                                    .cancel,
                            style:
                                stores.fontController.customFont().modalCancel,
                          ),
                        ),
                      )),
                  CustomButton(
                      highlightColor:
                          stores.colorController.customColor().transparent,
                      onPress: onPressOk,
                      child: SizedBox(
                        width: (stores.appStateController.logicalWidth.value *
                                0.7) /
                            2,
                        height: stores.appStateController.logicalHeight.value *
                            0.07,
                        child: Align(
                          child: Text(
                            okText ??
                                stores.localizationController
                                    .localiztionModalScreenText()
                                    .ok,
                            style: stores.fontController.customFont().modalOk,
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
