import 'package:flutter/material.dart';

String colorToString(Color color) {
  String hexString = color.value.toRadixString(16).padLeft(8, '0');
  return '#$hexString';
}

Color stringToColor(String colorString) {
  int value = int.parse(colorString.replaceFirst('#', ''), radix: 16);
  return Color(value);
}
