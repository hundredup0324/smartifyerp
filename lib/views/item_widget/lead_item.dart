// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:attendance/core/controller/lead/lead_controller.dart';
import 'package:attendance/core/model/lead_board.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/lead/change_lead_stage.dart';
import 'package:attendance/views/pages/lead/create_leads.dart';
import 'package:attendance/views/pages/lead/lead_details.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class LeadItem extends StatelessWidget {
  Leads? leadData;
  LeadController leadController = Get.find();

  LeadItem({super.key, this.leadData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => LeadDetailsScreen(
              lead: leadData,
            ));
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
              color: AppColor.cWhite, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        leadData?.name.toString() ?? "",
                        style: pMedium18,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      verticalSpace(5),
                      SizedBox(
                        height: 18,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var labelData = leadData!.labels![index];
                            return Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: parseColor(
                                        labelData.color ?? "#6fd943")),
                                child: Text(
                                  labelData.name ?? "",
                                  style:
                                      pMedium8.copyWith(color: AppColor.cWhite),
                                ),
                              ),
                            );
                          },
                          itemCount: leadData!.labels!.length,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                      verticalSpace(8),
                      Row(
                        children: [
                          assetSvdImageWidget(
                              image: ImagePath.calender,
                              colorFilter: ColorFilter.mode(
                                  AppColor.cRedText, BlendMode.srcIn)),
                          horizontalSpace(8),
                          Text(
                            leadData?.followUpdate == null ||
                                    leadData?.followUpdate == ""
                                ? "-"
                                : leadController
                                    .getFollowUpDate(leadData?.followUpdate),
                            style:
                                pRegular10.copyWith(color: AppColor.cRedText),
                          ),
                        ],
                      ),
                      verticalSpace(8),
                      Row(
                        children: [
                          assetSvdImageWidget(
                              image: "asset/image/svg_image/ic_task.svg"),
                          horizontalSpace(3),
                          Text(
                            leadData!.totalTask.toString(),
                            style: pMedium14,
                          ),
                          horizontalSpace(8),
                          assetSvdImageWidget(
                              image: "asset/image/svg_image/ic_product.svg"),
                          horizontalSpace(3),
                          Text(
                            leadData!.totalProducts.toString(),
                            style: pMedium14,
                          ),
                          horizontalSpace(8),
                          assetSvdImageWidget(
                              image: "asset/image/svg_image/ic_bug.svg"),
                          horizontalSpace(3),
                          Text(
                            leadData!.totalSources.toString(),
                            style: pMedium14,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  circleWidget(AppColor.skyBlue, () async {
                    if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                      commonToast(AppConstant.demoString);
                    } else {
                     await setData();
                      Get.to(() => CreateLeads(
                            isEdit: true,
                            leadId: leadData!.id.toString() ?? "",
                          ))?.then((value) {
                            print("value$value");
                        if (value == true) {
                          leadController.getLeadList(true);
                        }
                      });
                    }
                  }, ImagePath.editOptionIcn),
                  circleWidget(
                      AppColor.redColor,
                      ()  => {
                            if (Prefs.getBool(AppConstant.isDemoMode) == true)
                              {commonToast(AppConstant.demoString)}
                            else
                              {
                                leadController
                                    .deleteLead(leadData!.id.toString())
                              },
                          },
                      ImagePath.deleteOptionIcn),
                  circleWidget(
                      AppColor.primaryColor,
                      () => {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: AppColor.cBackGround,
                              barrierColor: AppColor.cGreyOpacity,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16))),
                              builder: (context) {
                                return ChangeLeadStage(
                                    leadId: leadData!.id.toString());
                              },
                            )
                          },
                      ImagePath.changeStage),
                ],
              )
            ],
          ),
        ),
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

  setData() async{
    leadController.nameController.text = leadData!.name.toString();
    leadController.emailController.text = leadData!.email.toString();
    leadController.subjectController.text = leadData!.subject.toString();
    leadController.phoneController.text = leadData!.phone.toString();

    if (leadData!.followUpdate != "-" || leadData?.followUpdate != null) {
      leadController.followUpDate.value =
          DateTime.parse(leadData?.followUpdate ?? "");
    }

    for(var i in leadController.userDataList)
      {
        if(i.id==leadData!.assignUserId)
          {

            leadController.assignUser.value=i;
            leadController.assignUserIdValue.value=i.id.toString();
            print("assign user id ==> ${leadController.assignUserIdValue.value}");
            print("assign user ==> ${jsonEncode(leadController.assignUser.value)}");
          
          }
      }

  }

  Widget circleWidget(Color bgColor,   Function()? onTap, String imagePath) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 16,
          backgroundColor: bgColor,
          child: assetSvdImageWidget(
              image: imagePath,
              colorFilter: ColorFilter.mode(AppColor.cWhite, BlendMode.srcIn)),
        ),
      ),
    );
  }
}
