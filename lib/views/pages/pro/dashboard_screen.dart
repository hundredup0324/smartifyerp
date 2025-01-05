import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/project/dashboard_controller.dart';
import 'package:attendance/utils/app_color.dart';

class DashboardScreenPro extends StatelessWidget {
  const DashboardScreenPro({super.key});

  @override
  Widget build(BuildContext context) {
    final ProDashboardController dashboardController =
        Get.put(ProDashboardController());

    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: Obx(() {
        return dashboardController
            .itemList[dashboardController.currantIndex.value]['screen'];
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
          unselectedLabelStyle: TextStyle(color: AppColor.cWhite,),
          unselectedItemColor: Colors.white,
          unselectedIconTheme: IconThemeData(color: AppColor.cWhite),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: List.generate(dashboardController.itemList.length, (index) {
            var data = dashboardController.itemList[index];
            return BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  data["icon"],
                  colorFilter: ColorFilter.mode(
                      index == dashboardController.currantIndex.value
                          ? AppColor.themeGreenColor
                          : AppColor.cWhite,
                      BlendMode.srcIn),
                ),

                label: data["title"],);
          }),
        ),
      ),
    );
  }
}
