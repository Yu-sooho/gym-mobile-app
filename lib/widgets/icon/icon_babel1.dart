import 'package:flutter/material.dart';

class IconBabel1 extends StatelessWidget {
  final double? size;
  IconBabel1({this.size});

  @override
  Widget build(BuildContext context) {
    return ImageIcon(AssetImage('assets/icons/icon_babel1.png'),
        size: size ?? 24);
  }
}
