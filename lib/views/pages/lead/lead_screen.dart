// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/lead/lead_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/input_decoration.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/item_widget/lead_item.dart';
import 'package:attendance/views/pages/lead/create_leads.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:multi_dropdown/models/value_item.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  LeadController leadController = Get.put(LeadController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    leadController.selectedIndex(0);
    leadController.leadBoardList.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      leadController.getLeadList(true);

      if(Prefs.getString(AppConstant.userType)=="company")
        {
          leadController.getworkspaceUsers();

        }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: AppColor.appBackgroundColor,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            onPressed: () {
              leadController.emailController.clear();
              leadController.nameController.clear();
              leadController.subjectController.clear();
              if(leadController.userDataList.isNotEmpty)
              {
                leadController.assignUserIdValue.value=leadController.userDataList.first.id.toString();
                leadController.assignUser.value=leadController.userDataList.first;
              }

              leadController.followUpDate.value=DateTime.now();
              Get.to(() => CreateLeads(isEdit: false,leadId: "",))?.then((value) {
                if (value == true) {
                  leadController.getLeadList(true);
                }
              });
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Leads".tr,
                            style: pMedium24),
                      ],)
            ),


                  ],
                ),
                verticalSpace(20),

                _buildTabBar(),
                leadController.isLoading.value==true ?Expanded(child: Center(child: CircularProgressIndicator())):
                leadController.leadBoardList.isEmpty
                    ? Expanded(child: dataNotFound("Create Lead Stage From Admin Panel"))
                    : leadController.leadBoardList[leadController.selectedIndex.value].leads?.isNotEmpty ?? false
                        ? Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              controller: scrollController,
                              itemCount:  leadController.leadBoardList[leadController.selectedIndex.value].leads?.length,
                              itemBuilder: (context, index) {

                                var leadObjectData = leadController
                                    .leadBoardList[
                                        leadController.selectedIndex.value]
                                    .leads?[index];

                                print("object data ${jsonEncode(leadObjectData)}");
                                return LeadItem(
                                  leadData: leadObjectData,
                                 );
                              }),
                        )
                        : Expanded(child: dataNotFound("Data Not Found")),


              ],
            ),
          )),
    );
  }


  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: leadController.leadBoardList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => leadController.changeTab(index),
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                decoration: BoxDecoration(
                    color: leadController.selectedIndex.value == index
                        ? AppColor.themeGreenColor
                        : AppColor.unSelectedGreyColor,
                    borderRadius: BorderRadius.circular(48)),
                child: Center(
                  child: Text(
                    leadController.leadBoardList[index].name.toString().tr,
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
