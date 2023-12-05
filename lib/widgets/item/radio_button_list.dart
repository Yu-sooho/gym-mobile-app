import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RadioButtonList extends StatefulWidget {
  final List group;
  final List<TextStyle>? styleGroup;
  final List<Color>? styleColor;
  final int selectValue;
  final Function(int value) onPressItem;
  final String itemText;
  final List<String> names;
  final bool isOpen;

  RadioButtonList(
      {super.key,
      required this.group,
      required this.selectValue,
      required this.onPressItem,
      required this.itemText,
      required this.names,
      this.styleColor,
      this.isOpen = false,
      this.styleGroup});
  @override
  State<RadioButtonList> createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList>
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
    return AnimatedOpacity(
        opacity: widget.isOpen ? 1 : 0,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 250),
        child: SizedBox(
          height: _animation.value * 48 * widget.group.length,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: widget.group.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return CustomButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPress: () => widget.onPressItem(index),
                  child: SizedBox(
                      height: 48,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Expanded(
                                    child: Text(widget.names[index],
                                        style: widget.styleGroup != null
                                            ? TextStyle(
                                                fontFamily: widget
                                                    .styleGroup![index]
                                                    .fontFamily,
                                                fontSize: widget
                                                    .styleGroup![index]
                                                    .fontSize,
                                                fontWeight: widget.selectValue == index
                                                    ? FontWeight.bold
                                                    : widget.styleGroup![index]
                                                        .fontWeight,
                                                color: widget.styleColor != null
                                                    ? widget.styleColor![index]
                                                    : stores.fontController
                                                        .customFont()
                                                        .medium12
                                                        .color)
                                            : TextStyle(
                                                fontFamily: stores.fontController
                                                    .customFont()
                                                    .medium12
                                                    .fontFamily,
                                                fontSize: stores.fontController
                                                    .customFont()
                                                    .medium12
                                                    .fontSize,
                                                fontWeight:
                                                    widget.selectValue == index
                                                        ? FontWeight.bold
                                                        : stores.fontController
                                                            .customFont()
                                                            .medium12
                                                            .fontWeight,
                                                color: widget.styleColor != null
                                                    ? widget.styleColor![index]
                                                    : stores.fontController
                                                        .customFont()
                                                        .medium12
                                                        .color)))),
                                widget.selectValue == index
                                    ? Icon(
                                        Icons.check,
                                        color: stores.colorController
                                            .customColor()
                                            .bottomTabBarActiveItem,
                                        size: 12,
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ))),
                );
              }),
        ));
  }
}
