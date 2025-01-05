import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/auth/change_password_controller.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/images.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ticket/validator.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_button.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      appBar: AppBar(
        backgroundColor: AppColor.cBackGround,
        elevation: 1,
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_back,
            color: AppColor.cLabel,
          ),
          onPressed: () => {Get.back(result: {
            "profileImage":Prefs.getString(AppConstant.profileImage)
          })},
        ),
        title: Text(
          "Change Password".tr,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColor.cLabel),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Obx(() => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(30),
                  CommonTextField(
                    prefix: DefaultImages.lockIcn,
                    controller: changePasswordController.oldPassword,
                    labelText: 'Old password',
                    hintText: 'Enter old password',
                    obscureText: changePasswordController.isOldPass.value,
                    obscuringCharacter: "*",
                    onChanged: (value) {
                      Validator.validateRequired(value,string: "Old Password");
                    },
                    validator: (value) {
                      return Validator.validateRequired(value,string: "Old Password");
                    },
                    suffix: GestureDetector(
                      onTap: () {
                        changePasswordController.isOldPass.value = !changePasswordController.isOldPass.value;
                      },
                      child: Icon(
                        changePasswordController.isOldPass.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColor.cDarkGreyFont,
                      ),
                    ),
                  ),
                  verticalSpace(16),
                  CommonTextField(
                    prefix: DefaultImages.lockIcn,
                    controller: changePasswordController.newPassword,
                    labelText: 'New password',
                    hintText: 'Enter new password',
                    obscureText: changePasswordController.isNewPass.value,
                    obscuringCharacter: "*",
                    onChanged: (value) {
                      Validator.validateRequired(value,string: "New Password");
                    },
                    validator: (value) {
                      return Validator.validateRequired(value,string: "New Password");
                    },
                    suffix: GestureDetector(
                      onTap: () {
                        changePasswordController.isNewPass.value = !changePasswordController.isNewPass.value;
                      },
                      child: Icon(
                        changePasswordController.isNewPass.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColor.cDarkGreyFont,
                      ),
                    ),
                  ),
                  verticalSpace(16),
                  CommonTextField(
                    prefix: DefaultImages.lockIcn,
                    controller: changePasswordController.confirmPassword,
                    labelText: 'Confirm password',
                    hintText: 'Enter confirm password',
                    obscureText:
                        changePasswordController.isConfirmPass.value,
                    obscuringCharacter: "*",
                    onChanged: (value) {
                      Validator.validateConfirmPassword(
                          value, changePasswordController.newPassword.text);
                    },
                    validator: (value) {
                      return Validator.validateConfirmPassword(value!,
                          changePasswordController.newPassword.text);
                    },
                    suffix: GestureDetector(
                      onTap: () {
                        changePasswordController.isConfirmPass.value = !changePasswordController.isConfirmPass.value;
                      },
                      child: Icon(
                        changePasswordController.isConfirmPass.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColor.cDarkGreyFont,
                      ),
                    ),
                  ),
                  verticalSpace(35),
                  CommonButton(
                    title: 'Save change',
                    onPressed: () {
                      if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                        commonToast(AppConstant.demoString);
                      } else {
                        if (formKey.currentState!.validate()) {
                          changePasswordController.changePassword(
                              oldPassword: changePasswordController.oldPassword.text.trim(),
                              newPassword: changePasswordController.newPassword.text.trim(),
                              confirmPassword: changePasswordController.confirmPassword.text.trim());
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
}
