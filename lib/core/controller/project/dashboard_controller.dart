// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:attendance/views/pages/pro/home_screen.dart';
import 'package:attendance/views/pages/pro/project/project_detail.dart';
import 'package:attendance/views/pages/pro/project/project_screen.dart';
import 'package:attendance/views/pages/pro/settings_screen.dart';

class ProDashboardController extends GetxController {
  RxInt currantIndex = 0.obs;
  List itemList = [
    {
      "icon": "asset/image/svg_image/home.svg",
      "screen": HomeScreen(),
      "title": "Dashboard",
    },
    {
      "icon": "asset/image/svg_image/ic_project.svg",
      "screen": ProjectScreen(),
      "title": "Project"
    },
    // {
    //   "icon": "asset/image/svg_image/ic_settings.svg",
    //   "screen": SettingsScreen(),
    //   "title": "Settings"
    // },
  ];

  @override
  void onInit() {
    currantIndex = 0.obs;
    super.onInit();
  }
}
