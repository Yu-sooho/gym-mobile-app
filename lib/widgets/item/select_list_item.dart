import 'package:flutter/material.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class SelectListItem extends StatelessWidget {
  final String selectedItem;
  final dynamic onPress;
  final Widget icon;
  final String title;
  final TextStyle style;

  SelectListItem({
    required this.selectedItem,
    required this.onPress,
    required this.icon,
    required this.title,
    required this.style,
  });

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SelectListItem &&
        other.selectedItem == selectedItem &&
        other.title == title &&
        other.style == style;
  }

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode => selectedItem.hashCode ^ title.hashCode ^ style.hashCode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: style,
          ),
          CustomButton(
            onPress: onPress,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: SizedBox(
              height: 32,
              width: 64,
              child: Align(
                alignment: Alignment.centerRight,
                child: icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
