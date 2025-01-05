import 'dart:io';

import 'package:attendance/core/controller/attendence/edit_profile_controller.dart';
import 'package:attendance/core/controller/attendence/setting_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/views/widgets/common_button.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/common_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget
{

  EditProfileController profileController = Get.put(EditProfileController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  EditProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.cWhite,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {Get.back(result: {
            "profileImage":Prefs.getString(AppConstant.profileImage)
          })},
        ),
        title: Text(
          "Edit Profile".tr,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColor.cBlack),
        ),
      ),
      backgroundColor: AppColor.cWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: SingleChildScrollView(
          child: Obx(
                () => Form(
                  key: formKey,
                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        backgroundImage: profileImage(),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16))),
                            builder: (context) {
                              return Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16))),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    imageWidget(
                                        title: "Camera".tr,
                                        iconData: Icons.camera_alt,
                                        imageSource: ImageSource.camera),
                                    horizontalSpace(35),
                                    imageWidget(
                                        title: "Gallery".tr,
                                        iconData: Icons.photo,
                                        imageSource: ImageSource.gallery),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColor.themeGreenColor,
                          child: Icon(Icons.camera_alt,
                              size: 18, color: AppColor.cWhite),
                        ),
                      )
                    ],
                  ),
                  verticalSpace(20),
                  CommonTextField(
                    prefix: ImagePath.userEdit,
                    controller: profileController.nameController,
                    keyboardType: TextInputType.text,
                    labelText: "Name".tr,
                    validator: (value) {
                      return Validator.validateName(value!, "Name");
                    },
                  ),
                  verticalSpace(20),
                  CommonTextField(
                    prefix: ImagePath.emailIcn,
                    controller: profileController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: "Email".tr,
                    validator: (value) {
                      return Validator.validateEmail(value!);
                    },
                  ),
                  verticalSpace(20),
                  CommonTextField(
                    prefix:ImagePath.phoneIcn,
                    controller: profileController.phoneController,
                    keyboardType: TextInputType.phone,
                    labelText: "Phone".tr,
                    validator: (value) {
                      return Validator.validateMobile(value!);
                    },
                  ),
                  verticalSpace(20),
                  CommonButton(
                    title: "Save Changes".tr,
                    onPressed: () {
                      if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                        commonToast(AppConstant.demoString);
                      } else {
                        if(formKey.currentState!.validate())
                          {
                            profileController.saveProfileData(
                                email: profileController.emailController.text.trim(),
                                name: profileController.nameController.text.trim(),
                                phoneNo: profileController.phoneController.text.trim(),
                                avatar: profileController.imagePath.value);
                          }

                      }
                    },
                  )
                                    ],
                                  ),
                ),
          ),
        ),
      ),
    );
  }

  void showImagePickerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageWidget(
                  title: "Camera".tr,
                  iconData: Icons.camera_alt,
                  imageSource: ImageSource.camera),
              horizontalSpace(35),
              imageWidget(
                  title: "Gallery".tr,
                  iconData: Icons.photo,
                  imageSource: ImageSource.gallery),
            ],
          ),
        );
      },
    );
  }


  ImageProvider profileImage()
  {
    return profileController.imagePath.value.isNotEmpty
        ? FileImage(File(profileController.imagePath.value))
        : Image(image: profileController.profileImage.value.isNotEmpty
        ? CachedNetworkImageProvider(profileController.profileImage.value)
        :AssetImage(ImagePath.placeholder) as ImageProvider).image;
  }

  Widget imageWidget({ImageSource? imageSource, String? title, IconData? iconData}) {
    return GestureDetector(
      onTap: () {
        profileController.pickImage(imageSource: imageSource!);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, color: AppColor.cDarkGreyFont, size: 55),
          verticalSpace(8),
          Text(title!, style: pSemiBold19.copyWith(color: AppColor.cDarkGreyFont))
        ],
      ),
    );
  }

}