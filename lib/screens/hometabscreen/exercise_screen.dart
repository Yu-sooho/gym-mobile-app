import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_calendar/models/package_models.dart';
import 'package:gym_calendar/providers/package_provider.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final GlobalKey _containerkey = GlobalKey();
  NetworkProviders networkProviders = NetworkProviders();
  Stores stores = Stores();
  final _controller = ScrollController();

  QueryDocumentSnapshot<Object?>? startAfter;
  List<Exercise>? exerciseList;
  bool endExerciseList = false;
  int limit = 4;
  double headerHeight = 48 + 16;
  bool exerciseLoading = false;

  void getMuscleList() async {
    if (stores.exerciseStateController.muscles == null) {
      await networkProviders.exerciseProvider.getMuscleList();
    }
  }

  void getExerciseList() async {
    if (endExerciseList || exerciseLoading) return;
    setState(() {
      exerciseLoading = true;
    });
    final result = await networkProviders.exerciseProvider
        .getExerciseList(startAfter: startAfter);
    if (result.list.isNotEmpty) {
      if (result.length < 4) {
        setState(() {
          endExerciseList = true;
          exerciseLoading = false;
        });
      }
      setState(() {
        exerciseLoading = false;
        startAfter = result.lastDoc;
        if (exerciseList != null) {
          exerciseList?.addAll(result.list);
        } else {
          exerciseList = result.list;
        }
      });
    }
  }

  Future onRefresh() async {
    startAfter = null;
    exerciseList = null;
    endExerciseList = false;
    getMuscleList();
    getExerciseList();
  }

  @override
  void initState() {
    super.initState();
    getMuscleList();
    getExerciseList();

    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;
      double delta = 200.0;
      if (maxScroll - currentScroll <= delta) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          getExerciseList();
        }
      }
    });
  }

  Size? getSize() {
    if (_containerkey.currentContext != null) {
      final RenderBox renderBox =
          _containerkey.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }
    return null;
  }

  void getHeight(double height) {
    setState(() {
      headerHeight = height + 16;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (TabAreaView(
        onRefresh: onRefresh,
        scrollController: _controller,
        paddingTop: 24,
        header: Padding(
            padding: EdgeInsets.only(top: 16),
            child: ExerciseAddItem(
              key: _containerkey,
              getHeight: getHeight,
            )),
        headerSize: headerHeight,
        children: [
          exerciseList != null
              ? ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: exerciseList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 150,
                      width: 156,
                      child: Text('${exerciseList?[index].name}'),
                    );
                  },
                )
              : SizedBox(),
          // exerciseLoading
          //     ? SizedBox(
          //         child: SpinKitFadingCircle(
          //           size: 25,
          //           color: stores.colorController
          //               .customColor()
          //               .loadingSpinnerColor,
          //         ),
          //       )
          //     : SizedBox(),
        ]));
  }
}
