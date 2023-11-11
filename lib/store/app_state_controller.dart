import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStateController extends GetxController {
  final view = WidgetsBinding.instance.platformDispatcher.views.first;
  final size =
      WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
  final pixelRatio =
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

// Size in physical pixels:
  final width1 =
      WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width;
  final height1 = WidgetsBinding
      .instance.platformDispatcher.views.first.physicalSize.height;

// Size in logical pixels:
  final width2 = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
  final height2 = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.height /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  late double screenWidth = width1;
  late double screenHeight = height1;

  late double logicalWidth = width2;
  late double logicalHeight = height2;
}
