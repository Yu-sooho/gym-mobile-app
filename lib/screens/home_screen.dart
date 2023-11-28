import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screens/%08hometabscreen/calendar_screen.dart';
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

  var tab = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Stack(children: <Widget>[
      Obx(() => Scaffold(
            body: Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(0, -3),
                  end: Alignment(0, 1),
                  colors: <Color>[
                    colorController.customColor().defaultBackground2,
                    colorController.customColor().defaultBackground1,
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.clamp),
            )),
          )),
      Column(
        children: [
          Material(
              color: Colors.transparent,
              child: SafeArea(
                  bottom: false,
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
                              style: fontController.customFont().bold14,
                            )),
                        CustomButton(
                          onPress: () => onPressProfile(context),
                          child: SizedBox(
                            height: 32,
                            child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.person,
                                  color: colorController
                                      .customColor()
                                      .bottomTabBarActiveItem,
                                  size: 24,
                                )),
                          ),
                        )
                      ],
                    ),
                  ))),
          SizedBox(
            height: appStateController.logicalHeight.value -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).viewInsets.bottom -
                32,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: [
                CalendarScreen(),
                Text('샵페이지'),
                Text('샵페이지'),
                Text('샵페이지')
              ][tab],
              bottomNavigationBar: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
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
                        ),
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
                        ),
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
                        ),
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
