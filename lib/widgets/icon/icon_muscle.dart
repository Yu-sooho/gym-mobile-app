import 'package:flutter/material.dart';

class IconMuscle extends StatelessWidget {
  final double? size;
  IconMuscle({this.size});

  @override
  Widget build(BuildContext context) {
    return ImageIcon(AssetImage('assets/icons/icon_muscle.png'),
        size: size ?? 24);
  }
}
