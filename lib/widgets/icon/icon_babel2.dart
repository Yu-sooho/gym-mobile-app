import 'package:flutter/material.dart';

class IconBabel2 extends StatelessWidget {
  final double? size;
  IconBabel2({this.size});

  @override
  Widget build(BuildContext context) {
    return ImageIcon(AssetImage('assets/icons/icon_babel2.png'),
        size: size ?? 24);
  }
}
