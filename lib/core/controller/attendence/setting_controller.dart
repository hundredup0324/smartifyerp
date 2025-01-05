
import 'package:attendance/config/repository/logout_repository.dart';
import 'package:attendance/core/controller/attendence/dashboard_controller.dart';
import 'package:attendance/core/controller/auth/login_controller.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SettingController extends GetxController
{

  LogoutRepository logoutRepository = LogoutRepository();
  RxBool isDarkTheme = false.obs;
  RxString profileImage=''.obs;
  RxString name=''.obs;
  RxString email=''.obs;
  RxList<String> userRole = <String>[].obs;

  RxBool isRtl = false.obs;
  RxString languageCode = defaultLanguageCode.obs;
  RxString workspaceId = Prefs.getString(AppConstant.workspaceId).toString().obs;
  RxInt selectedworkspaceId=0.obs;


  @override
  void onInit() {
    super.onInit();
    isRtl.value= languageCode.value == 'ar' ?true :false;
    profileImage.value=Prefs.getString(AppConstant.profileImage);
    name.value=Prefs.getString(AppConstant.userName);
    email.value=Prefs.getString(AppConstant.emailId);
    userRole.value = Prefs.getRole(AppConstant.userRole);
  }

  logOutData() async {
    Loader.showLoader();
    var response = await logoutRepository.logOutFun();
    print("response--->$response");
    if (response['status'] == 1) {
      Get.delete<DashboardController>();

      var isDemoMade=Prefs.getBool(AppConstant.isDemoMode);
      Prefs.clear();
      Prefs.setBool(AppConstant.isDemoMode, isDemoMade);
      Get.deleteAll();
      Get.offAll(LoginScreen());
      commonToast(response['message']);

      Loader.hideLoader();
    } else {
      commonToast(response['message']);
    }
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
}