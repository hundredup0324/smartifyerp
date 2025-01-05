import 'package:attendance/views/pages/attendence/attendance_history.dart';
import 'package:attendance/views/pages/attendence/event_calender.dart';
import 'package:attendance/views/pages/attendence/home%20_screen.dart';
import 'package:attendance/views/pages/attendence/leave_history.dart';
import 'package:attendance/views/pages/attendence/setting_screen.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt currantIndex = 0.obs;
  List itemList = [
    {
      "icon": "asset/image/svg_image/home.svg",
      "screen":  HomeScreen()
    },
    {
      "icon": "asset/image/svg_image/ic_history.svg",
      "screen":  LeaveHistory()
    },
    {
      "icon": "asset/image/svg_image/ic_attendance_history.svg",
      "screen":  AttendanceHistory()
    },
    {
      "icon": "asset/image/svg_image/ic_holiday.svg",
      "screen":  EventCalender()
    },
    // {
    //   "icon": "asset/image/svg_image/ic_settings.svg",
    //   "screen":  SettingScreen()
    // },
  ];
  List itemList1 = [
    {
      "icon": "asset/image/svg_image/ic_history.svg",
      "screen":  LeaveHistory()
    },
    {
      "icon": "asset/image/svg_image/ic_attendance_history.svg",
      "screen":  AttendanceHistory()
    },
    {
      "icon": "asset/image/svg_image/ic_holiday.svg",
      "screen":  EventCalender()
    },
    // {
    //   "icon": "asset/image/svg_image/ic_settings.svg",
    //   "screen":  SettingScreen()
    // },
  ];

  @override
  void onInit() {
    currantIndex=0.obs;
    super.onInit();
  }
}
