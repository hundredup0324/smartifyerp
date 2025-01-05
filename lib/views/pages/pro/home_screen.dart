// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/project/home_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/pro/project_status_graph.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../core/model/home_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeControllers homeControllers = Get.put(HomeControllers());

  @override
  void initState() {
    super.initState();

    homeControllers.taskList.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeControllers.getHomeScreenData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.appBackgroundColor,
        body: Obx(
          () => SafeArea(
            child: homeControllers.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Dashboard".tr,
                                    style: pMedium24),
                              ],
                            ),
                            verticalSpace(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 8),
                                    height: 120,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        color: AppColor.cWhite,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        assetSvdImageWidget(
                                          image:
                                              "asset/image/svg_image/ic_dash_projects.svg",
                                        ),
                                        verticalSpace(8),
                                        Text(
                                          "Total Project".tr,
                                          style: pMedium16,
                                        ),
                                        verticalSpace(5),
                                        Text(
                                          homeControllers.totalProject.value.tr,
                                          style: pMedium16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    height: 120,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        color: AppColor.cWhite,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        assetSvdImageWidget(
                                          image: "asset/image/svg_image/ic_total_task.svg",
                                        ),
                                        verticalSpace(8),
                                        Text(
                                          "Total Task".tr,
                                          style: pMedium16,
                                        ),
                                        verticalSpace(5),
                                        Text(
                                          homeControllers.totalTask.value.tr,
                                          style: pMedium16,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            verticalSpace(15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 8),
                                    height: 120,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        color: AppColor.cWhite,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        assetSvdImageWidget(
                                          image:
                                              "asset/image/svg_image/ic_dash_bugs.svg",
                                        ),
                                        verticalSpace(8),
                                        Text(
                                          "Total Bug".tr,
                                          style: pMedium16,
                                        ),
                                        verticalSpace(5),
                                        Text(
                                          homeControllers.totalBug.value.tr,
                                          style: pMedium16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                verticalSpace(10),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    height: 120,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        color: AppColor.cWhite,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        assetSvdImageWidget(
                                          image:
                                              "asset/image/svg_image/ic_total_users.svg",
                                        ),
                                        verticalSpace(8),
                                        Text(
                                          "Total User".tr,
                                          style: pMedium16,
                                        ),
                                        verticalSpace(5),
                                        Text(
                                          homeControllers.totalUser.value.tr,
                                          style: pMedium16,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            verticalSpace(20),
                            Text("Tasks".tr,
                                style: pMedium24.copyWith(
                                    color: AppColor.textColor)),
                            verticalSpace(5),
                            homeControllers.taskList.isEmpty ? SizedBox(height: 150, child: Center(child: Text("Task Not Found",textAlign: TextAlign.center,style: pRegular16)),):
                            ListView.builder(
                              itemCount: homeControllers.taskList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var tasksData = homeControllers.taskList[index];

                                return Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Container(
                                    height: 100,
                                    padding: EdgeInsets.only(
                                        top: 10, bottom: 8, right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColor.cWhite,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 15),
                                          width: 4,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(10)),
                                              color: AppColor.primaryColor),
                                        ),
                                        horizontalSpace(10),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.appBackgroundColor,
                                                    borderRadius: BorderRadius.circular(12)),
                                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                                child: Text(tasksData.projectName!.tr, style: pRegular10),),
                                              verticalSpace(8),
                                              Text(tasksData.title!.tr,
                                                  style: pMedium14),
                                              verticalSpace(8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  assetSvdImageWidget(image: "asset/image/svg_image/ic_calender.svg"),
                                                  horizontalSpace(3),
                                                  Text(
                                                    homeControllers.getFormattedDate(tasksData.startDate ?? "").tr,
                                                    style: pRegular12.copyWith(color:AppColor.ishGrey),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: getStatusBgColor(tasksData.status ?? ""),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 8),
                                              child: Text(tasksData.status!.tr,
                                                  style: pRegular10.copyWith(
                                                      color:
                                                          getStatusStringColor(
                                                              tasksData
                                                                      .status ??
                                                                  ""))),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            verticalSpace(30),
                            Text("Project Status".tr,
                                style: pMedium24.copyWith(
                                    color: AppColor.textColor)),
                            verticalSpace(10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: ProjectStatusGraphScreen(
                                    finished: homeControllers.finished.value,
                                    onGoing: homeControllers.onGoing.value,
                                    onHold: homeControllers.onHold.value,
                                  ),
                                  width: MediaQuery.sizeOf(context).width / 1.7,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    statusIndicator(
                                        AppColor.redStatusColor, "On Going"),
                                    verticalSpace(8),
                                    statusIndicator(
                                        AppColor.greenStatusColor, "On Hold"),
                                    verticalSpace(8),
                                    statusIndicator(
                                        AppColor.orangeColor, "Finished"),
                                  ],
                                )
                              ],
                            ),
                            verticalSpace(20),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ));
  }

  Widget statusIndicator(Color color, String status) {
    return Row(
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: color,
        ),
        horizontalSpace(10),
        Text(status, style: pMedium14)
      ],
    );
  }

  Color getStatusBgColor(String status) {
    if (status == "Done") {
      return AppColor.primaryColor.withOpacity(0.3);
    } else if (status == "In Progress") {
      return AppColor.mediumGreen.withOpacity(0.3);
    } else {
      return AppColor.primaryColor.withOpacity(0.3);
    }
  }

  Color getStatusStringColor(String status) {
    if (status == "Done") {
      return AppColor.primaryColor;
    } else if (status == "In Progress") {
      return AppColor.mediumGreen;
    } else {
      return AppColor.primaryColor;
    }
  }
}
