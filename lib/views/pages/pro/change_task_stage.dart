import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/project/task_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_button.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

import '../../../core/model/tasklist_response.dart';

class ChangeTaskStage extends StatelessWidget {

  String? projectId;
  String? taskId;

    ChangeTaskStage({super.key,this.projectId,this.taskId});


  @override
  Widget build(BuildContext context) {

    TaskController taskController =Get.find();
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            color: AppColor.cWhite,
          ),

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                        "Select Stage".tr,
                        style: pMedium16,
                      )),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColor.cLabel,
                      )),
                ],
              ),
              verticalSpace(15),
              Divider(
                height: 1,
                color: AppColor.ishGrey,
              ),

              verticalSpace(20),

              ListView.builder(
                  itemCount: taskController.taskList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = taskController.taskList[index];

                    return Obx(() {
                      return GestureDetector(
                          onTap: () {
                            taskController.selectedTaskStages.value = index;
                            taskController.selectedTaskStagesId.value = data.id??0;
                            taskController.currentTaskStages.value = data.name.toString();
                            taskController.taskList.refresh();
                          },
                          child: StagesSelectionWidget(
                            title: data.name,
                            color: data.name.toString() ==
                                taskController.currentTaskStages.value
                                ? AppColor.themeGreenColor
                                : AppColor.cWhite,
                            bColor: data.name.toString() ==
                                taskController.currentTaskStages.value
                                ? AppColor.themeGreenColor
                                : AppColor.cBorder,
                          ));
                    });
                  }),
              verticalSpace(20),

              CommonButton(
                onPressed: () {
                  if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                    commonToast(AppConstant.demoString);
                  } else {

                    Get.back();


                  taskController.changeStages(taskId??"",taskController.selectedTaskStagesId.value.toString());
                  }
                },
                title: "Update",
              ),
              

            ],
          ),
        ),
      ),
    );
  }

  Widget StagesSelectionWidget({String? title, Color? color, Color? bColor}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 45,
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
                backgroundColor: color ?? AppColor.cWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
