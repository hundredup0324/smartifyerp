// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:attendance/core/controller/project/task_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/pro/change_task_stage.dart';
import 'package:attendance/views/pages/pro/project/create_new_task.dart';
import 'package:attendance/views/pages/pro/project/create_project.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class TaskListScreen extends StatelessWidget {
  String? projectId;

  TaskListScreen({super.key, this.projectId});

  TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
          child: Scaffold(
        backgroundColor: AppColor.textFieldBg,
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.primaryColor,
              onPressed: () {
                taskController.titleController.clear();
                taskController.controller.clearAllSelection();
                taskController.userIdList.clear();
                taskController.startDate.value= DateTime.now();
                taskController.endDate.value = DateTime.now();

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColor.cBackGround,
                  barrierColor: AppColor.cGreyOpacity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16))),
                  builder: (context) {

                    return CreateNewTask(
                      isEdit: false,
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColor.cLabel,
                      )),
                  horizontalSpace(15),
                  Expanded(
                      child: Text("Task Board".tr,
                          style: pMedium24.copyWith(
                            color: AppColor.textColor,
                          ))),
                ],
              ),
              verticalSpace(15),
              _buildTabBar(),
              taskController.isLoading.value == true
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : taskController.taskList.isEmpty
                      ? SizedBox(
                          child: Center(
                              child: Text(
                            "Data Not Found",
                            style: pMedium14,
                          )),
                        )
                      : taskController
                              .taskList[taskController.selectedIndex.value]
                              .tasks!
                              .isEmpty
                          ? Expanded(
                              child: Center(
                                child: Text(
                                  "Task Not Found".tr,
                                  style: pMedium14,
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: taskController
                                      .taskList[
                                          taskController.selectedIndex.value]
                                      .tasks!
                                      .length,
                                  itemBuilder: (context, index) {
                                    var taskData = taskController
                                        .taskList[
                                            taskController.selectedIndex.value]
                                        .tasks![index];

                                    return Padding(
                                      padding: EdgeInsets.only(top: 12),
                                      child: Container(
                                        height: 130,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: AppColor.cWhite,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    taskData.title
                                                        .toString()
                                                        .tr,
                                                    style: pMedium14,
                                                  ),
                                                  verticalSpace(8),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 6,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(11),
                                                        color: getStatusColor(
                                                            taskData.priority
                                                                .toString())),
                                                    child: Text(
                                                      taskData.priority
                                                          .toString()
                                                          .tr,
                                                      style:
                                                          pRegular10.copyWith(
                                                              color: AppColor
                                                                  .cWhite),
                                                    ),
                                                  ),
                                                  verticalSpace(10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      assetSvdImageWidget(
                                                          image:
                                                              "asset/image/svg_image/ic_calender.svg"),
                                                      horizontalSpace(3),
                                                      Text(
                                                        getFormattedDate(
                                                                taskData
                                                                    .startDate
                                                                    .toString())
                                                            .tr,
                                                        style:
                                                            pRegular12.copyWith(
                                                                color: AppColor
                                                                    .ishGrey),
                                                      ),
                                                      horizontalSpace(8),
                                                      assetSvdImageWidget(
                                                          image:
                                                              "asset/image/svg_image/ic_calender.svg"),
                                                      horizontalSpace(3),
                                                      Text(
                                                        getFormattedDate(
                                                                taskData.dueDate
                                                                    .toString())
                                                            .tr,
                                                        style:
                                                            pRegular12.copyWith(
                                                                color: AppColor
                                                                    .ishGrey),
                                                      ),
                                                    ],
                                                  ),
                                                  verticalSpace(5),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {

                                                        taskController.controller.clearAllSelection();
                                                        showModalBottomSheet(
                                                          context: context,
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              AppColor
                                                                  .cBackGround,
                                                          barrierColor: AppColor
                                                              .cGreyOpacity,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              16))),
                                                          builder: (context) {

                                                            var mileStoneList=taskController.projectDetailController.mileStoneList;


                                                            int index = mileStoneList.indexWhere((element) => element.id == taskData.milestoneId)??0 ;


                                                            taskController.titleController.text=taskData.title??"";
                                                            taskController.selectedPriority.value=taskData.priority??"";

                                                            taskController.selectedMileStone.value=mileStoneList.isNotEmpty ? mileStoneList[0].title.toString():""??"";
                                                            taskController.startDate.value= DateTime.parse(taskData.startDate??"");
                                                            taskController.endDate.value= DateTime.parse(taskData.dueDate??"");

                                                            var selectedOption = taskData.assignTo?.map((element) {
                                                              return ValueItem(label: element.email ?? "", value: element.id);
                                                            }).toList();
                                                            taskController.userIdList.value = selectedOption!.map((data) => data.value.toString()).toList();


                                                            return CreateNewTask(
                                                              taskId: taskData.id.toString(),
                                                              isEdit: true,
                                                              selectedUserList: selectedOption,
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AppColor
                                                                .textFieldBg,
                                                        child: SizedBox(
                                                          child: Icon(
                                                            Icons
                                                                .mode_edit_outline,
                                                            size: 15,
                                                            color:
                                                                AppColor.cLabel,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    horizontalSpace(5),
                                                    GestureDetector(
                                                      child: CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AppColor
                                                                .textFieldBg,
                                                        child: assetSvdImageWidget(
                                                            height: 15,
                                                            width: 15,
                                                            image:
                                                                "asset/image/svg_image/ic_delete.svg",
                                                            colorFilter:
                                                                ColorFilter.mode(
                                                                    AppColor
                                                                        .cLabel,
                                                                    BlendMode
                                                                        .srcIn)),
                                                      ),
                                                      onTap: () {
                                                        if(Prefs.getBool(AppConstant.isDemoMode))
                                                          {
                                                            commonToast(AppConstant.demoString);
                                                          }else
                                                            {
                                                              taskController
                                                                  .deleteTask(taskData
                                                                  .id
                                                                  .toString());
                                                            }



                                                      },
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      backgroundColor:
                                                          AppColor.cBackGround,
                                                      barrierColor:
                                                          AppColor.cGreyOpacity,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          16))),
                                                      builder: (context) {
                                                        return ChangeTaskStage(
                                                            projectId:
                                                                projectId ?? "",
                                                            taskId: taskData.id
                                                                .toString());
                                                      },
                                                    );
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        AppColor.primaryColor,
                                                    radius: 20,
                                                    child: assetSvdImageWidget(
                                                        image: ImagePath
                                                            .changeStage),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
            ],
          ),
        ),
      )),
    );
  }

  String getFormattedDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  Color getStatusColor(String status) {
    if (status == "Medium") {
      return AppColor.orangeColor;
    } else if (status == "High") {
      return AppColor.redStatusColor;
    } else {
      return AppColor.greenStatusColor;
    }
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: taskController.taskList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => taskController.changeTab(index),
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                decoration: BoxDecoration(
                    color: taskController.selectedIndex.value == index
                        ? AppColor.themeGreenColor
                        : AppColor.unSelectedGreyColor,
                    borderRadius: BorderRadius.circular(48)),
                child: Center(
                  child: Text(
                    taskController.taskList[index].name!.tr,
                    style: pMedium12.copyWith(color: AppColor.cWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
