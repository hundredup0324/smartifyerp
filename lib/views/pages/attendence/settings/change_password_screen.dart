// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:attendance/core/controller/auth/change_password_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/common_text_field.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/views/widgets/common_button.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(

        backgroundColor: AppColor.cBackGround,
        appBar: AppBar(
          backgroundColor: AppColor.cWhite,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => {

              Get.back()

            },
          ),
          title: Text(
            "Change Password".tr,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColor.cBlack),
          ),
        ),        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Obx(() {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    CommonTextField(
                      prefix: ImagePath.lockIcn,

                      controller: changePasswordController.oldPassword,
                      labelText: 'Old password',
                      hintText: 'Enter old password',
                      obscureText:
                          changePasswordController.isOldPass.value,
                      obscuringCharacter: "*",
                      onChanged: (value) {
                        Validator.validateRequired(value);
                      },
                      validator: (value) {
                        return Validator.validateRequired(value!,name: "Old password");
                      },
                      suffix: GestureDetector(
                        onTap: () {
                          changePasswordController.isOldPass.value =
                              !changePasswordController.isOldPass.value;
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
                      prefix: ImagePath.lockIcn,

                      controller: changePasswordController.newPassword,
                      labelText: 'New password',
                      hintText: 'Enter new password',
                      obscureText:
                          changePasswordController.isNewPass.value,
                      obscuringCharacter: "*",
                      onChanged: (value) {
                        Validator.validateRequired(value);
                      },
                      validator: (value) {
                        return Validator.validateRequired(value!,name: "New password");
                      },
                      suffix: GestureDetector(
                        onTap: () {
                          changePasswordController.isNewPass.value =
                              !changePasswordController.isNewPass.value;
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
                      prefix: ImagePath.lockIcn,
                      controller:
                          changePasswordController.confirmPassword,
                      labelText: 'Confirm password',
                      hintText: 'Enter confirm password',
                      obscureText:
                          changePasswordController.isConfirmPass.value,
                      obscuringCharacter: "*",
                      onChanged: (value) {
                        Validator.validateConfirmPassword(value,
                            changePasswordController.newPassword.text);
                      },
                      validator: (value) {
                        return Validator.validateConfirmPassword(value!,
                            changePasswordController.newPassword.text);
                      },
                      suffix: GestureDetector(
                        onTap: () {
                          changePasswordController.isConfirmPass.value =
                              !changePasswordController
                                  .isConfirmPass.value;
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
              );
            }),
          ),
        ),
      ),
    );
  }
}
