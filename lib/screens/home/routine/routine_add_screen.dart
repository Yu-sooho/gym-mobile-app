import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class RoutineAddScreen extends StatefulWidget {
  RoutineAddScreen({super.key});

  @override
  State<RoutineAddScreen> createState() => _RoutineAddScreenState();
}

class _RoutineAddScreenState extends State<RoutineAddScreen> {
  Stores stores = Stores();
  NetworkProviders networkProviders = NetworkProviders();
  TextEditingController _textController = TextEditingController(text: '');
  var isOpen = false;
  List<int> selectedPart = [];
  int? tempSelectedPart;
  String exerciseName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkCanSave() {}
  onPressAdd(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return safeAreaView(context,
        stores.localizationController.localiztionRoutineAddScreen().title,
        rightText:
            stores.localizationController.localiztionRoutineAddScreen().add,
        isRightInActive: checkCanSave(),
        onPressRight: () => onPressAdd(context),
        children: []);
  }
}
