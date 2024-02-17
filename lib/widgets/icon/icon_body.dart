import 'package:flutter/material.dart';

class IconBody extends StatelessWidget {
  final double? size;
  IconBody({this.size});

  @override
  Widget build(BuildContext context) {
    return ImageIcon(AssetImage('assets/icons/icon_body.png'),
        size: size ?? 24);
  }
}
