// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:get/get.dart';
import 'package:attendance/views/pages/ticket/auth/change_password.dart';
import 'package:attendance/views/pages/ticket/workspace_screen.dart';
import 'edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/images.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:attendance/core/controller/ticket/auth_controller.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_appbar_widget.dart';
import 'package:attendance/core/controller/ticket/theme_controller.dart';
import 'package:attendance/core/controller/ticket/setting_controller.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/pages/ticket/setting_screen/store_theme_settings.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/pages/attendence/menu_screen.dart';
class SettingScreen extends StatelessWidget {

  SettingScreen({super.key});

  SettingControllerTicket settingController = Get.put(SettingControllerTicket());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ThemeController(),
        builder: (_) {
        return Scaffold(
          backgroundColor: AppColor.cBackGround,
          body: Column(
            children: [
              simpleAppBar( title: "Settings", isBack: false),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() {
                  if (settingController.languageCode.value == 'ar') {
                    settingController.isRtl.value = true;
                  } else {
                    settingController.isRtl.value = false;
                  }
                  print(settingController.isRtl.value);
                  return Column(
                    children: [
                      titleRowWidget(
                        icn: DefaultImages.userProfileIcn,
                        title: "Edit Profile",
                        onTap: () {
                          Get.to(() => EditProfileScreen());
                        },
                      ),
                      horizontalDivider(),

                      titleRowWidget(
                        icn: DefaultImages.themeIcn,
                        title: "Store Theme Settings",
                        onTap: () {
                          Get.to(() => StoreThemeSettingScreen());
                        },
                      ),
                      horizontalDivider(),

                      titleRowWidget(
                        icn: DefaultImages.rtlIcn,
                        title: "workspace",
                        onTap: () {
                          Get.to(() => workspaceScreen());
                        },
                      ),
                      horizontalDivider(),

                      titleRowWidget(
                        icn: DefaultImages.lockIcn,
                        title: "ChangePassword",
                        onTap: () {
                          Get.to(() => ChangePasswordScreen());
                        },
                      ),
                      Divider(height: 1,color: AppColor.divider_Color,),
                      verticalSpace(8),
                      titleRowWidget(
                        icn: DefaultImages.ic_next,
                        title: "Menu".tr,
                        onTap: () {
                          Get.to(() =>  MenuScreen());
                        },
                      ),
                      verticalSpace(8),

                      horizontalDivider(),
                      titleRowWidget(
                        icn: DefaultImages.logoutIcn,
                        title: "Logout",
                        onTap: () {
                          settingController.logOutData();
                        },
                      ),
                      horizontalDivider(),
                    ],
                  );
                }),
              )
            ],
          ),
        );
      }
    );
  }

  titleRowWidget({
    required String icn,
    required String title,
    Function()? onTap,
    bool?isNext=true
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        color: AppColor.cBackGround,
        padding: EdgeInsets.only(right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                assetSvdImageWidget(
                  image: icn,
                  height: 16,
                  width: 16,
                  colorFilter: ColorFilter.mode(
                    AppColor.cLabel,
                    BlendMode.srcIn,
                  ),
                ),
                horizontalSpace(10),
                Text(
                  title,
                  style: pSemiBold14,
                )
              ],
            ),
           isNext==false?SizedBox(): assetSvdImageWidget(image: DefaultImages.nextIcn,colorFilter: ColorFilter.mode(AppColor.cDarkGreyFont, BlendMode.srcIn,),),
          ],
        ),
      ),
    );
  }
}
