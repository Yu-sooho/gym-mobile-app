import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class CustomSortBar extends StatefulWidget {
  final bool? isSearch;
  final double sortBarHeight;
  final double itemExtent;
  final Function(int)? onChangedSortMethod;
  final Function()? onPressSortMethodOk;
  final Function(String)? onChanged;
  final String? placeholder;
  final int initialItem;
  final int sortValue;

  CustomSortBar(
      {super.key,
      this.sortBarHeight = 40,
      this.itemExtent = 32,
      this.placeholder,
      this.onChangedSortMethod,
      this.onPressSortMethodOk,
      this.initialItem = 0,
      this.sortValue = 0,
      this.onChanged,
      this.isSearch});

  @override
  State<CustomSortBar> createState() => _CustomSortBar();
}

class _CustomSortBar extends State<CustomSortBar> {
  Stores stores = Stores();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.sortBarHeight,
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.isSearch != null && widget.isSearch != false
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                      child: Container(
                        height: widget.sortBarHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: stores.colorController
                              .customColor()
                              .defaultBackground2,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 12),
                            Icon(
                              Icons.search,
                              size: 20,
                              color: stores.colorController
                                  .customColor()
                                  .buttonDefaultColor,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 16, 2),
                              child: TextField(
                                maxLines: 1,
                                expands: false,
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: widget.placeholder ??
                                      stores.localizationController
                                          .localiztionComponentButton()
                                          .searchPlaceholder,
                                  hintStyle: stores.fontController
                                      .customFont()
                                      .medium12,
                                  border: InputBorder.none,
                                ),
                                cursorColor: stores.colorController
                                    .customColor()
                                    .buttonDefaultColor,
                                style:
                                    stores.fontController.customFont().medium12,
                                onChanged: widget.onChanged,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            CustomButton(
              onPress: () => stores.appStateController.showDialog(
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: widget.itemExtent,
                  scrollController: FixedExtentScrollController(
                    initialItem: widget.initialItem,
                  ),
                  onSelectedItemChanged: widget.onChangedSortMethod,
                  children: List<Widget>.generate(
                    stores.exerciseStateController.exerciseSortMethod.length,
                    (int index) {
                      return Center(
                        child: Text(stores
                            .exerciseStateController.exerciseSortMethod[index]),
                      );
                    },
                  ),
                ),
                context,
                isHaveButton: true,
                onPressOk: widget.onPressSortMethodOk,
              ),
              highlightColor: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                  height: 24,
                  width: 64,
                  alignment: Alignment.centerRight,
                  child: Text(
                    stores.exerciseStateController
                        .exerciseSortMethod[widget.sortValue],
                    style: stores.fontController.customFont().medium12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
