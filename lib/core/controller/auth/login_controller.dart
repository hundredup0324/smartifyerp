import 'dart:convert';

import 'package:attendance/core/model/login_response.dart';
import 'package:attendance/network_dio/network_dio.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/pages/attendence/dashboard_screen.dart';
import 'package:attendance/views/pages/attendence/menu_screen.dart';
import 'package:attendance/views/pages/attendence/home%20_screen.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../utils/base_api.dart';
import 'package:http/http.dart' as http;

String defaultLanguageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == '' ? 'en' : Prefs.getString(AppConstant.LANGUAGE_CODE);

class UserLoginController extends GetxController  {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxList workspaceList=<workspace>[].obs;
  // static const String userRole="userRole";
  RxBool isHiddenPassword = true.obs;
  List<String> userRole = [];
  @override
  void onInit() {
    super.onInit();

    emailController.clear();
    passwordController.clear();


  }



  authLogin({required String email, required String password}) async {
    Loader.showLoader();

    var response = await  NetworkHttps.postRequest(API.loginLink,{'email': email, 'password': password});

    if(response['status']==1)
      {
        var loginResponse =LoginResponse.fromJson(response);
        print("workspace ${jsonDecode(loginResponse.data!.workspaces!.length.toString())}");
        print("userRole ${loginResponse.data!.role}");

        workspaceList.value=loginResponse.data!.workspaces!;
        print("workspace1 ${jsonDecode(workspaceList.length.toString())}");
        Prefs.setString(AppConstant.workspaceArray, jsonEncode(loginResponse.data!.workspaces!));

        Prefs.setToken(loginResponse.data!.token??"");
        Prefs.setUserID(loginResponse.data!.user!.id.toString());
        Prefs.setString(AppConstant.userName, loginResponse.data!.user!.name??"");
        Prefs.setRole(
            AppConstant.userRole,loginResponse.data!.role??[]
        );


        Prefs.setString(AppConstant.emailId,loginResponse.data!.user!.email??"");
        Prefs.setString(AppConstant.phoneNo, loginResponse.data!.user!.mobileNo??"");
        Prefs.setString(AppConstant.profileImage, loginResponse.data!.user!.avatar??"");
        Prefs.setString(AppConstant.userType,loginResponse.data!.user!.type??"");
        Prefs.setString(AppConstant.workspaceId,loginResponse.data!.user!.activeworkspace.toString()??"");
        // Get.offAll(() => DashboardScreen());

        Get.offAll(() => MenuScreen());
        commonToast(loginResponse.data!.user!.name ??"" " Login successfully");
        Loader.hideLoader();
      } else {
          Loader.hideLoader();
          commonToast(response["message"]);
        }

  }


}