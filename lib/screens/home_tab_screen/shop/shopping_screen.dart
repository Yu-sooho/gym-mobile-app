import 'package:flutter/material.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ShoppingScreen extends StatefulWidget {
  ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return (TabAreaView(paddingTop: 24, children: []));
  }
}
