// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
// import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/bar_item.dart';
import 'package:attendance/core/controller/ticket/dashboard_manager_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';

class DashBoardManagerScreen extends StatefulWidget {
  final int currantIndex;

  DashBoardManagerScreen({Key? key, this.currantIndex = 0}) : super(key: key);

  @override
  State<DashBoardManagerScreen> createState() => _DashBoardManagerScreenState();
}

class _DashBoardManagerScreenState extends State<DashBoardManagerScreen> {
  DashBoardManagerController dashboardManagerController = Get.put(DashBoardManagerController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dashboardManagerController.currantIndex.value = widget.currantIndex;
      print("-------->${dashboardManagerController.currantIndex.value}");
      print("-------->${Prefs.getUserID()}");
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Obx(() {
  //
  //     return Scaffold(
  //       backgroundColor: AppColor.cBackGround,
  //       body: SafeArea(
  //           bottom: false,
  //           child: dashboardManagerController.itemList[dashboardManagerController.currantIndex.value]['screen']),
  //       bottomNavigationBar: CustomConvexAppBar(
  //         backgroundColor: AppColor.cBottomNavyBlueColor,
  //         color: AppColor.cDarkGreyFont,
  //         activeColor: AppColor.cWhite,
  //         height: 65,
  //         style: TabStyle.fixedCircle,
  //         top: -35,
  //         curve: Curves.easeOut,
  //         initialActiveIndex: dashboardManagerController.currantIndex.value,
  //         disableDefaultTabController: false,
  //         items: dashboardManagerController.itemList.map((element) {
  //           return CustomTabItem(icon: element['icon'], title: element['title']);
  //         }).toList(),
  //         onTap: (index) {
  //           dashboardManagerController.currantIndex.value = index;
  //           print('click index=$index');
  //         },
  //       ),
  //     );
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final DashBoardManagerController dashboardController = Get.put(DashBoardManagerController());

    return Scaffold(
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
          // unselectedLabelStyle: TextStyle(
          //   color: AppColor.cWhite,
          // ),
          // unselectedItemColor: Colors.white,
          // unselectedIconTheme: IconThemeData(color: AppColor.cWhite),
          showSelectedLabels: false,
          showUnselectedLabels: false,
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
                label: "");
          }),
        ),
      ),
    );
  }
}
