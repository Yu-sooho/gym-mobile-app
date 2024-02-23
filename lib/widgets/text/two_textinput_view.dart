import 'package:flutter/material.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class TwoTextInput extends StatelessWidget {
  const TwoTextInput({
    super.key,
    required this.stores,
    required TextEditingController textController1,
    required TextEditingController textController2,
    required String title,
    required String placeholder1,
    required String placeholder2,
    required ValueChanged<String> onChanged1,
    required ValueChanged<String> onChanged2,
    this.dropdownValue,
    this.dropdownItems,
    this.onChangedDropdown,
  })  : _textController1 = textController1,
        _textController2 = textController2,
        _placeholder1 = placeholder1,
        _placeholder2 = placeholder2,
        _onChanged1 = onChanged1,
        _onChanged2 = onChanged2,
        _title = title;

  final Stores stores;
  final TextEditingController _textController1;
  final TextEditingController _textController2;
  final String _title;
  final String _placeholder1;
  final String _placeholder2;
  final ValueChanged<String> _onChanged1;
  final ValueChanged<String> _onChanged2;
  final String? dropdownValue;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onChangedDropdown;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: SizedBox(
            height: 24,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _title,
                style: stores.fontController.customFont().bold12,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 16, 0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: _onChanged1,
                  controller: _textController1,
                  scrollPadding: EdgeInsets.only(bottom: 34),
                  cursorColor:
                      stores.colorController.customColor().textInputCursor,
                  style: stores.fontController.customFont().medium12,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    counterStyle: stores.fontController.customFont().medium12,
                    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 10),
                    hintStyle: stores.fontController
                        .customFont()
                        .medium12
                        .copyWith(
                          color:
                              stores.colorController.customColor().placeholder,
                        ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: stores.colorController
                            .customColor()
                            .textInputCursor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: stores.colorController
                            .customColor()
                            .textInputFocusCursor,
                      ),
                    ),
                    hintText: _placeholder1,
                  ),
                ),
              ),
              if (dropdownItems != null)
                Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: SizedBox(
                        width: 30,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: onChangedDropdown,
                          iconSize: 20,
                          isExpanded: true,
                          alignment: Alignment.center,
                          items: dropdownItems!.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  value,
                                  style: stores.fontController
                                      .customFont()
                                      .medium12
                                      .copyWith(
                                          color: dropdownValue == value
                                              ? stores.colorController
                                                  .customColor()
                                                  .defaultTextColor
                                              : stores.colorController
                                                  .customColor()
                                                  .buttonInActiveText),
                                ),
                              ),
                            );
                          }).toList(),
                          dropdownColor: stores.colorController
                              .customColor()
                              .defaultBackground2,
                          underline: Container(
                            height: 1,
                            color: stores.colorController
                                .customColor()
                                .transparent,
                          ),
                        ))),
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  onChanged: _onChanged2,
                  controller: _textController2,
                  scrollPadding: EdgeInsets.only(bottom: 34),
                  cursorColor:
                      stores.colorController.customColor().textInputCursor,
                  style: stores.fontController.customFont().medium12,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    counterStyle: stores.fontController.customFont().medium12,
                    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 10),
                    hintStyle: stores.fontController
                        .customFont()
                        .medium12
                        .copyWith(
                          color:
                              stores.colorController.customColor().placeholder,
                        ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: stores.colorController
                            .customColor()
                            .textInputCursor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: stores.colorController
                            .customColor()
                            .textInputFocusCursor,
                      ),
                    ),
                    hintText: _placeholder2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
