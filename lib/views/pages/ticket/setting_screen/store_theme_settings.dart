// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:attendance/core/controller/ticket/theme_controller.dart';
import 'package:attendance/utils/images.dart';
import '../../../widgets/common_button.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:attendance/core/controller/ticket/theme_controller.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_appbar_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

class StoreThemeSettingScreen extends StatelessWidget {
  StoreThemeSettingScreen({super.key});

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ThemeController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColor.cBackGround,
          appBar: simpleAppBar(title: "Store Theme Setting"),
          body: SafeArea(
            child: Obx(
              () {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      Row(
                        children: [
                          assetSvdImageWidget(
                            image: DefaultImages.themeIcn,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(AppColor.cLabel, BlendMode.srcIn)
                          ),
                          horizontalSpace(10),
                          Text(
                            "Layout Settings",
                            style: pSemiBold16,
                          ),
                        ],
                      ),
                      verticalSpace(10),
                      horizontalDivider(),
                      verticalSpace(10),
                      Row(
                        children: [
                          CupertinoSwitch(
                            value: themeController.isDark.value,
                            onChanged: (value) {
                              themeController.isDark.value = value;
                            },
                            activeColor: AppColor.themeGreenColor,
                          ),
                          horizontalSpace(10),
                          Text(
                            "Dark Layout",
                            style: pMedium14,
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      CommonButton(
                        title: "Save",
                        onPressed: () {
                          themeController
                              .changeTheme(themeController.isDark.value);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
