import 'package:flutter/material.dart';
import 'package:gym_calendar/widgets/button/login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void onPressEmail() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: Center(
                child: Column(
              children: [
                LoginButton(title: '23', onPress: onPressEmail),
                LoginButton(title: '23', onPress: onPressEmail),
                LoginButton(title: '23', onPress: onPressEmail)
              ],
            ))));
  }
}
