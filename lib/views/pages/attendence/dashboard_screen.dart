import 'package:attendance/core/controller/attendence/dashboard_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/attendence/setting_controller.dart';


class DashboardScreen extends StatelessWidget {

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final DashboardController dashboardController = Get.put(DashboardController());
  final SettingController settingController = Get.put(SettingController());
    return Scaffold(
      body: Obx(() {
        if (settingController.userRole.contains("staff")){
          return dashboardController
              .itemList[dashboardController.currantIndex.value]['screen'];
        } else {
          return dashboardController
              .itemList1[dashboardController.currantIndex.value]['screen'];
        }

      }),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: dashboardController.currantIndex.value,
          onTap: (value) {
            dashboardController.currantIndex.value = value;
          },
          backgroundColor: AppColor.cLabel,
          selectedItemColor: AppColor.primaryColor,
          // unselectedLabelStyle: TextStyle(
          //   color: AppColor.cWhite,
          // ),
          // unselectedItemColor: Colors.white,
          // unselectedIconTheme: IconThemeData(color: AppColor.cWhite),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: List.generate(settingController.userRole.contains("staff")?dashboardController.itemList.length:dashboardController.itemList1.length, (index) {
            var data = settingController.userRole.contains("staff")?dashboardController.itemList[index]:dashboardController.itemList1[index];
            return BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  data["icon"],
                  colorFilter: ColorFilter.mode(
                      index == dashboardController.currantIndex.value
                          ? AppColor.themeGreenColor
                          : AppColor.cWhite,
                      BlendMode.srcIn),
                ),
                label: "");
          }),
        ),
      ),
    );
  }
}
