import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/ticket/setting_controller.dart';
import 'package:attendance/core/model/login_response.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_appbar_widget.dart';
import 'package:attendance/views/widgets/common_button.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';

class workspaceScreen extends StatelessWidget
{
  const workspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingControllerTicket settingController =Get.put(SettingControllerTicket());

    var jsonList = jsonDecode(Prefs.getString(AppConstant.workspaceArray));
    var workspaceList = jsonList.map((json) => workspace.fromJson(json)).toList();

    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      appBar: simpleAppBar(title: "workspace"),
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.all(14),
                child: ListView.builder(
                    itemCount: workspaceList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = workspaceList[index];

                      return Obx(() {
                        return GestureDetector(
                            onTap: () {
                              settingController.selectedworkspaceId.value = index;
                              settingController.workspaceId.value = data.id.toString();
                              settingController.selectedworkspaceId.refresh();
                            },
                            child: workspaceWidget(
                              title: data.name,
                              color: data.id.toString() ==
                                  settingController.workspaceId.value
                                  ? AppColor.themeGreenColor
                                  : AppColor.cWhite,
                              bColor: data.id.toString() ==
                                  settingController.workspaceId.value
                                  ? AppColor.themeGreenColor
                                  : AppColor.cBorder,
                            ));
                      });
                    }),
              )),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CommonButton(
                  onPressed: () {
                    if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                      commonToast(AppConstant.demoString);
                    } else {
                      Prefs.setString(AppConstant.workspaceId, settingController.workspaceId.value);
                      Get.back();
                    }
                  },
                  title: "Save",
                ),
              )
            ],
          )),
    );
  }


  Widget workspaceWidget({String? title, Color? color, Color? bColor}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 55,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: bColor ?? AppColor.cBorder)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  border:
                  Border.all(color: bColor ?? AppColor.cBorder, width: 1),
                  shape: BoxShape.circle),
              padding: const EdgeInsets.all(01.5),
              child: CircleAvatar(
                backgroundColor: color ?? AppColor.cBackGround,
              ),
            ),
          ],
        ),
      ),
    );
  }

}