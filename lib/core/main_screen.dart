import 'dart:ffi';

import 'package:attendance/core/main_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/views/pages/attendence/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/core/controller/attendence/setting_controller.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/views/pages/attendence/menu_screen.dart';
import 'package:http/http.dart';

class MainScreen extends StatelessWidget {
  final int screenIndex;

  MainScreen({
    super.key,
    required this.screenIndex,
  });

  @override
  Widget build(BuildContext context) {
    final MainController dashboardController = Get.put(MainController());
    final SettingController settingController = Get.put(SettingController());
    dashboardController.currantIndex.value = screenIndex;

    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          Obx(() {
            return dashboardController
                .itemList[dashboardController.currantIndex.value]['screen'];
          }),
          // Left Drawer Button
          Positioned(
            top: 30,
            left: 16,
            child: Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.menu,
                        color: Colors.grey[800],
                        size: 24,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Header Section
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: settingController.profileImage.value != ""
                            ? CachedNetworkImageProvider(settingController.profileImage.value)
                            : Image.asset(ImagePath.placeholder).image,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        settingController.name.value,
                        style: TextStyle(
                          color: AppColor.cWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 0),
                      Text(
                        settingController.email.value,
                        style: TextStyle(
                          color: AppColor.cWhite.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),

            // Menu Items
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(
                    context,
                    title: "Menu",
                    icon: Icons.home,
                    iconColor: AppColor.primaryColor,
                    onTap: () => Get.offAll(() => MenuScreen()),
                  ),
                  _buildMenuItem(
                    context,
                    title: "Employee",
                    icon: Icons.people,
                    iconColor: AppColor.primaryColor,
                    onTap: () => dashboardController.currantIndex.value = 0,
                  ),
                  _buildMenuItem(
                    context,
                    title: "CRM",
                    icon: Icons.phone,
                    iconColor: AppColor.primaryColor,
                    onTap: () => dashboardController.currantIndex.value = 1,
                  ),
                  _buildMenuItem(
                    context,
                    title: "Project Management",
                    icon: Icons.folder,
                    iconColor: AppColor.primaryColor,
                    onTap: () => dashboardController.currantIndex.value = 2,
                  ),
                  // _buildMenuItem(
                  //   context,
                  //   title: "Sales",
                  //   icon: Icons.monetization_on,
                  //   iconColor: AppColor.primaryColor,
                  //   onTap: () => dashboardController.currantIndex.value = 3,
                  // ),
                  _buildMenuItem(
                    context,
                    title: "Helpdesk Support",
                    icon: Icons.support_agent,
                    iconColor: AppColor.primaryColor,
                    onTap: () => dashboardController.currantIndex.value = 4,
                  ),


                  // Settings
                  _buildMenuItem(
                    context,
                    title: "Settings",
                    iconColor: AppColor.primaryColor,
                    icon: Icons.settings,
                    onTap: () => dashboardController.currantIndex.value = 5,
                  ),
                  const Divider(),
                  // Logout
                  _buildMenuItem(
                    context,
                    title: "Logout",
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: () {
                      if (Prefs.getBool(AppConstant.isDemoMode)) {
                        Get.offAll(() => LoginScreen());
                      } else {
                        settingController.logOutData();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, {
        required String title,
        required IconData icon,
        Color? iconColor,
        Color textColor = Colors.black,
        required Function() onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        onTap();
      },
    );
  }
}
