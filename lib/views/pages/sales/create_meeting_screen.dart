// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/utils/debouncer.dart';
import 'package:attendance/core/controller/sales/meeting_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/create_text_field.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/input_decoration.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/views/widgets/common_drop_down_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class CreateMeetings extends StatelessWidget {
  bool? isUpdate;
  String? meetingId;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MeetingController meetingController = Get.find();

  final Debouncer _debouncer = Debouncer(milliseconds: 1000);

  CreateMeetings({super.key, this.isUpdate,this.meetingId});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.cWhite,
            surfaceTintColor: Colors.transparent,
            title: Text(
              !isUpdate!?
              "Create New Meeting".tr :"Update Meeting",
              style: pMedium16,
            )),
        backgroundColor: AppColor.appBackgroundColor,
        body: Padding(
          padding: EdgeInsetsDirectional.only(end: 16, start: 16, top: 16, bottom: 25),
          child: SingleChildScrollView(
            child: Obx(()=> Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreateTextField(
                      controller: meetingController.nameController,
                      labelText: 'Name',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        Validator.validateRequired(value);
                      },
                      validator: (value) {
                        return Validator.validateRequired(value??"");
                      },
                    ),
                    verticalSpace(10),
                    CommonDropdownButtonWidget(
                      filledColor: AppColor.cWhite,
                      labelText: "Status",
                      list: meetingController.statusList,
                      onChanged: (value) {
                        meetingController.statusValue.value = value;
                      },
                      value: meetingController.statusValue.value,
                      validator: (value) => Validator.validateRequired(value),
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              meetingController.selectStartDate(context);
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(end: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Start Date".tr,
                                    style: pMedium14,
                                  ),
                                  verticalSpace(5),
                                  Container(
                                    height: 40,
                                    padding: EdgeInsetsDirectional.only(start: 16,end: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.cWhite),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          meetingController.getFormattedDate(
                                              meetingController.startDate.value),
                                          style: pRegular12.copyWith(
                                              color: AppColor.textColor),
                                        )),
                                        Icon(
                                          Icons.calendar_month_sharp,
                                          color: AppColor.textColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              meetingController.selectEndDate(context);
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(start: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "End Date".tr,
                                    style: pMedium14,
                                  ),
                                  verticalSpace(5),
                                  Container(
                                    height: 40,
                                    padding: EdgeInsetsDirectional.only(start: 12,end: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.cWhite),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          meetingController.getFormattedDate(
                                              meetingController.endDate.value),
                                          style: pRegular12.copyWith(
                                              color: AppColor.textColor),
                                        )),
                                        Icon(
                                          Icons.calendar_month_sharp,
                                          color: AppColor.textColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 8),
                            child: CommonDropdownButtonWidget(
                              filledColor: AppColor.cWhite,
                              labelText: "Parent",
                              list: meetingController.parentList,
                              onChanged: (value) {
                                meetingController.selectedParentValue.value = value;
                                meetingController.getParentUserList(value.toString());

                              },
                              value: meetingController.selectedParentValue.value,
                              validator: (value) => Validator.validateRequired(
                                value,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Parent User".tr,
                                  style: pMedium14,
                                ),
                                verticalSpace(5),
                                DropdownButtonFormField(
                                    isExpanded: true,
                                    value: meetingController.parentUser.value,
                                    items: meetingController.parentUserList
                                        .map((element) => DropdownMenuItem(
                                            onTap: () {
                                              meetingController.selectedParentUserValue.value = element.id.toString();
                                            },
                                            value: element,
                                            child: Text(
                                              element.name!,
                                              style: pMedium12,
                                              overflow: TextOverflow.ellipsis,
                                            )))
                                        .toList(),
                                    onChanged: (dynamic element) {
                                      meetingController.selectedParentUserValue.value = element.id.toString();
                                    },
                                    dropdownColor: AppColor.cBackGround,
                                    icon: assetSvdImageWidget(
                                      image: ImagePath.dropDownIcn,
                                      colorFilter: ColorFilter.mode(
                                        AppColor.cLabel,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    decoration: dropDownDecoration),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    CreateTextField(
                      controller: meetingController.descriptionController,
                      labelText: 'Description:',
                      maxLines: 3,
                      validator: (v) => Validator.validateRequired(v??""),
                    ),
                    verticalSpace(10),

                    /* Todo Account */
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account".tr,
                                  style: pMedium14,
                                ),
                                verticalSpace(5),
                                DropdownButtonFormField(
                                    isExpanded: true,

                                    value: meetingController.account.value,
                                    items: meetingController.accountList.map((element) => DropdownMenuItem(
                                            onTap: () {
                                              meetingController.selectedAccountValue.value = element.id.toString();
                                            },
                                            value: element,
                                            child: Text(
                                              element.name!,
                                              style: pMedium12,
                                            )))
                                        .toList(),
                                    onChanged: (dynamic value) {
                                      meetingController.selectedAccountValue.value = value.id.toString();
                                    },
                                    dropdownColor: AppColor.cBackGround,
                                    icon: assetSvdImageWidget(
                                      image: ImagePath.dropDownIcn,
                                      colorFilter: ColorFilter.mode(
                                        AppColor.cLabel,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    decoration: dropDownDecoration),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Assign User".tr,
                                  style: pMedium14,
                                ),
                                verticalSpace(5),
                                DropdownButtonFormField(
                                    isExpanded: true,
                                    value: meetingController.assignedUser.value,
                                    items: meetingController.assignUserList
                                        .map((element) => DropdownMenuItem(
                                            onTap: () {
                                              meetingController.assignedUserValue
                                                  .value = element.id.toString();
                                            },
                                            value: element,

                                            child: Text(
                                              element.name!,
                                              style: pMedium12,
                                              overflow: TextOverflow.ellipsis,
                                            )))
                                        .toList(),
                                    onChanged: (dynamic element) {
                                      meetingController.assignedUserValue.value = element.id.toString();
                                    },
                                    dropdownColor: AppColor.cBackGround,
                                    icon: assetSvdImageWidget(
                                      image: ImagePath.dropDownIcn,
                                      colorFilter: ColorFilter.mode(
                                        AppColor.cLabel,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    decoration: dropDownDecoration),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(20),
                    horizontalDivider(color: AppColor.cLabel),
                    verticalSpace(10),
                    Text(
                      "Attendees".tr,
                      style: pMedium14,
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Attendees User".tr,
                                  style: pMedium14,
                                ),
                                verticalSpace(5),
                                DropdownButtonFormField(
                                    isExpanded: true,

                                    value: meetingController.attendeesUser.value,
                                    items: meetingController.attendeesUsersList
                                        .map((element) => DropdownMenuItem(
                                            onTap: () {
                                              meetingController.selectedAttendeesUsers.value = element.id.toString();
                                            },
                                            value: element,
                                            child: Text(
                                              element.name!,
                                              style: pMedium12,
                                              overflow: TextOverflow.ellipsis,

                                            )))
                                        .toList(),
                                    onChanged: (dynamic element) {
                                      meetingController.selectedAttendeesUsers.value = element.id.toString();
                                    },
                                    dropdownColor: AppColor.cBackGround,
                                    icon: assetSvdImageWidget(
                                      image: ImagePath.dropDownIcn,
                                      colorFilter: ColorFilter.mode(
                                        AppColor.cLabel,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    decoration: dropDownDecoration),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Attendees Contact".tr,
                                  style: pMedium14,
                                ),
                                verticalSpace(5),
                                DropdownButtonFormField(
                                    isExpanded: true,

                                    value: meetingController.contact.value,
                                    items: meetingController.contactList
                                        .map((element) => DropdownMenuItem(
                                            onTap: () {
                                              meetingController.selectedAttendeesContact.value = element.id.toString();
                                            },
                                            value: element,
                                            child: Text(
                                              element.name!,
                                              style: pMedium12,
                                            )))
                                        .toList(),
                                    onChanged: (dynamic value) {
                                      meetingController.selectedAttendeesContact.value = value.id.toString();
                                    },
                                    dropdownColor: AppColor.cBackGround,
                                    icon: assetSvdImageWidget(
                                      image: ImagePath.dropDownIcn,
                                      colorFilter: ColorFilter.mode(
                                        AppColor.cLabel,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    decoration: dropDownDecoration),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      "Attendees Lead".tr,
                      style: pMedium14,
                    ),
                    verticalSpace(5),
                    DropdownButtonFormField(
                        isExpanded: true,
                        value: meetingController.attendeesLead.value,
                        items: meetingController.attendeesLeadList
                            .map((element) => DropdownMenuItem(
                                onTap: () {
                                  meetingController.selectedAttendeesLead.value =
                                      element.id.toString();
                                },
                                value: element,
                                child: Text(
                                  element.name!,
                                  style: pMedium12,
                                )))
                            .toList(),
                        onChanged: (value) {},
                        dropdownColor: AppColor.cBackGround,
                        icon: assetSvdImageWidget(
                          image: ImagePath.dropDownIcn,
                          colorFilter: ColorFilter.mode(
                            AppColor.cLabel,
                            BlendMode.srcIn,
                          ),
                        ),
                        decoration: dropDownDecoration),
                    verticalSpace(15),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Get.back();
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
                                    'Close',
                                    style: pMedium18.copyWith(color: AppColor.gray),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 8),
                            child: SizedBox(
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  _debouncer.run((){
                                    if (formKey.currentState!.validate()) {
                                      if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                                        commonToast(AppConstant.demoString);
                                      } else {
                                        meetingController.createMeeting(isUpdate?? false,meetingId??"");
                                      }
                                    }
                                  });


                                },
                                child: Text(
                                  'Save',
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
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}
