import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/sales/meeting_controller.dart';
import 'package:attendance/core/model/meeting_list_response.dart';
import 'package:attendance/utils/dotted_seprator.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/sales/create_meeting_screen.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

import '../../../utils/app_color.dart';

class MeetingItem extends StatelessWidget {
  MeetingData? meetingData;
  final GestureTapCallback? onTap;
  MeetingItem({super.key, this.meetingData,this.onTap});

  @override
  Widget build(BuildContext context) {
    MeetingController meetingController = Get.find();

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: AppColor.cWhite, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  meetingData?.name.toString() ?? "",
                  style: pMedium16.copyWith(color: AppColor.primaryColor),
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: getColor(meetingData?.status).withOpacity(0.10),
                    border: Border.all(color: getColor(meetingData?.status), width: 0.5)),
                child: Text(
                  meetingData?.status??'',
                  style: pRegular10.copyWith(color: getColor(meetingData?.status)),
                ),
              )
            ],
          ),

          verticalSpace(10),
          Row(
            children: [
              Expanded(
                  child: itemColumn("Parent:", meetingData!.parent.toString())),
              horizontalDivider(),
              Expanded(child: itemColumn("Date Start:", getFormattedDate(meetingData!.startDate??""))),
              horizontalDivider(),
              Expanded(
                  child: itemColumn(
                      "Assigned User:", meetingData!.assignedUser ?? "")),
            ],
          ),
          verticalSpace(15),
          DottedSeparator(color: Colors.grey),
          verticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap:onTap,
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF3EC9D6),
                  radius: 18,
                  child: Icon(
                    Icons.edit,
                    size: 16.0,
                    color: AppColor.cWhite,
                  ),
                ),
              ),
              horizontalSpace(10),
              GestureDetector(
                onTap: () {
                  meetingController.deleteMeeting(meetingData!.id.toString());
                },
                child: CircleAvatar(
                  backgroundColor: const Color(0xFFFF594A),
                  radius: 18,
                  child: Icon(
                    Icons.delete,
                    size: 16.0,
                    color: AppColor.cWhite,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  getColor(String? type) {
    if (type == "Not Held") {
      return AppColor.yellow;
    } else if (type == "Held")
    {
      return AppColor.redStatusColor;
    }else {
      return AppColor.greenStatusColor;

    }
  }

  Widget itemColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: pRegular14,
        ),
        verticalSpace(5),
        Text(
          value,
          style: pRegular12.copyWith(color: AppColor.gray),
        )
      ],
    );
  }
}
