import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/stores/routine_state_controller.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineAddItem extends StatefulWidget {
  RoutineAddItem({super.key});

  @override
  State<RoutineAddItem> createState() => _RoutineAddItem();
}

class _RoutineAddItem extends State<RoutineAddItem> {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final CustomFontController fontController = Get.put(CustomFontController());
  final RoutineStateController routineStateController =
      Get.put(RoutineStateController());
  var title = '';

  onChangedTitle(String value) {}

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration:
          BoxDecoration(color: colorController.customColor().transparent),
      child: Column(children: [
        customTextInput(
            context,
            placeholder: localizationController
                .localiztionRoutineScreen()
                .inputTitlePlaceholder,
            title: localizationController.localiztionRoutineScreen().inputTitle,
            onChangedTitle),
        Padding(
          padding: EdgeInsets.only(top: 24),
          child: Container(
              alignment: Alignment.center,
              height: 96,
              decoration: BoxDecoration(
                  color: colorController.customColor().defaultBackground1),
              child: CupertinoPicker.builder(
                  itemExtent: 32,
                  childCount: CycleType.values.length,
                  onSelectedItemChanged: (i) {
                    print(routineStateController.cycle[CycleType.values[i]]);
                  },
                  itemBuilder: (context, index) {
                    return SizedBox(
                        height: 32,
                        child: Align(
                            child: Text(
                          '${routineStateController.cycle[CycleType.values[index]]}',
                          style: fontController.customFont().bold18,
                        )));
                  })),
        )
      ]),
    ));
  }
}
