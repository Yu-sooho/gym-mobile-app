import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

Widget customSwitchButton(BuildContext context,
    {String? title,
    Function()? onPress,
    bool value = true,
    TextStyle? textStyle}) {
  CustomFontController customFontController = Get.put(CustomFontController());
  CustomColorController customColorController =
      Get.put(CustomColorController());

  return Obx(() => CustomButton(
      onPress: onPress,
      child: SizedBox(
        height: 52,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? '',
                style: textStyle ?? customFontController.customFont().bold12,
              ),
              Transform.scale(
                  transformHitTests: false,
                  scale: .7,
                  child: CupertinoSwitch(
                    value: value,
                    activeColor:
                        customColorController.customColor().switchColor,
                    onChanged: (bool? value) {},
                  )),
            ],
          ),
        ),
      )));
}
