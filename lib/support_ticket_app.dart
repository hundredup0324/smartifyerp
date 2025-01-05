// ignore_for_file: avoid_print, must_be_immutable, prefer_const_constructors



import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/ticket/theme_controller.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/locale_string.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/pages/ticket/auth/welcome_screen.dart';
import 'package:attendance/views/pages/attendence/menu_screen.dart';
import 'package:attendance/core/controller/auth/login_controller.dart';

import 'package:attendance/views/pages/ticket/dashboard_manager_screen/dashboard_manager_screen.dart';

class SupportTicketApp extends StatelessWidget {
  SupportTicketApp({super.key});

  ThemeController themeController = Get.put(ThemeController());
  UserLoginController userLoginController = Get.put(UserLoginController());

  @override
  Widget build(BuildContext context) {
    String languageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == '' ? 'en' : Prefs.getString(AppConstant.LANGUAGE_CODE);
    String countryCode = Prefs.getString(AppConstant.COUNTRY_CODE) == '' ? 'US' : Prefs.getString(AppConstant.COUNTRY_CODE);
    Locale locale = Locale(languageCode, countryCode);

    getToken() async {
      await dotenv.load(fileName: "asset/.env");
      String isDemoMode = dotenv.get(AppConstant.isDemoMode);
      Prefs.setBool(AppConstant.isDemoMode, bool.parse(isDemoMode));
      print("isDemo111========> $isDemoMode = ${Prefs.getBool(AppConstant.isDemoMode)}");
      String accessToken = await Prefs.getToken();
      print("accessToken===> $accessToken");
      FirebaseMessaging.instance.getToken().then((token) {
        print("Device token---->($token)");
      });
      return accessToken;
    }

    return GetBuilder(
        init: ThemeController(),
        builder: (themeController) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeController.theme,
            translations: LocaleString(),
            locale: locale,
            home: FutureBuilder(
                future: getToken(),
                builder: (context, AsyncSnapshot snapshot) {
                  print("111 ${snapshot.hasData}");
                  print("222 ${snapshot.data}");
                  if (snapshot.hasData && snapshot.data != '') {
                    print("===>> true");
                    return MenuScreen();
                  } else {
                    print("===false");
                    return LoginScreen();
                  }
                }),
          );
        });
  }
}
