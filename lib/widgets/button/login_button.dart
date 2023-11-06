import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final Function onPress;

  const LoginButton({super.key, required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(title)],
    );
  }
}
