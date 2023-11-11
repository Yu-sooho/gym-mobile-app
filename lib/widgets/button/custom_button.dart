import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/store/package_stores.dart';

@immutable
class CustomButton extends StatelessWidget {
  final FirebaseAnalyticsController firebaseAnalyticsController =
      Get.put(FirebaseAnalyticsController());

  final Function()? onPress;
  final BoxDecoration? boxDecoration;
  final Widget child;

  CustomButton({
    this.onPress,
    this.boxDecoration,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    onTap() async {
      final screenName = ModalRoute.of(context)?.settings.name;
      if (screenName != null) {
        String result = screenName.replaceAll('/', '');
        await firebaseAnalyticsController.clickEvent(
            name: 'custom_button', parameters: {'screenName': result});
      }
      if (onPress != null) {
        onPress!();
      }
    }

    return InkWell(
      onTap: onTap,
      child: child,
    );
  }
}
