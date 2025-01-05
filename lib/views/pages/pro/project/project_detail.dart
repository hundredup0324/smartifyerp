// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:attendance/core/controller/project/project_controller.dart';
import 'package:attendance/core/controller/project/project_detail_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/pro/project/edit_project.dart';
import 'package:attendance/views/pages/pro/project/task_list_screen.dart';
import 'package:attendance/views/pages/pro/webview.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class ProjectDetail extends StatefulWidget {
  String? projectId;

  ProjectDetail({super.key, this.projectId});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  ProjectController projectController = Get.find();
  ProjectDetailController projectDetailController =
      Get.put(ProjectDetailController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      projectDetailController.getProjectDetails(widget.projectId ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Project Detail",
          style: pMedium24.copyWith(color: AppColor.cLabel),
        ),
      ),
      body: Obx(
        () => projectDetailController.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : projectDetailController.projectData == null
                ? SizedBox()
                : SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 10, bottom: 20),
                            decoration: BoxDecoration(
                              color: AppColor.lightGreen,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColor.primaryColor, width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      projectDetailController.projectData!.name
                                          .toString()
                                          .tr,
                                      style: pMedium18,
                                    )),
                                    horizontalSpace(4),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: AppColor.cBackGround,
                                          barrierColor: AppColor.cGreyOpacity,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(16))),
                                          builder: (context) {
                                            return EditProject();
                                          },
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: AppColor.cWhite,
                                        child: Icon(
                                          Icons.mode_edit_outline,
                                          color: AppColor.cLabel,
                                        ),
                                      ),
                                    ),
                                    horizontalSpace(8),
                                    GestureDetector(
                                      onTap: () {
                                        if(Prefs.getBool(AppConstant.isDemoMode))
                                        {
                                          commonToast(AppConstant.demoString);
                                        }else
                                        {
                                          projectController.deleteProject(
                                             widget.projectId.toString());
                                        }



                                      },
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: AppColor.cWhite,
                                        child: assetSvdImageWidget(
                                            image:
                                                "asset/image/svg_image/ic_delete.svg",
                                            colorFilter: ColorFilter.mode(
                                                AppColor.cLabel,
                                                BlendMode.srcIn)),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(5),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      color: getStatusColor(
                                          projectDetailController
                                                  .projectData!.status ??
                                              "")),
                                  child: Text(
                                    projectDetailController
                                            .projectData!.status ??
                                        "".tr,
                                    style: pRegular10.copyWith(
                                        color: AppColor.cWhite),
                                  ),
                                ),
                                verticalSpace(8),
                                Row(
                                  children: [
                                    assetSvdImageWidget(
                                        image:
                                            "asset/image/svg_image/ic_calender.svg"),
                                    horizontalSpace(3),
                                    Text(
                                      "Start Date: ${projectDetailController.projectData!.startDate}"
                                          .tr,
                                      style: pRegular12.copyWith(
                                          color: AppColor.ishGrey),
                                    ),
                                  ],
                                ),
                                verticalSpace(5),
                                Row(
                                  children: [
                                    assetSvdImageWidget(
                                        image:
                                            "asset/image/svg_image/ic_calender.svg"),
                                    horizontalSpace(3),
                                    Text(
                                      "Due Date: ${projectDetailController.projectData!.endDate}"
                                          .tr,
                                      style: pRegular12.copyWith(
                                          color: AppColor.ishGrey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          verticalSpace(20),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: dashContainer(
                                      imagePath:
                                          "asset/image/svg_image/ic_calender_b.svg",
                                      title: "Days Left",
                                      value: projectDetailController
                                              .projectData!.daysleft
                                              .toString() ??
                                          ""),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: dashContainer(
                                      imagePath:
                                          "asset/image/svg_image/ic_currency.svg",
                                      title: "Budget",
                                      value:
                                          "USD ${projectDetailController.projectData!.budget.toString() ?? ""}"),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(15),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: dashContainer(
                                      imagePath:
                                          "asset/image/svg_image/ic_task_b.svg",
                                      title: "Total Task",
                                      value: projectDetailController
                                          .projectData!.totalTask
                                          .toString()),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: dashContainer(
                                      imagePath:
                                          "asset/image/svg_image/ic_comment_b.svg",
                                      title: "Comment",
                                      value: projectDetailController
                                          .projectData!.totalComments
                                          .toString()),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(20),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      if (Prefs.getBool(
                                          AppConstant.isDemoMode)) {
                                        commonToast(AppConstant.demoString);
                                      } else {
                                        Get.to(() => WebViewScreen(
                                              projectName:
                                                  projectDetailController
                                                      .projectData?.name
                                                      .toString(),
                                              url: projectDetailController
                                                  .projectData?.projectCopylink
                                                  .toString(),
                                            ));
                                      }

                                      // Add your onPressed action here
                                    },
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      side: BorderSide(
                                          color: AppColor.ishGrey, width: 2.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 15.0,
                                      ),
                                      child: Text(
                                        'View',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: AppColor.ishGrey),
                                      ),
                                    ),
                                  ),
                                ),
                                horizontalSpace(10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(() => TaskListScreen(
                                            projectId: widget.projectId,
                                          ));
                                      // Add your onPressed action here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: AppColor.cLabel,
                                      textStyle: pMedium16.copyWith(
                                          color: AppColor.cWhite),
                                      padding: EdgeInsets.all(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0,
                                      ),
                                      child: Text(
                                        'TaskBoard',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: AppColor.cWhite),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          verticalSpace(20),
                          projectDetailController
                                  .projectData!.milestones!.isEmpty
                              ? SizedBox()
                              : Text(
                                  "Milestones".tr,
                                  style: pMedium18,
                                ),
                          verticalSpace(5),
                          ListView.builder(
                              itemCount: projectDetailController
                                  .projectData!.milestones?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var mileStoneData = projectDetailController
                                    .projectData!.milestones![index];
                                return Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      // border:Border.all(width: 1.0, color: AppColor.ishGrey),
                                      color: AppColor.cWhite,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [


                                        Text(
                                          mileStoneData.title.toString().tr,
                                          style: pMedium14,
                                        ),
                                        verticalSpace(5),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              color: getStatusColor(
                                                  mileStoneData.status
                                                      .toString())),
                                          child: Text(
                                            mileStoneData.status.toString().tr,
                                            style: pRegular10.copyWith(
                                                color: AppColor.cWhite),
                                          ),
                                        ),
                                        verticalSpace(10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.sizeOf(context)
                                                      .width /
                                                  1.3,
                                              child: LinearProgressIndicator(
                                                minHeight: 5,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                value: convertToZeroToOne(
                                                    mileStoneData.progress),
                                                backgroundColor:
                                                    Colors.grey[300],
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        AppColor.primaryColor),
                                              ),
                                            ),
                                            horizontalSpace(8),
                                            Text(
                                              "${mileStoneData.progress??"0"}%",
                                              style: pMedium10.copyWith(
                                                  color: AppColor.ishGrey),
                                            )
                                          ],
                                        ),
                                        verticalSpace(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            mileStoneSubWidget(
                                                "Start Date",
                                            mileStoneData.startDate == null ?"":
                                                getFormattedDate(mileStoneData
                                                    .startDate
                                                    .toString())),
                                            horizontalSpace(10),
                                            mileStoneSubWidget(
                                                "End Date",
                                                mileStoneData.endDate == null ?"":
                                                mileStoneData.endDate
                                                    .toString()),
                                            horizontalSpace(10),
                                            mileStoneSubWidget("Cost",
                                                "USD ${mileStoneData.cost.toString()}"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  double convertToZeroToOne(String? value) {
    // Ensure that the value is within the range of 0 to 100
    var percentage = int.parse(value ?? "0").clamp(0, 100);

    // Convert the value to the range of 0 to 1
    double result = percentage / 100.0;

    return result;
  }

  Widget mileStoneSubWidget(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: pMedium10,
        ),
        verticalSpace(3),
        Text(
          value,
          style: pMedium10.copyWith(color: AppColor.ishGrey),
        ),
      ],
    );
  }

  Widget dashContainer({String? title, String? imagePath, String? value}) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColor.cWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          assetSvdImageWidget(
            image: imagePath,
          ),
          horizontalSpace(12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title ?? "",
                textAlign: TextAlign.left,
                style: pMedium16.copyWith(color: AppColor.ishGrey),
              ),
              verticalSpace(3),
              Text(
                value ?? "",
                style: pMedium14,
              ),
            ],
          )
        ],
      ),
    );
  }

  String getFormattedDate(String date) {

    DateTime dateTime = DateTime.parse(date);

    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  Color getStatusColor(String status) {
    if (status == "OnHold") {
      return AppColor.orangeColor;
    } else if (status == "Ongoing") {
      return AppColor.redStatusColor;
    } else {
      return AppColor.greenStatusColor;
    }
  }
}
