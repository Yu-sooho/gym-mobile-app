import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';

@immutable
class LoginButton extends StatelessWidget {
  final Function() onPress;
  final ImageProvider image;

  const LoginButton({
    super.key,
    required this.onPress,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(image: image, width: 320, height: 44, fit: BoxFit.fill),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPress,
              highlightColor: Colors.white.withOpacity(0.5),
              splashColor: Colors.white.withOpacity(0.2),
            ),
          ),
        ),
      ],
    );
  }
}
