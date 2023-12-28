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
  final Stores stores = Get.put(Stores());

  final RoutineStateController routineStateController =
      Get.put(RoutineStateController());
  var title = '';

  onChangedTitle(String value) {}

  void onChangedItem(int index) {}

  void onPressOkAddExercise() {}

  void onPressCancelAddExercise() {}

  void onPressAddExercise() {
    stores.appStateController.showDialog(
        CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 32,
            onSelectedItemChanged: onChangedItem,
            children: List<Widget>.generate(
                stores.exerciseStateController.muscles?.length ?? 0,
                (int index) {
              return Center(
                  child: Center(
                      child: Text(
                          '${stores.exerciseStateController.muscles?[index].name}')));
            })),
        context,
        isHaveButton: true,
        barrierDismissible: false,
        onPressOk: onPressOkAddExercise,
        onPressCancel: onPressCancelAddExercise);
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
          color: stores.colorController.customColor().transparent),
      child: Column(children: [
        customTextInput(
            context,
            placeholder: stores.localizationController
                .localiztionRoutineScreen()
                .inputTitlePlaceholder,
            title: stores.localizationController
                .localiztionRoutineScreen()
                .inputTitle,
            onChangedTitle),
        Padding(
          padding: EdgeInsets.only(top: 24),
          child: Container(
              alignment: Alignment.center,
              height: 96,
              decoration: BoxDecoration(
                  color:
                      stores.colorController.customColor().defaultBackground1),
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
                          style: stores.fontController.customFont().bold18,
                        )));
                  })),
        )
      ]),
    ));
  }
}
