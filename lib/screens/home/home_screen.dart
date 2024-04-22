import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screens/package_screen.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final Stores stores = Get.put(Stores());

  void onPressProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileScreen(),
          settings: RouteSettings(name: 'profile')),
    );
  }

  String titleSelector() {
    switch (tab) {
      case 0:
        return stores.localizationController.localiztionHomeScreen().title1;
      case 1:
        return stores.localizationController.localiztionHomeScreen().title2;
      case 2:
        return stores.localizationController.localiztionHomeScreen().title3;
      case 3:
        return stores.localizationController.localiztionHomeScreen().title4;
      case 4:
        return stores.localizationController.localiztionHomeScreen().title5;
    }
    return '';
  }

  var tab = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Obx(() => Scaffold(
            body: Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(0, -3),
                  end: Alignment(0, 1),
                  colors: <Color>[
                    stores.colorController.customColor().defaultBackground2,
                    stores.colorController.customColor().defaultBackground1,
                  ],
                  tileMode: TileMode.clamp),
            )),
          )),
      KeyboardDismisser(
        child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 32,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: SizedBox(
                                    width: 24,
                                  ))),
                          Obx(() => Text(
                                titleSelector(),
                                style:
                                    stores.fontController.customFont().bold14,
                              )),
                          CustomButton(
                            onPress: () => onPressProfile(context),
                            child: SizedBox(
                              height: 32,
                              child: Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(
                                    Icons.person,
                                    color: stores.colorController
                                        .customColor()
                                        .bottomTabBarActiveItem,
                                    size: 24,
                                  )),
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.transparent,
                    body: [
                      CalendarScreen(),
                      RoutineScreen(),
                      ExerciseScreen(),
                      StopWatchScreen(),
                      ShoppingScreen()
                    ][tab],
                    bottomNavigationBar: Theme(
                        data: ThemeData(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: BottomNavigationBar(
                          elevation: 0,
                          type: BottomNavigationBarType.fixed,
                          backgroundColor: Colors.transparent,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          currentIndex: tab,
                          onTap: (i) {
                            setState(() {
                              tab = i;
                            });
                          },
                          items: [
                            BottomNavigationBarItem(
                              backgroundColor: Colors.transparent,
                              icon: Icon(
                                Icons.calendar_month,
                                color: stores.colorController
                                    .customColor()
                                    .bottomTabBarItem,
                                size: 24,
                              ),
                              activeIcon: Icon(
                                Icons.calendar_month,
                                color: stores.colorController
                                    .customColor()
                                    .bottomTabBarActiveItem,
                                size: 24,
                              ),
                              label: 'Calendar',
                            ),
                            BottomNavigationBarItem(
                              backgroundColor: Colors.transparent,
                              icon: Icon(
                                Icons.wysiwyg,
                                color: stores.colorController
                                    .customColor()
                                    .bottomTabBarItem,
                                size: 24,
                              ),
                              activeIcon: Icon(
                                Icons.wysiwyg,
                                color: stores.colorController
                                    .customColor()
                                    .bottomTabBarActiveItem,
                                size: 24,
                              ),
                              label: 'Routine',
                            ),
                            BottomNavigationBarItem(
                              backgroundColor: Colors.transparent,
                              icon: Icon(
                                Icons.apps,
                                color: stores.colorController
                                    .customColor()
                                    .bottomTabBarItem,
                                size: 24,
                              ),
                              activeIcon: Icon(
                                Icons.apps,
                                color: stores.colorController
                                    .customColor()
                                    .bottomTabBarActiveItem,
                                size: 24,
                              ),
                              label: 'Exercise',
                            ),
                            BottomNavigationBarItem(
                              backgroundColor: Colors.transparent,
                              icon: Icon(
                                Icons.timer_outlined,
                                color: stores.colorController
                                    .customColor()
                                    .bottomTabBarItem,
                                size: 24,
                              ),
                              activeIcon: Icon(
                                Icons.timer,
                                color: stores.colorController
                                    .customColor()
                                    .bottomTabBarActiveItem,
                                size: 24,
                              ),
                              label: 'Stopwatch',
                            ),
                            BottomNavigationBarItem(
                              backgroundColor: Colors.transparent,
                              icon: Icon(
                                Icons.shop_2_outlined,
                                color: stores.colorController
                                    .customColor()
                                    .bottomTabBarItem,
                                size: 24,
                              ),
                              activeIcon: Icon(
                                Icons.shopping_bag,
                                color: stores.colorController
                                    .customColor()
                                    .bottomTabBarActiveItem,
                                size: 24,
                              ),
                              label: 'Shopping',
                            ),
                          ],
                        )),
                  ),
                )
              ],
            )),
      )
    ]);
  }
}
