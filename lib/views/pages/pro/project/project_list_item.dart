// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/model/project_list_response.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/pro/project/project_detail.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class ProjectListItem extends StatelessWidget {
  Projects? projectModel;
  Function()? onTap;
  ProjectListItem({super.key, this.projectModel,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: AppColor.cWhite, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              projectModel!.name.toString().tr,
              style: pMedium18,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            verticalSpace(10),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: getStatusColor(projectModel!.status.toString())),
                  child: Text(
                    projectModel!.status.toString().tr,
                    style: pRegular10.copyWith(color: AppColor.cWhite),
                  ),
                ),
                horizontalSpace(5),
                assetSvdImageWidget(
                    image: "asset/image/svg_image/ic_calender.svg"),
                horizontalSpace(3),
                Text(
                  getFormattedDate(projectModel!.startDate.toString()).tr,
                  style: pRegular12.copyWith(color: AppColor.ishGrey),
                ),
                horizontalSpace(5),
                Icon(
                  Icons.remove_red_eye,
                  color: Color(0xFF172C4E).withOpacity(0.5),
                ),
              ],
            ),
            verticalSpace(12),
            Text(projectModel!.description.toString().tr,
              style: pRegular12,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            verticalSpace(10),
            Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColor.primaryColor,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          projectModel?.totalTask.toString() ??"",
                          style: pMedium18.copyWith(color: AppColor.cWhite),
                        ),
                      ),
                    ),
                    verticalSpace(5),
                    Text(
                      "Tasks".tr,
                      style: pRegular12,
                    )
                  ],
                ),
                horizontalSpace(10),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColor.primaryColor,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                         projectModel?.totalComments.toString() ??"",
                          style: pMedium18.copyWith(color: AppColor.cWhite),
                        ),
                      ),
                    ),
                    verticalSpace(5),
                    Text(
                      "Comments".tr,
                      style: pRegular12,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
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
