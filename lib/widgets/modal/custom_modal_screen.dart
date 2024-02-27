import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class CustomModalScreen extends StatelessWidget {
  final Color? backgroundColor;
  final Color? modalBackground;
  final Function()? onPressOk;
  final Function()? onPressCancel;
  final String? title;
  final String? description;
  final String? okText;
  final TextStyle? okTextStyle;
  final TextStyle? cancelTextStyle;
  final String? cancelText;

  const CustomModalScreen({
    super.key,
    this.backgroundColor,
    this.modalBackground,
    this.onPressOk,
    this.onPressCancel,
    this.title,
    this.description,
    this.okText,
    this.okTextStyle,
    this.cancelTextStyle,
    this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    final Stores stores = Get.put(Stores());
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title != null
                    ? Text(
                        title!,
                        style: stores.fontController
                            .customFont()
                            .bold14
                            .copyWith(
                                color: stores.colorController
                                    .customColor()
                                    .defaultBackground1),
                      )
                    : SizedBox(),
                Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Text(
                        description ?? 'text',
                        textAlign: TextAlign.center,
                        style: stores.fontController
                            .customFont()
                            .medium12
                            .copyWith(
                                color: stores.colorController
                                    .customColor()
                                    .defaultBackground1),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: CustomButton(
                            highlightColor: stores.colorController
                                .customColor()
                                .transparent,
                            onPress: onPressCancel,
                            child: SizedBox(
                              height: 48,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  cancelText ??
                                      stores.localizationController
                                          .localiztionModalScreenText()
                                          .cancel,
                                  style: cancelTextStyle ??
                                      stores.fontController
                                          .customFont()
                                          .medium12
                                          .copyWith(
                                              color: stores.colorController
                                                  .customColor()
                                                  .defaultBackground1),
                                ),
                              ),
                            ))),
                    Expanded(
                        child: CustomButton(
                      highlightColor:
                          stores.colorController.customColor().transparent,
                      onPress: onPressOk,
                      child: SizedBox(
                        height: 48,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            okText ??
                                stores.localizationController
                                    .localiztionModalScreenText()
                                    .ok,
                            style: okTextStyle ??
                                stores.fontController
                                    .customFont()
                                    .medium12
                                    .copyWith(
                                        color: stores.colorController
                                            .customColor()
                                            .defaultBackground1),
                          ),
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
