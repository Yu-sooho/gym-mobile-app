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
  late String nickName = firebaseAuthController.currentUser?.displayName ?? '';

  void onPressImage(BuildContext context) async {
    final photoPermission =
        await appStateController.permissionCheck(Permission.photos);
    if (photoPermission) {
      if (!context.mounted) return;
      getImage(ImageSource.gallery, context);
    }
  }

  Future getImage(ImageSource imageSource, BuildContext context) async {
    appStateController.setIsLoading(true, context);
    try {
      final XFile? pickedFile = await picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        setState(() {
          image = XFile(pickedFile.path);
        });
      }
      if (!context.mounted) return;
      appStateController.setIsLoading(false, context);
    } catch (error) {
      appStateController.setIsLoading(false, context);
    }
  }

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  void onChangedName(String name) {
    setState(() {
      nickName = name;
      formKey.currentState?.validate();
    });
  }

  String? validateNickName(value) {
    final check = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (check) {
      return localizationController
          .localiztionProfileEditScreen()
          .errorNickName;
    }
    return null;
  }

  bool checkCanSave() {
    if (nickName == firebaseAuthController.currentUser?.displayName ||
        nickName == '' ||
        validateNickName(nickName) != null) {
      return true;
    }
    return false;
  }

  void changeProfile() {}

  @override
  Widget build(BuildContext context) {
    final user = firebaseAuthController.currentUser;
    return safeAreaView(
        context, localizationController.localiztionProfileEditScreen().title,
        rightText: localizationController.localiztionProfileEditScreen().save,
        isRightInActive: checkCanSave(),
        onPressRight: changeProfile,
        children: [
          SizedBox(
              child: Padding(
            padding: EdgeInsets.only(top: 24),
            child: userProfileButton(context, user, onPressImage,
                image: image != null ? File(image!.path) : null),
          )),
          SizedBox(height: 16),
          customTextInput(context, onChangedName,
              title: localizationController
                  .localiztionProfileEditScreen()
                  .nickName,
              placeholder: nickName,
              maxLength: 8,
              count: nickName.length,
              validator: validateNickName,
              key: formKey),
        ]);
  }
}
