import 'package:flutter/material.dart';
import 'package:gym_calendar/screens/home/watch/exercise_start_screen.dart';
import 'package:gym_calendar/screens/home/watch/stopwatch_screen.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class WatchScreen extends StatefulWidget {
  WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => WatchScreenState();
}

class WatchScreenState extends State<WatchScreen>
    with SingleTickerProviderStateMixin {
  Stores stores = Stores();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stores.colorController.customColor().transparent,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: stores.colorController.customColor().transparent,
        bottom: TabBar(
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: stores.colorController.customColor().defaultTextColor,
                width: 1.0,
              ),
            ),
          ),
          controller: tabController,
          tabs: [
            Tab(
              child: Text('Tab 1',
                  style: stores.fontController.customFont().bold14),
            ),
            Tab(
              child: Text('Tab 1',
                  style: stores.fontController.customFont().bold14),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ExerciseStartScreen(),
          StopWatchScreen(),
        ],
      ),
    );
  }
}
