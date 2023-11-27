import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_calendar/stores/package_stores.dart';
import 'package:gym_calendar/widgets/package_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({super.key});

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

  XFile? pickedFile;
  File? image;
  final ImagePicker picker = ImagePicker();
  late String nickName =
      firebaseAuthController.currentUserData.displayName?.value ?? '';

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
      pickedFile = await picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile!.path);
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
    if (image != null) return false;
    if (nickName == firebaseAuthController.currentUserData.displayName?.value ||
        nickName == '' ||
        validateNickName(nickName) != null) {
      return true;
    }
    return false;
  }

  void changeProfile(BuildContext context) async {
    if (image != null) {
      appStateController.setIsLoading(true, context);
      if (firebaseAuthController.currentUser?.uid == null) {
        appStateController.setIsLoading(false, context);
        Fluttertoast.showToast(msg: 'FUFU');
        return;
      }
      final url = await uploadProfileImage(
          firebaseAuthController.currentUser!.uid,
          pickedFile!.name,
          pickedFile!.path);
      if (url == null) {
        if (context.mounted) {
          appStateController.setIsLoading(false, context);
        }
        Fluttertoast.showToast(msg: 'FUFU');
        return;
      }
      final res =
          await updateUser(url, firebaseAuthController.currentUser!.uid);
      if (res) {
        firebaseAuthController.currentUserData.photoURL?.value = url;
        if (context.mounted) {
          Navigator.pop(context);
          appStateController.setIsLoading(false, context);
        }
        Fluttertoast.showToast(msg: 'FUFU2');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = firebaseAuthController.currentUserData;
    return safeAreaView(
        context, localizationController.localiztionProfileEditScreen().title,
        rightText: localizationController.localiztionProfileEditScreen().save,
        isRightInActive: checkCanSave(),
        onPressRight: () => changeProfile(context),
        children: [
          SizedBox(
              child: Padding(
            padding: EdgeInsets.only(top: 24),
            child: UserProfileButton(
              image: image,
              imageUrl: user.photoURL?.value,
              onPressImage: onPressImage,
            ),
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
