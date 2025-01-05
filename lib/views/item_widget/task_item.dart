// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/lead/lead_detail_controller.dart';
import 'package:attendance/core/model/lead_detail_response.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';


class TaskItem extends StatelessWidget {
  TasksList? taskData;

  TaskItem({super.key,this.taskData});

  @override
  Widget build(BuildContext context) {
    LeadDetailController leadDetailController = Get.find();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.cWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Text(
                taskData!.name??"",
                style: pMedium16,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace(5),

              Row(
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.darkGreen),
                    child: Text(
                      taskData?.status.toString() ??"",

                      style: pMedium8.copyWith(color: AppColor.cWhite),
                    ),
                  ),
                  horizontalSpace(8),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.darkGreen),
                    child: Text(
                     taskData?.priority.toString()??"",
                      style: pMedium8.copyWith(color: AppColor.cWhite),
                    ),
                  ),

                ],
              ),
              verticalSpace(5),

              Row(
                children: [
                  assetSvdImageWidget(
                      image: ImagePath.calender,
                      colorFilter:
                      ColorFilter.mode(AppColor.primaryColor, BlendMode.srcIn)),
                  horizontalSpace(8),

                  Text(
                    taskData?.date??"",
                    style: pRegular10.copyWith(color: AppColor.primaryColor),
                  ),
                ],
              ),
            ],
          ),


        ],

      ),
    );
  }

  Color parseColor(String colorCode) {
    if (colorCode.isEmpty) {
      // Default color if the string is empty
      return AppColor.primaryColor;
    }

    // Remove '#' from the color code string
    colorCode = colorCode.replaceAll("#", "");

    try {
      // Parse the color code string
      return Color(int.parse(colorCode, radix: 16) + 0xFF000000);
    } catch (e) {
      // Return black if parsing fails
      return AppColor.primaryColor;
    }
  }

  Widget circleWidget(Color bgColor,Function() onTap,Widget widget)
  {
    return CircleAvatar(
      radius: 20,
      backgroundColor: bgColor,
      child: GestureDetector(

        onTap: onTap,
        child: widget,
      ),

    );
  }
}
