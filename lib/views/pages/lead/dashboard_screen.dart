import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/lead/dashboard_controller.dart';
import 'package:attendance/utils/app_color.dart';

class DashBoardScreenLead extends StatelessWidget {
  const DashBoardScreenLead({super.key});

  @override
  Widget build(BuildContext context) {
    final LeadDashboardController leadController  =
         Get.put(LeadDashboardController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.appBackgroundColor,
        body: Obx(() {
          return leadController
              .itemList[leadController.currantIndex.value]['screen'];
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: leadController.currantIndex.value,
            onTap: (value) {
              leadController.currantIndex.value = value;
            },
            backgroundColor: AppColor.cLabel,
            selectedItemColor: AppColor.primaryColor,
            unselectedLabelStyle: TextStyle(
              color: AppColor.cWhite,
            ),
            unselectedItemColor: Colors.white,
            unselectedIconTheme: IconThemeData(color: AppColor.cWhite),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: List.generate(leadController.itemList.length, (index) {
              var data = leadController.itemList[index];
              return BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  data["icon"],
                  colorFilter: ColorFilter.mode(
                      index == leadController.currantIndex.value
                          ? AppColor.themeGreenColor
                          : AppColor.cWhite,
                      BlendMode.srcIn),
                ),
                label: data["title"],
              );
            }),
          ),
        ),
      ),
    );
  }
}
