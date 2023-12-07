import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  NetworkProviders networkProviders = NetworkProviders();
  Stores stores = Stores();

  QueryDocumentSnapshot<Object?>? startAfter;
  List<Exercise>? exerciseList;
  bool endExerciseList = false;
  int limit = 4;

  void getMuscleList() async {
    if (stores.exerciseStateController.muscles == null) {
      await networkProviders.exerciseProvider.getMuscleList();
    }
  }

  void getExerciseList() async {
    if (endExerciseList) return;
    final result = await networkProviders.exerciseProvider
        .getExerciseList(startAfter: startAfter);
    if (result.list.isNotEmpty) {
      if (result.length < 4) {
        setState(() {
          endExerciseList = true;
        });
      }
      setState(() {
        startAfter = result.lastDoc;
        exerciseList = result.list;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMuscleList();
    getExerciseList();
  }

  @override
  Widget build(BuildContext context) {
    return (TabAreaView(paddingTop: 24, children: [
      ExerciseAddItem(),
      CustomButton(
          onPress: getExerciseList,
          child: SizedBox(
            child: Text('$startAfter'),
          ))
    ]));
  }
}
