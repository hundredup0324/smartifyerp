import 'package:attendance/core/controller/auth/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/main_screen.dart';
import 'package:attendance/core/controller/attendence/setting_controller.dart';

class MenuScreen extends StatelessWidget {

   MenuScreen({super.key});
   UserLoginController loginController = Get.put(UserLoginController());
   final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: <Widget>[
            settingController.userRole.indexOf("stuff")!=null
                ?MenuListItem(
              title: "Employee",
              description: "Manage attendance, leaves and see Company Event",
              iconData: Icons.people,
              cardColor: const Color(0xFFE3F2FD),
              iconColor: const Color(0xFF2196F3),
              onTap: () {
                Get.offAll(() => MainScreen(screenIndex: 0));
              },
            ): SizedBox(),
            settingController.userRole.indexOf("stuff")!=null
                ?const SizedBox(height: 16):SizedBox(),
            MenuListItem(
              title: "CRM",
              description: "Manage customer data, track interactions, and handle sales leads.",
              iconData: Icons.phone,
              cardColor: const Color(0xFFFFF3E0),
              iconColor: const Color(0xFFFF9800),
              onTap: () {
                Get.offAll(() => MainScreen(screenIndex: 1));
              },
            ),
            const SizedBox(height: 16),

            MenuListItem(
              title: "Project Manager",
              description: "Track projects, assign tasks, set deadlines, and monitor progress.",
              iconData: Icons.folder,
              cardColor: const Color(0xFFE8F5E9),
              iconColor: const Color(0xFF4CAF50),
              onTap: () {
                Get.offAll(() => MainScreen(screenIndex: 2));
              },
            ),
            const SizedBox(height: 16),

            // MenuListItem(
            //   title: "Sales",
            //   description: "Sales activities, track revenue, and monitor sales performance.",
            //   iconData: Icons.monetization_on,
            //   cardColor: const Color(0xFFFFEBEE),
            //   iconColor: const Color(0xFFF44336),
            //   onTap: () {
            //     Get.offAll(() => MainScreen(screenIndex: 3));
            //   },
            // ),
            // const SizedBox(height: 16),
            MenuListItem(
              title: "Helpdesk Support",
              description: "Handle customer inquiries, manage support tickets, and resolve issues.",
              iconData: Icons.support_agent,
              cardColor: const Color(0xFFF3E5F5),
              iconColor: const Color(0xFF9C27B0),
              onTap: () {
                Get.offAll(() => MainScreen(screenIndex: 3));
              },
            ),
            const SizedBox(height: 16),
            MenuListItem(
              title: "Settings",
              description: "Edit profile, manage workspace configurations.",
              iconData: Icons.settings,
              cardColor: const Color(0xFFFFFDE7),
              iconColor: const Color(0xFFFFC107),
              onTap: () {
                Get.offAll(() => MainScreen(screenIndex: 4));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  final Color cardColor;
  final Color iconColor;
  final Function()? onTap;

  const MenuListItem({
    super.key,
    required this.title,
    required this.description,
    required this.iconData,
    required this.cardColor,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor, // Card background color
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1), // Light icon background
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),

            // Title and Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the left
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF212121), // Dark text color
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 8), // Spacing between title and description
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF757575), // Grey text for description
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                    softWrap: true, // Ensures text wraps within the container
                    overflow: TextOverflow.clip, // Prevents text overflow
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
