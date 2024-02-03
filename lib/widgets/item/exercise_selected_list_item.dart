import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ExerciseSelectedListItem extends StatefulWidget {
  late final Exercise item;
  late final Function(Exercise item) onPress;

  ExerciseSelectedListItem({
    super.key,
    required this.item,
    required this.onPress,
  });

  @override
  State<ExerciseSelectedListItem> createState() => _ExerciseSelectedListItem();
}

class _ExerciseSelectedListItem extends State<ExerciseSelectedListItem> {
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    Stores stores = Stores();
    print(item.name);

    return SizedBox(
      height: 32,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          item.name,
          style: stores.fontController.customFont().medium12,
        ),
        CustomButton(
            onPress: () => {widget.onPress(item)},
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: SizedBox(
              height: 32,
              width: 64,
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  CupertinoIcons.clear,
                  color: stores.colorController
                      .customColor()
                      .bottomTabBarActiveItem,
                  size: 16,
                ),
              ),
            ))
      ]),
    );
  }
}
