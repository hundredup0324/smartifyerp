import 'package:attendance/views/pages/attendence/dashboard_screen.dart';
import 'package:attendance/views/pages/lead/dashboard_screen.dart';
import 'package:attendance/views/pages/pro/dashboard_screen.dart';
import 'package:attendance/views/pages/sales/dashboard_screen.dart';
import 'package:attendance/views/pages/sales/settings_screen.dart';
import 'package:attendance/views/pages/ticket/dashboard_manager_screen/dashboard_manager_screen.dart';

import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currantIndex = 0.obs;
  List itemList = [
    {
      "icon": "asset/image/svg_image/ic_home.svg",
      "screen":  DashboardScreen()
    },
    {
      "icon": "asset/image/svg_image/ic_history.svg",
      "screen":  DashBoardScreenLead()
    },
    {
      "icon": "asset/image/svg_image/ic_attendance_history.svg",
      "screen":  DashboardScreenPro()
    },
    // {
    //   "icon": "asset/image/svg_image/ic_holiday.svg",
    //   "screen":  DashboardScreenSales()
    // },
    {
      "icon": "asset/image/svg_image/ic_settings.svg",
      "screen":  DashBoardManagerScreen()
    },
    {
      "icon": "asset/image/svg_image/ic_settings.svg",
      "screen":  SettingsScreen()
    },

  ];

  @override
  void onInit() {
    currantIndex=0.obs;
    super.onInit();
  }
}
