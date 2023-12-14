import 'package:flutter/material.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class CompleteButton extends StatefulWidget {
  final String title;
  final bool disabled;
  final Function()? onPress;
  final Animation<double>? animation;
  CompleteButton({
    super.key,
    required this.title,
    required this.onPress,
    this.disabled = false,
    this.animation,
  });

  @override
  State<CompleteButton> createState() => _CompleteButton();
}

class _CompleteButton extends State<CompleteButton> {
  final Stores stores = Stores();
  @override
  Widget build(BuildContext context) {
    return (CustomButton(
        onPress: widget.disabled ? () {} : widget.onPress,
        child: (Container(
            height:
                (widget.animation != null ? widget.animation!.value : 1) * 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.disabled
                    ? stores.colorController
                        .customColor()
                        .defaultBackground2
                        .withOpacity(0.2)
                    : stores.colorController.customColor().defaultBackground1),
            width: stores.appStateController.logicalWidth.value - 32,
            child: Text(
              widget.title,
              style: TextStyle(
                  color: widget.disabled
                      ? stores.colorController.customColor().defaultBackground2
                      : stores.fontController.customFont().bold12.color,
                  fontWeight:
                      stores.fontController.customFont().bold12.fontWeight,
                  fontSize: stores.fontController.customFont().bold12.fontSize,
                  fontFamily:
                      stores.fontController.customFont().bold12.fontFamily),
            )))));
  }
}
