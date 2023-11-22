import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screens/package_screen.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());
  final AppStateController appStateController = Get.put(AppStateController());
  final CustomFontController fontController = Get.put(CustomFontController());
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  void onPressProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  var tab = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Stack(children: <Widget>[
      Obx(() => Scaffold(
            backgroundColor: colorController.customColor().defaultBackground,
          )),
      Column(
        children: [
          homeHeader(context, tab),
          SizedBox(
            height: appStateController.logicalHeight.value -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).viewInsets.bottom -
                32,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: [
                Text('홈페이지'),
                Text('샵페이지'),
                Text('샵페이지'),
                Text('샵페이지')
              ][tab],
              bottomNavigationBar: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor:
                        colorController.customColor().defaultBackground,
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
                          Icons.calendar_today_outlined,
                          color: colorController.customColor().bottomTabBarItem,
                          size: 24,
                        ),
                        activeIcon: Icon(
                          Icons.calendar_today,
                          color: colorController
                              .customColor()
                              .bottomTabBarActiveItem,
                          size: 24,
                        ), //해당 items 눌렀을 때 보여줄 아이콘
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: Icon(
                          Icons.apps_outage_outlined,
                          color: colorController.customColor().bottomTabBarItem,
                          size: 24,
                        ),
                        activeIcon: Icon(
                          Icons.apps_outage,
                          color: colorController
                              .customColor()
                              .bottomTabBarActiveItem,
                          size: 24,
                        ), //해당 items 눌렀을 때 보여줄 아이콘
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: Icon(
                          Icons.timer_outlined,
                          color: colorController.customColor().bottomTabBarItem,
                          size: 24,
                        ),
                        activeIcon: Icon(
                          Icons.timer,
                          color: colorController
                              .customColor()
                              .bottomTabBarActiveItem,
                          size: 24,
                        ), //해당 items 눌렀을 때 보여줄 아이콘
                        label: 'Shop',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: Icon(
                          Icons.shop_2_outlined,
                          color: colorController.customColor().bottomTabBarItem,
                          size: 24,
                        ),
                        activeIcon: Icon(
                          Icons.shopping_bag,
                          color: colorController
                              .customColor()
                              .bottomTabBarActiveItem,
                          size: 24,
                        ), //해당 items 눌렀을 때 보여줄 아이콘
                        label: 'Home',
                      ),
                    ],
                  )),
            ),
          )
        ],
      )
    ]));
  }
}

Widget homeHeader(BuildContext context, int tab) {
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final CustomFontController fontController = Get.put(CustomFontController());

  String titleSelector() {
    switch (tab) {
      case 0:
        return localizationController.localiztionHomeScreen().title1;
      case 1:
        return localizationController.localiztionHomeScreen().title2;
      case 2:
        return localizationController.localiztionHomeScreen().title3;
      case 3:
        return localizationController.localiztionHomeScreen().title4;
    }
    return '';
  }

  return (Obx(() => Material(
      color: Colors.transparent,
      child: SafeArea(
          bottom: false,
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titleSelector(),
                  style: fontController.customFont().bold14,
                )
              ],
            ),
          )))));
}
