// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/config/repository/logout_repository.dart';
import 'package:attendance/core/model/login_response.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import '../../../views/widgets/common_snak_bar_widget.dart';
import 'auth_controller.dart';

class SettingControllerTicket extends GetxController {
  LogoutRepository logoutRepository = LogoutRepository();
  RxString profileImage=''.obs;
  RxString name=''.obs;
  RxString email=''.obs;
  RxBool isDarkTheme = false.obs;
  // String defaultLanguageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == ''
  //     ? 'en'
  //     : Prefs.getString(AppConstant.LANGUAGE_CODE);
  RxBool isRtl = false.obs;
 RxString languageCode=defaultLanguageCode.obs;
  RxString workspaceId = Prefs.getString(AppConstant.workspaceId).toString().obs;
  RxInt selectedworkspaceId=0.obs;
  RxList<workspace>  workspaceList=<workspace>[].obs;


  @override
  void onInit() {
    super.onInit();
    isRtl.value= languageCode.value == 'ar' ?true :false;
    profileImage.value=Prefs.getString(AppConstant.profileImage);
    name.value=Prefs.getString(AppConstant.userName);
    email.value=Prefs.getString(AppConstant.emailId);
  }


  updateLanguage(Locale locale) {
    Get.updateLocale(locale);
    Prefs.setString(AppConstant.LANGUAGE_CODE, locale.languageCode);
  }


  deleteUser() async {
    Loader.showLoader();
    var response = await logoutRepository.deleteUser();
    if (response['status'] == 1) {
      Prefs.clear();
      Get.deleteAll();
      Get.offAll(()=> LoginScreen());
      commonToast(response['message']);
    } else if (response['status'] == 0) {
      commonToast(response['message']);
    } else {
      commonToast(response['message']);
    }
    Loader.hideLoader();
  }

  logOutData() async {
    Loader.showLoader();
    var response = await logoutRepository.logOutFun();
    print("response--->$response");
    if (response['status'] == 1) {
      Prefs.clear();
      Get.deleteAll();

      Get.offAll(LoginScreen());
      commonToast(response['message']);
      Loader.hideLoader();
    } else if (response['status'] == 9) {
      Prefs.clear();
      Get.deleteAll();
      Get.offAll(() => LoginScreen());
      commonToast(response['message']);
    } else {
      commonToast(response['message']);
    }
  }
}
