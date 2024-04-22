import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double borderWidth;
  final double width;
  final double height;
  final double iconSize;

  CustomCheckbox(
      {super.key,
      this.value = false,
      required this.onChanged,
      this.activeColor = Colors.blue,
      this.inactiveColor = Colors.grey,
      this.borderWidth = 0,
      this.iconSize = 16,
      this.width = 20.0,
      this.height = 20.0});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value;
  }

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
      widget.onChanged(_isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleCheckbox,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: _isChecked ? widget.activeColor : widget.inactiveColor,
          border: Border.all(
            color: _isChecked ? widget.activeColor : widget.inactiveColor,
            width: widget.borderWidth,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: _isChecked
              ? Icon(Icons.check,
                  size: widget.iconSize, color: widget.inactiveColor)
              : Icon(Icons.check_box_outline_blank,
                  size: widget.iconSize, color: Colors.transparent),
        ),
      ),
    );
  }
}
