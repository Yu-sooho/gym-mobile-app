import 'package:flutter/material.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class CompleteButton extends StatefulWidget {
  CompleteButton({super.key, required this.title});

  final String title;

  @override
  State<CompleteButton> createState() => _CompleteButton();
}

class _CompleteButton extends State<CompleteButton> {
  final Stores stores = Stores();
  @override
  Widget build(BuildContext context) {
    return (CustomButton(
        child: (Container(
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: stores.colorController.customColor().defaultBackground1),
            width: stores.appStateController.logicalWidth.value - 32,
            child: Text(
              widget.title,
              style: stores.fontController.customFont().bold12,
            )))));
  }
}
