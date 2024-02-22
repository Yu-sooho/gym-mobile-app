import 'dart:io';
import 'package:flutter/material.dart';
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
  final Stores stores = Get.put(Stores());

  XFile? pickedFile;
  File? image;
  final ImagePicker picker = ImagePicker();
  late String nickName =
      stores.firebaseAuthController.currentUserData.displayName?.value ?? '';

  void onPressImage(BuildContext context) async {
    final photoPermission =
        await stores.appStateController.permissionCheck(Permission.photos);
    if (photoPermission) {
      if (!context.mounted) return;
      getImage(ImageSource.gallery, context);
    }
  }

  Future getImage(ImageSource imageSource, BuildContext context) async {
    stores.appStateController.setIsLoading(true, context);
    try {
      pickedFile = await picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile!.path);
        });
      }
      if (!context.mounted) return;
      stores.appStateController.setIsLoading(false, context);
    } catch (error) {
      stores.appStateController.setIsLoading(false, context);
    }
  }

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  void onChangedName(String name) {
    // setState(() {
    //   nickName = name;
    //   formKey.currentState?.validate();
    // });
  }

  String? validateNickName(value) {
    final check = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (check) {
      return stores.localizationController
          .localiztionProfileEditScreen()
          .errorNickName;
    }
    return null;
  }

  bool checkCanSave() {
    if (image != null) return false;
    if (nickName ==
            stores.firebaseAuthController.currentUserData.displayName?.value ||
        nickName == '' ||
        validateNickName(nickName) != null) {
      return true;
    }
    return false;
  }

  void changeProfile(BuildContext context) async {
    Map<Object, Object> data = {};
    stores.appStateController.setIsLoading(true, context);
    if (image != null) {
      if (stores.firebaseAuthController.docId == null) {
        stores.appStateController.setIsLoading(false, context);
        return;
      }
      final url = await stores.firebaseStorageController.uploadProfileImage(
          stores.firebaseAuthController.docId!.value,
          pickedFile!.name,
          pickedFile!.path);
      if (url == null) {
        if (context.mounted) {
          stores.appStateController.setIsLoading(false, context);
        }
        return;
      }

      data = {...data, 'photoURL': url};
      stores.firebaseAuthController.currentUserData.photoURL?.value = url;
    }

    if (nickName.isNotEmpty) {
      data = {...data, 'displayName': nickName};
    }

    final res = await stores.authStateController
        .updateUser(data, stores.firebaseAuthController.docId!.value);
    if (res) {
      if (context.mounted) {
        Navigator.pop(context);
        if (nickName.isNotEmpty) {
          stores.firebaseAuthController.currentUserData.displayName!.value =
              nickName;
        }
      }
    }
    if (context.mounted) stores.appStateController.setIsLoading(false, context);
  }

  @override
  Widget build(BuildContext context) {
    final user = stores.firebaseAuthController.currentUserData;
    return safeAreaView(context,
        stores.localizationController.localiztionProfileEditScreen().title,
        rightText:
            stores.localizationController.localiztionProfileEditScreen().save,
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
          CustomTextInput(
              onChanged: onChangedName,
              keyboardType: TextInputType.text,
              title: stores.localizationController
                  .localiztionProfileEditScreen()
                  .nickName,
              placeholder: nickName,
              maxLength: 8,
              count: nickName.length,
              validator: validateNickName)
        ]);
  }
}
