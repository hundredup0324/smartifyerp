import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/sales/oppotunities_controller.dart';
import 'package:attendance/core/model/opprtunity_response.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/dotted_seprator.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/sales/create_oppertunities.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

class OpportunitiesItem extends StatelessWidget {
  OpportunityData? data;
  final GestureTapCallback? onTap;


  OpportunitiesItem({this.data, this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    OpportunitiesController opController=Get.find();
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: AppColor.cWhite, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            data!.name.toString(),
            style: pMedium16.copyWith(color: AppColor.primaryColor),
          ),
          verticalSpace(10),
          Row(
            children: [
              Expanded(child: itemColumn("Account:", data!.account.toString())),
              horizontalDivider(),
              Expanded(child: itemColumn("Stage:", data!.stage.toString())),
              horizontalDivider(),
              Expanded(
                  child: itemColumn(
                      "Assigned User:", data!.assignUser.toString())),
            ],
          ),
          verticalSpace(15),
          DottedSeparator(color: Colors.grey),
          verticalSpace(15),
          Row(
            children: [
              Expanded(
                  child: Text(data!.amount.toString(),
                      style: pMedium16.copyWith(color: AppColor.cBlack))),
              GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  backgroundColor: Color(0xFF3EC9D6),
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
                  opController.deleteOpportunities(data!.id.toString());
                },
                child: CircleAvatar(
                  backgroundColor: Color(0xFFFF594A),
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
