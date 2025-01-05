// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:attendance/core/controller/ticket/auth_controller.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_appbar_widget.dart';
import 'package:attendance/views/widgets/common_button.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';


class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      appBar: simpleAppBar(title: "Change Language"),
      body: SafeArea(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: ListView.builder(
                    itemCount: authController.languageList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = authController.languageList[index];
                      return Obx(() {
                        return GestureDetector(
                            onTap: () {
                              authController.selectedLanguageIndex.value =
                                  index;
                              authController.selectedLanguage.value =
                                  data['title'];
                              authController.selectedLanguageIndex.refresh();
                              authController.languageCode.value =
                                  data['languageCode'];
                              authController.countryCode.value =
                                  data['countryCode'];
                              print("++${data['local']}");
                            },
                            child: languageWidget(
                              title: data['title'],
                              color: data['languageCode'] ==
                                      authController.languageCode.value
                                  ? AppColor.themeGreenColor
                                  : AppColor.cWhite,
                              bColor: data['languageCode'] ==
                                      authController.languageCode.value
                                  ? AppColor.themeGreenColor
                                  : AppColor.cBorder,
                            ));
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CommonButton(
                  onPressed: () {
                    if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                      commonToast(AppConstant.demoString);
                    } else{
                      authController.updateLanguage(Locale(
                          authController.languageCode.value,
                          authController.countryCode.value));
                    }
                  },
                  title: "Save",
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

Widget languageWidget({String? title, Color? color, Color? bColor}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Container(
      height: 55,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: bColor ?? AppColor.cBorder)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title!,
                style: pMedium14,
              ),
            ],
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                border: Border.all(color: bColor ?? AppColor.cBorder, width: 1),
                shape: BoxShape.circle),
            padding: EdgeInsets.all(01.5),
            child: CircleAvatar(
              backgroundColor: color ?? AppColor.cWhite,
            ),
          ),
        ],
      ),
    ),
  );
}
