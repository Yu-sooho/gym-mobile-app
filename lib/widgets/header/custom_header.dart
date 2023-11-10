import 'package:flutter/material.dart';

@immutable
class CustomHeader extends StatelessWidget {
  final String title;
  final String rightText;
  final Function()? onPressLeft;
  final Function()? onPressRight;

  CustomHeader({
    super.key,
    required this.title,
    required this.rightText,
    this.onPressLeft,
    this.onPressRight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SafeArea(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: onPressLeft,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      height: 32,
                      child: Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 24),
                    )),
                InkWell(
                    child: Container(
                        alignment: Alignment.center,
                        width: 160,
                        height: 32,
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ))
                    // Icon(Icons.arrow_back_ios,
                    //     color: Colors.white, size: 24)),
                    ),
                InkWell(
                    onTap: onPressRight,
                    child: SizedBox(
                        width: 100,
                        height: 32,
                        child: Text(
                          rightText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ))
                    // Icon(Icons.arrow_back_ios,
                    //     color: Colors.white, size: 24)),
                    ),
              ],
            )),
      ),
    );
  }
}
