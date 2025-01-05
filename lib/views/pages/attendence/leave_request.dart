// ignore_for_file: prefer_const_constructors

import 'package:attendance/core/controller/attendence/leave_request_controller.dart';
import 'package:attendance/core/model/leave_types_response.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_button.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveRequestScreen extends StatelessWidget {
  LeaveRequestScreen({super.key});
  TextEditingController reasonController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LeaveRequestController requestController = Get.find();

    return Scaffold(
      backgroundColor: AppColor.appBackGround,

      appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColor.cWhite,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => {
              Get.back()
            },
          ),
          title: Text(
            "Leave Request".tr,
             style: pMedium24,
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Start Date",
                          style: pMedium16.copyWith(color: AppColor.cBlack),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: Text(
                          "End Date",
                          style: pMedium16.copyWith(color: AppColor.cBlack),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            requestController.selectStartDate(context);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),

                                color: AppColor.cWhite,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  assetSvdImageWidget(
                                      image: ImagePath.calender),
                                  horizontalSpace(8),
                                  Text(
                                      requestController.getFormattedDate(
                                          requestController.startDate.value),
                                      style: pMedium14.copyWith(
                                          color: AppColor.cBlack))
                                ],
                              )),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            requestController.selectEndDate(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.cWhite,
                            ),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                assetSvdImageWidget(
                                    image: ImagePath.calender),
                                horizontalSpace(8),
                                Text(
                                  requestController.getFormattedDate(
                                      requestController.endDate.value),
                                  style: pMedium14.copyWith(
                                      color: AppColor.cBlack),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    "Types of leave",
                    style: pMedium16.copyWith(color: AppColor.cBlack),
                  ),
                  verticalSpace(10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: DropdownButton(
                      icon: Icon(Icons.arrow_drop_down),
                      dropdownColor: AppColor.cWhite,
                      value: requestController.leaveType.value,
                      iconSize: 24,
                      isExpanded: true,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: SizedBox(),
                      hint: Text("Select an leave type"),
                      onChanged: (newValue) {
                        requestController.leaveType.value=newValue.toString();

                      },
                      items: requestController.leaveTypes
                          .map((LeaveType valueItem) {
                        return DropdownMenuItem(
                            value: valueItem.title,
                            child: Text("${valueItem.title}"),
                            onTap: (){
                                    requestController.leaveId.value=valueItem.id.toString();
                            },);
                      }).toList(),
                    ),
                  ),
                  verticalSpace(10),
                  Text("Reason",
                      style: pMedium16.copyWith(color: AppColor.cBlack)),
                  verticalSpace(10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Reason',
                      filled: false, // Remove background fill
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: pRegular14,
                    controller: reasonController,
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    minLines: 4,
                  ),
                  verticalSpace(10),
                  Text("Remark",
                      style: pMedium16.copyWith(color: AppColor.cBlack)),
                  verticalSpace(10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Remark',
                      filled: false, // Remove background fill
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: pRegular14,
                    controller: remarkController,
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    minLines: 4,
                  ),
                  verticalSpace(30),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.back(result: false);
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 8),
                            child: SizedBox(
                              height: 45,
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: OutlinedButton.styleFrom(
                                  side:
                                  BorderSide(color: AppColor.gray, width: 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: pMedium18.copyWith(color: AppColor.gray),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print("date${requestController.getParameterFormattedDate(requestController.startDate.value)}");
                            print("enddate${requestController.getParameterFormattedDate(requestController.startDate.value)}");

                            if (requestController.leaveType.isEmpty && requestController.leaveId.isEmpty) {
                              commonToast("Leave type field is required.");
                            } else if (reasonController.text.isEmpty) {
                              commonToast("Leave reason field is required");
                            } else if (remarkController.text.isEmpty) {
                              commonToast("Leave remark field is required");
                            } else {
                              requestController.leaveRequest({
                                "leave_reason": reasonController.text,
                                "start_date": requestController.getParameterFormattedDate(requestController.startDate.value),
                                "end_date": requestController.getParameterFormattedDate(requestController.endDate.value),
                                "remark": remarkController.text,
                                "user_id": Prefs.getUserID(),
                                "leave_type_id": requestController.leaveId.value,
                              });
                            }


                          },
                          child: Text(
                            'Apply',
                            style: pMedium18.copyWith(color: AppColor.cWhite),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color: Colors.transparent, width: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 0.0, // Remove shadow effect
                            backgroundColor:
                            AppColor.cBlue, // Set background color
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
