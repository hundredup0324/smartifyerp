// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/lead/lead_controller.dart';
import 'package:attendance/core/controller/lead/lead_detail_controller.dart';
import 'package:attendance/core/model/lead_board.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/item_widget/activity_item.dart';
import 'package:attendance/views/item_widget/task_item.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class LeadDetailsScreen extends StatefulWidget {
  Leads? lead;

  LeadDetailsScreen({super.key, this.lead});

  @override
  State<LeadDetailsScreen> createState() => _LeadDetailsScreenState();
}

class _LeadDetailsScreenState extends State<LeadDetailsScreen> {
  LeadDetailController detailController = Get.put(LeadDetailController());
  LeadController leadController = Get.find();

  @override
  void initState() {
    super.initState();

    detailController.getLeadDetail(
        Prefs.getString(AppConstant.pipeLineId), widget.lead!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          Scaffold(
            backgroundColor: AppColor.appBackgroundColor,
            appBar: AppBar(
              backgroundColor: AppColor.darkGreen,
              elevation: 1,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () =>
                {
                  Get.back(result: {
                    "profileImage": Prefs.getString(
                        AppConstant.profileImage)
                  })
                },
              ),
              title: Text(
                widget.lead!
                    .name
                    .toString()
                    .tr,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColor.cWhite),
              ),
            ),
            body: detailController.isLoading.value
                ? Center(
                  child: CircularProgressIndicator(),
                )
                : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery
                          .sizeOf(context)
                          .width,
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.cWhite),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [




                          Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [


                                  detailDashBoard(ImagePath.emailIcn,"Email",detailController.email.value,AppColor.primaryColor),

                                  verticalSpace(15),

                                  detailDashBoard(ImagePath.calender,"Follow Up Date",
                                      detailController.followUpDate.value=="null"?"-":detailController.getFollowUpDate(),AppColor.primaryColor),

                                  verticalSpace(15),

                                  detailDashBoard(ImagePath.phoneIcn,"Phone", detailController.phone.value,AppColor.yellow),
                                  verticalSpace(15),

                                  detailDashBoard(ImagePath.icnPipeline,"Pipeline", detailController.pipeLine.value,AppColor.skyBlue),

                                ],
                              )),
                          Expanded(
                              child: Column(
                                children: [


                                  detailDashBoard(ImagePath.icnStage,"Stage", detailController.stageName.value,AppColor.skyBlue),
                                  verticalSpace(15),

                                  detailDashBoard(ImagePath.icnCreatedAt,"Created", detailController.createdAt.value,AppColor.yellow),
                                  verticalSpace(15),


                                  Row(
                                    children: [
                                      dashboardRectangle(
                                          AppColor.skyBlue,
                                          ImagePath.icnBar),
                                      horizontalSpace(8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              detailController.percentage.value,
                                              style: pMedium14,
                                            ),
                                            verticalSpace(5),

                                            SizedBox(
                                              width: MediaQuery.sizeOf(context).width / 1,
                                              child: LinearProgressIndicator(
                                                minHeight: 5,
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                value: detailController. convertToZeroToOne(
                                                    detailController.percentage.value),
                                                backgroundColor:
                                                Colors.grey[300],
                                                valueColor:
                                                AlwaysStoppedAnimation<
                                                    Color>(
                                                    AppColor.primaryColor),
                                              ),
                                            ),

                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    verticalSpace(20),
                    Text(
                      "Task",
                      style: pMedium18,
                    ),
                    detailController.taskList.isEmpty ? SizedBox(height: 200,child: dataNotFound("Data Not Found"),) :

                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: detailController.taskList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var taskItem = detailController.taskList[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TaskItem(
                              taskData: taskItem,
                            ),
                          );
                        }),
                    verticalSpace(20),
                    Text(
                      "Activity",
                      style: pMedium18,
                    ),

                    detailController.leadActivity.isEmpty ? SizedBox(height: 200,child: dataNotFound("Data Not Found"),) :
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: detailController.leadActivity.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var activityData =
                          detailController.leadActivity[index];

                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ActivityItem(
                              activityData: activityData,
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
    );
  }



  Widget dashboardRectangle(Color color, String imagePath) {
    return Container(
      width: 26,
      height: 26,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: assetSvdImageWidget(
          image: imagePath,
          colorFilter: ColorFilter.mode(AppColor.cWhite, BlendMode.srcIn)),
    );
  }

  Widget detailDashBoard(String imagePath,String fieldName,String fieldValue,Color color) {
    return Row(
      children: [
        dashboardRectangle(color,
            imagePath),
        horizontalSpace(8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                fieldName,
                style: pMedium14,
              ),
              verticalSpace(2),
              Text(
                fieldValue,
                style: pRegular10.copyWith(
                    color: Color(0xff666666)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }


}
