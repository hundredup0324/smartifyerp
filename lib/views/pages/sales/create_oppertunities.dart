// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/utils/debouncer.dart';
import 'package:attendance/core/controller/sales/oppotunities_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/create_text_field.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/input_decoration.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class CreateOpportunities extends StatelessWidget {
  bool? isUpdate;
  String? opportunityId;

  CreateOpportunities({super.key, this.isUpdate, this.opportunityId});

  OpportunitiesController opController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Debouncer _debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.cWhite,
            surfaceTintColor: Colors.transparent,
            title: Text(
              !isUpdate!?
              "Create New Opportunities".tr:" Update Opportunities",
              style: pMedium16,
            )),
        backgroundColor: AppColor.appBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(

            padding: EdgeInsetsDirectional.only(top: 16, bottom: 25,start: 16,end: 16),
            child: Obx(
              () => Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CreateTextField(
                      controller: opController.nameController,
                      labelText: 'Name',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        Validator.validateRequired(value);
                      },
                      validator: (value) {
                        return Validator.validateRequired(value ?? "");
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      "Account".tr,
                      style: pMedium14,
                    ),
                    verticalSpace(5),
                    DropdownButtonFormField(
                        menuMaxHeight: 300,
                        validator: (value) => value == null || value == ''
                            ? 'field required'
                            : null,
                        value: opController.account.value,
                        items: opController.accountList
                            .map((element) => DropdownMenuItem(
                                onTap: () {
                                  opController.selectedAccountValue.value =
                                      element.id.toString();
                                },
                                value: element,
                                child: Text(
                                  element.name!,
                                  style: pMedium12,
                                )))
                            .toList(),
                        onChanged: (dynamic value) {
                          opController.selectedAccountValue.value =
                              value.id.toString();
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
                    verticalSpace(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Contacts".tr,
                                  style: pMedium14,
                                ),
                                verticalSpace(5),
                                DropdownButtonFormField(
                                    menuMaxHeight: 300,

                                    isExpanded: true,
                                    value: opController.contact.value,
                                    items: opController.contactList
                                        .map((element) => DropdownMenuItem(
                                            onTap: () {
                                              opController.selectedContactValue
                                                      .value =
                                                  element.id.toString();
                                            },
                                            value: element,
                                            child: Text(
                                              element.name!,
                                              style: pMedium12,
                                            )))
                                        .toList(),
                                    onChanged: (dynamic value) {
                                      opController.selectedContactValue.value =
                                          value.id.toString();
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
                                  "Opportunities Stage".tr,
                                  style: pMedium14,
                                ),
                                verticalSpace(5),
                                DropdownButtonFormField(
                                    menuMaxHeight: 300,

                                    isExpanded: true,
                                    value: opController
                                        .selectedOpportunityStage.value,
                                    items: opController.opportunityStageList
                                        .map((element) => DropdownMenuItem(
                                            onTap: () {
                                              opController
                                                  .selectedOpportunityStageId
                                                  .value = element.id.toString();
                                            },
                                            value: element,
                                            child: Text(
                                              element.name!,
                                              style: pMedium12,
                                            )))
                                        .toList(),
                                    onChanged: (dynamic value) {
                                      opController.selectedOpportunityStageId
                                          .value = value.id.toString();
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
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    CreateTextField(
                      controller: opController.amountController,
                      labelText: 'Amount',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        Validator.validateRequired(value);
                      },
                      validator: (value) {
                        return Validator.validateRequired(value ?? "");
                      },
                    ),
                    verticalSpace(10),
                    CreateTextField(
                      controller: opController.probabilityController,
                      labelText: 'Probability',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        Validator.validateRequired(value);
                      },
                      validator: (value) {
                        return Validator.validateRequired(value ?? "");
                      },
                    ),
                    verticalSpace(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              opController.selectDate(context);
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(end: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Close Date".tr,
                                    style: pMedium14,
                                  ),
                                  verticalSpace(5),
                                  Container(
                                    height: 48,
                                    padding: EdgeInsetsDirectional.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColor.cWhite),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          opController.getFormattedDate(
                                              opController.closeDate.value),
                                          style: pRegular12.copyWith(
                                              color: AppColor.cLabel),
                                        )),
                                        Icon(
                                          Icons.calendar_month_sharp,
                                          color: AppColor.cLabel,
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
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 8),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lead Source".tr,
                                  style: pMedium14,
                                ),
                                verticalSpace(5),
                                DropdownButtonFormField(
                                    menuMaxHeight: 300,

                                    isExpanded: true,
                                    value: opController.leadSource.value,
                                    items: opController.leadSourceList
                                        .map((element) => DropdownMenuItem(
                                            onTap: () {
                                              opController
                                                      .selectedLeadSourceValue
                                                      .value =
                                                  element.id.toString();
                                            },
                                            value: element,
                                            child: Text(
                                              element.name!,
                                              style: pMedium12,
                                            )))
                                        .toList(),
                                    onChanged: (dynamic value) {
                                      opController.selectedLeadSourceValue
                                          .value = value.id.toString();
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
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      "Assign User".tr,
                      style: pMedium14,
                    ),
                    verticalSpace(5),
                    DropdownButtonFormField(
                        menuMaxHeight: 300,
                        itemHeight: null,
                        isExpanded: true,
                        value: opController.assignUser.value,
                        items: opController.assignUserList
                            .map((element) => DropdownMenuItem(
                                onTap: () {
                                  opController.assignUserIdValue.value =
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
                          opController.assignUserIdValue.value =
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
                        decoration: dropDownDecoration),
                    verticalSpace(10),
                    CreateTextField(
                      controller: opController.descriptionController,
                      labelText: 'Description',
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        Validator.validateRequired(value);
                      },
                      validator: (value) {
                        return Validator.validateRequired(value ?? "");
                      },
                    ),
                    verticalSpace(30),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 8),
                            child: SizedBox(
                              height: 45,
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: AppColor.gray, width: 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                child: Text(
                                  'Close',
                                  style:
                                      pMedium18.copyWith(color: AppColor.gray),
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
                                  print("currentState ${formKey.currentState!.validate()}");

                                  _debouncer.run(() {
                                    if (formKey.currentState!.validate()) {
                                      if (Prefs.getBool(
                                              AppConstant.isDemoMode) ==
                                          true) {
                                        commonToast(AppConstant.demoString);
                                      } else {
                                        if (isUpdate == true) {
                                          opController.updateOpportunity(
                                              opportunityId.toString());
                                        } else {
                                          opController.createOpportunity();
                                        }
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  'Save',
                                  style: pMedium18.copyWith(
                                      color: AppColor.cWhite),
                                ),
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                      color: Colors.transparent, width: 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
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
