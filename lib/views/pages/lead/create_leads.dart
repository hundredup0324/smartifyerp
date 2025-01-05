// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/lead/lead_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/input_decoration.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/dialog_text_field.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CreateLeads extends StatelessWidget {
  bool? isEdit;

  CreateLeads({super.key, this.isEdit, this.leadId});

  String? leadId;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LeadController leadController = Get.find();

  @override
  Widget build(BuildContext context) {
    print("assign user from create lead${jsonEncode(leadController.assignUser)}");

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.appBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.darkGreen,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => {
              Get.back(result: {
                "profileImage": Prefs.getString(AppConstant.profileImage)
              })
            },
          ),
          title: Text(
            isEdit == true ? "Edit Lead" : "Create Lead".tr,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColor.cWhite),
          ),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 30),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DialogTextField(
                      controller: leadController.subjectController,
                      labelText: 'Subject',
                      hintText: "Enter Subject".tr,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        Validator.validateName(value, "Subject");
                      },
                      validator: (value) {
                        return Validator.validateName(value!, "Subject");
                      },
                    ),
                    verticalSpace(12),
                    leadController.isCompany.value
                        ? Text(
                            "User",
                            style: pMedium14.copyWith(color: AppColor.cLabel),
                          )
                        : SizedBox(),
                    leadController.isCompany.value
                        ? verticalSpace(10)
                        : verticalSpace(0),
                    leadController.isCompany.value
                        ? DropdownButtonFormField(
                            menuMaxHeight: 300,
                            itemHeight: null,
                            isExpanded: true,
                            validator: (value) {
                              if (value == null) {
                                return "Please select user";
                              }
                              return null;
                            },
                            value: leadController.assignUser.value,
                            items: leadController.userDataList
                                .map((element) => DropdownMenuItem(
                                    onTap: () {
                                      leadController.assignUserIdValue.value =
                                          element.id.toString();
                                    },
                                    value: element,
                                    child: Text(
                                      element.name!,
                                      style: pMedium12,
                                      overflow: TextOverflow.ellipsis,
                                    )))
                                .toList(),
                            onChanged: (dynamic element) {
                              leadController.assignUserIdValue.value =
                                  element.id.toString();
                            },
                            dropdownColor: AppColor.cBackGround,
                            icon: assetSvdImageWidget(
                              image: ImagePath.dropDownIcn,
                              colorFilter: ColorFilter.mode(
                                AppColor.cLabel,
                                BlendMode.srcIn,
                              ),
                            ),
                            decoration: dropDownDecoration)
                        : SizedBox(),
                    leadController.isCompany.value
                        ? verticalSpace(12)
                        : verticalSpace(0),
                    DialogTextField(
                      controller: leadController.nameController,
                      labelText: 'Name',
                      hintText: "Enter Name".tr,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        Validator.validateName(value, "Name");
                      },
                      validator: (value) {
                        return Validator.validateName(value!, "Name");
                      },
                    ),
                    verticalSpace(12),
                    DialogTextField(
                      controller: leadController.phoneController,
                      labelText: 'Phone',
                      hintText: "Enter Phone".tr,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        Validator.validateMobile(value);
                      },
                      validator: (value) {
                        return Validator.validateMobile(value.toString());
                      },
                    ),
                    verticalSpace(12),
                    DialogTextField(
                      controller: leadController.emailController,
                      labelText: 'Email',
                      hintText: "Enter Email".tr,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        Validator.validateEmail(value);
                      },
                      validator: (value) {
                        return Validator.validateEmail(value ?? "");
                      },
                    ),
                    verticalSpace(12),
                    Text(
                      "Follow Up Date",
                      style: pMedium14.copyWith(color: AppColor.cLabel),
                    ),
                    verticalSpace(10),
                    GestureDetector(
                      onTap: () {
                        leadController.selectStartDate(context);
                      },
                      child: Container(
                        height: 50,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.cWhite,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              assetSvdImageWidget(image: ImagePath.calender),
                              horizontalSpace(8),
                              Text(
                                  leadController.getFormattedDate(
                                      leadController.followUpDate.value),
                                  style: pMedium14.copyWith(
                                      color: AppColor.cBlack))
                            ],
                          )),
                    ),
                    verticalSpace(30),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (leadController.isCompany.value == true) {
                              await leadValidation();
                            } else {
                              await leadValidation();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColor.cLabel,
                          textStyle: pMedium16.copyWith(color: AppColor.cWhite),
                          padding: EdgeInsets.all(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                          ),
                          child: Text(
                            isEdit == true ? "Update Lead" : 'Create Lead',
                            style: TextStyle(
                                fontSize: 16.0, color: AppColor.cWhite),
                          ),
                        ),
                      ),
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

  leadValidation() async {
    if (Prefs.getBool(AppConstant.isDemoMode) == true) {
      commonToast(AppConstant.demoString);
    } else {
      if (isEdit == true) {
        var result = await leadController.updateLead(leadId ?? "");
        if (result == true) {
          Get.back(result: true);
        }
      } else {
        var result = await leadController.createLead();
        if (result == true) {
          Get.back(result: true);
        }
      }
    }
  }
}
