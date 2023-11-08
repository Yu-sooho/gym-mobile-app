import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(6)),
      margin: EdgeInsets.all(6),
      child: InkWell(
        onTap: onPress,
        child: Image(image: image, width: 320, height: 44, fit: BoxFit.fill),
      ),
    );
  }
}
