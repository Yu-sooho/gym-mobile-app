import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/screens/package_screen.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());
  final AppStateController appStateController = Get.put(AppStateController());
  final CustomFontController fontController = Get.put(CustomFontController());
  final CustomColorController colorController =
      Get.put(CustomColorController());

  void onPressEmail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  void onPressText() {
    if (fontController.fontType.value == 2 ||
        colorController.colorType.value == 2) {
      fontController.fontType.value = 0;
      colorController.colorType.value = 0;
      return;
    }
    fontController.fontType.value++;
    colorController.colorType.value++;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Stack(children: <Widget>[
      Obx(() => Scaffold(
            backgroundColor: colorController.customColor().defaultBackground,
          )),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(right: 18, left: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Hey, selena',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: onPressText,
                        child: Text(
                          'Welcome back',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Text(
                    'Total Balance',
                    style: fontController.customFont().bold14,
                  ),
                  Text(
                    '\$5 194 482',
                    style: fontController.customFont().bold14,
                  ),
                  InkWell(
                    onTap: () => onPressEmail(context),
                    child: Container(
                      width: 320,
                      decoration: BoxDecoration(color: Colors.red),
                      height: 280,
                      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      alignment: Alignment.center,
                      child: Text(
                        '1231321312312',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.blueGrey),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Wallet',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'View all',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 24,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Euro',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text(
                                      '6 428',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'EUR',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Transform.scale(
                          scale: 2.2,
                          child: Transform.translate(
                            offset: const Offset(8, 15),
                            child: const Icon(
                              Icons.euro,
                              color: Colors.white,
                              size: 88,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    ]));
  }
}
