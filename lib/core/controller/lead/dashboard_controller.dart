// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:attendance/views/pages/lead/home_screen.dart';
import 'package:attendance/views/pages/lead/lead_screen.dart';

import 'package:attendance/views/pages/lead/settings_screen.dart';

class LeadDashboardController extends GetxController {
  RxInt currantIndex = 0.obs;
  List itemList = [
    {
      "icon": "asset/image/svg_image/home.svg",
      "screen": HomeScreen(),
      "title": "Dashboard",
    },
    {
      "icon": "asset/image/svg_image/ic_lead.svg",
      "screen": LeadScreen(),
      "title": "Leads"
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
