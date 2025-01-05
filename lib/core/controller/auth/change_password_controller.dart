// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:attendance/config/repository/change_password_repository.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/prefer.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordRepository changePasswordRepository = ChangePasswordRepository();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool isOldPass = true.obs;
  RxBool isNewPass = true.obs;
  RxBool isConfirmPass = true.obs;

  changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    Loader.showLoader();
    var response = await changePasswordRepository.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
    print("response===>$response");
    if (response != null) {
      if (response['status'] == 1) {
        commonToast(response['message']);
        Loader.hideLoader();
      } else if (response['status'] == 9) {
        await Prefs.clear();
        Get.offAll(() => LoginScreen());
      } else {
        Loader.hideLoader();
        commonToast(response['message']);
      }
    }
  }
}
