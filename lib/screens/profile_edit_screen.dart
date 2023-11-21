import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  final User? currentUser;
  ProfileEditScreen({super.key, this.currentUser});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final CustomColorController colorController =
      Get.put(CustomColorController());
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());
  final AppStateController appStateController = Get.put(AppStateController());

  XFile? image;
  final ImagePicker picker = ImagePicker();

  void onPressImage(BuildContext context) async {
    final photoPermission =
        await appStateController.permissionCheck(Permission.photos);
    if (photoPermission) {
      getImage(ImageSource.gallery);
    }
  }

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        image = XFile(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = firebaseAuthController.currentUser;
    return safeAreaView(
        context, localizationController.localiztionProfileEditScreen().title,
        children: [
          Column(children: [
            SizedBox(
                child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: userProfileButton(context, user, onPressImage,
                  image: image != null ? File(image!.path) : null),
            )),
            SizedBox(height: 16),
            Text('123')
          ])
        ]);
  }
}
