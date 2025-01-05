// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/core/model/login_response.dart';
import 'package:attendance/network_dio/network_dio_ticket.dart';
import 'package:attendance/utils/base_api_ticket.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/pages/ticket/dashboard_manager_screen/dashboard_manager_screen.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/loading_widget.dart';

String defaultLanguageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == ''
    ? 'en'
    : Prefs.getString(AppConstant.LANGUAGE_CODE);

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString deviceToken = "".obs;
  RxString deviceType = "".obs;
  RxBool isObscure = true.obs;
  RxInt selectedLanguageIndex = 0.obs;
  RxString selectedLanguage = "English".obs;
  RxString languageCode = defaultLanguageCode.obs;
  RxString countryCode = "US".obs;
  RxList workspaceList=<workspace>[].obs;

  RxList languageList = [
    {
      'title': "English",
      "local": Locale("en", "US"),
      "languageCode": "en",
      "countryCode": "US"
    }.obs, //en_US //English
    {
      'title': "Arabic",
      "local": Locale("ar", "DZ"),
      "languageCode": "ar",
      "countryCode": "DZ"
    }.obs, //ar_DZ //Arabic
    {
      'title': "Chinese",
      "local": Locale("zh", "CN"),
      "languageCode": "zh",
      "countryCode": "CN"
    }.obs, //zh_CN //Chinese
    {
      'title': "Danish",
      "local": Locale("da", "DK"),
      "languageCode": "da",
      "countryCode": "DK"
    }.obs, //da_DK //Danish
    {
      'title': "German",
      "local": Locale("de", "DE"),
      "languageCode": "de",
      "countryCode": "DE"
    }.obs, //de_DE //German
    {
      'title': "Spanish",
      "local": Locale("es", "ES"),
      "languageCode": "es",
      "countryCode": "ES"
    }.obs, //es_ES //Spanish
    {
      'title': "French",
      "local": Locale("fr", "FR"),
      "languageCode": "fr",
      "countryCode": "FR"
    }.obs, //fr_FR //French
    {
      'title': "Hebrew",
      "local": Locale("he", "IL"),
      "languageCode": "he",
      "countryCode": "IL"
    }.obs, //he_IL //Hebrew
    {
      'title': "Italian",
      "local": Locale("it", "IT"),
      "languageCode": "it",
      "countryCode": "IT"
    }.obs, //it_IT //Italian
    {
      'title': "Japanese",
      "local": Locale("ja", "JP"),
      "languageCode": "ja",
      "countryCode": "JP"
    }.obs, //ja_JP //Japanese
    {
      'title': "Dutch",
      "local": Locale("nl", "NL"),
      "languageCode": "nl",
      "countryCode": "NL"
    }.obs, //nl_NL //Dutch
    {
      'title': "Polish",
      "local": Locale("pl", "PL"),
      "languageCode": "pl",
      "countryCode": "PL"
    }.obs, //pl_PL //Polish
    {
      'title': "Portuguese",
      "local": Locale("pt", "PT"),
      "languageCode": "pt",
      "countryCode": "PT"
    }.obs, //pt_PT //Portuguese
    {
      'title': "Russian",
      "local": Locale("ru", "RU"),
      "languageCode": "ru",
      "countryCode": "RU"
    }.obs, //ru_RU //Russian
    {
      'title': "Turkish",
      "local": Locale("tr", "TR"),
      "languageCode": "tr",
      "countryCode": "TR"
    }.obs, //tr_TR //Turkish
  ].obs;

  updateLanguage(Locale locale) {
    print("================$locale");
    Get.updateLocale(locale);
    Prefs.setString(AppConstant.LANGUAGE_CODE, locale.languageCode);
    Prefs.setString(AppConstant.COUNTRY_CODE, locale.countryCode.toString());
  }

  authLogin({
    required String email,
    required String password,
    required String deviceType,
    required String deviceToken,
  }) async {
    Loader.showLoader();
    var response =await  NetworkHttps.postRequest(API.loginUrl,{'email': email, 'password': password});
      if (response['status'] == 1) {
        print('=====> ${response['data']['token']}');
        print('id=====> ${response['data']['user']['id']}');
        var loginResponse =LoginResponse.fromJson(response);
        print("workspace ${jsonDecode(loginResponse.data!.workspaces!.length.toString())}");
        workspaceList.value=loginResponse.data!.workspaces!;
        Prefs.setToken(response['data']['token']??"");
        Prefs.setUserID(response['data']['user']['id'].toString()??"");
        Prefs.setString(AppConstant.userName, response['data']['user']['name']??"");
        Prefs.setString(AppConstant.emailId, response['data']['user']['email']??"");
        Prefs.setString(AppConstant.role, response['data']['user']['type']??'');
        Prefs.setString(AppConstant.phoneNo, response['data']['user']['mobile_no']??"");
        Prefs.setString(AppConstant.workspaceId, response['data']['user']['active_workspace'].toString()??"");
        Prefs.setString(AppConstant.workspaceArray, jsonEncode(loginResponse.data!.workspaces!));
        Prefs.setString(AppConstant.profileImage, response['data']['user']['avatar']??"");
        print('=====> ${Prefs.getToken()}');
        print('=====> ${Prefs.getUserID()}');
        commonToast(response['data']['user']['name'] + " Login successfully");

        Get.offAll(() => DashBoardManagerScreen(currantIndex: 2));
      } else {
        Loader.hideLoader();
        commonToast(response["message"]);
      }

  }
}
