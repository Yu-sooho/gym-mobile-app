import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class TitleButton extends StatefulWidget {
  final bool isOpen;
  final String title;
  final Function()? onPress;

  TitleButton({super.key, this.isOpen = false, this.title = '', this.onPress});

  @override
  State<TitleButton> createState() => _TitleButtonState();
}

class _TitleButtonState extends State<TitleButton>
    with TickerProviderStateMixin {
  final Stores stores = Get.put(Stores());

  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    return (CustomButton(
        onPress: widget.onPress,
        child: SizedBox(
            width: stores.appStateController.logicalWidth.value,
            height: 52,
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.title,
                          style: stores.fontController.customFont().bold12),
                      RotationTransition(
                        turns: Tween(begin: 0.5, end: 1.0).animate(_controller),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: stores.colorController
                              .customColor()
                              .bottomTabBarActiveItem,
                          size: 24,
                        ),
                      )
                    ])))));
  }
}
