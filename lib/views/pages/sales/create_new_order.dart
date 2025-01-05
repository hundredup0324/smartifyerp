// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/create_text_field.dart';
import 'package:attendance/utils/debouncer.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/input_decoration.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/core/controller/sales/sales_oreder_controller.dart';
import 'package:attendance/views/widgets/common_drop_down_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class CreateNewOrders extends StatelessWidget
{
  bool? isUpdate;
  String? salesOrderId;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SalesOrderController salesOrderController= Get.find();
  final Debouncer _debouncer = Debouncer(milliseconds: 1000);

  CreateNewOrders({super.key,this.isUpdate,this.salesOrderId,});
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.appBackgroundColor,
        appBar: AppBar(
            backgroundColor: AppColor.cWhite,
            surfaceTintColor: Colors.transparent,
            title: Text(
            !isUpdate!?
              "Create New SalesOrder".tr:"Update SalesOrder".tr,
              style: pMedium16,
            )),
        body: Padding(
          padding: EdgeInsetsDirectional.only(end: 16, start: 16, top: 16, bottom: 25),
          child: SingleChildScrollView(
            child: Obx(() => Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateTextField(
                    controller: salesOrderController.nameController,
                    labelText: 'Name',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      Validator.validateRequired(value);
                    },
                    validator: (value) {
                      return Validator.validateRequired(value!);
                    },
                  ),
                  verticalSpace(10),
                  Text(
                    "Quote".tr,
                    style: pMedium14,
                  ),
                  verticalSpace(8),
                  DropdownButtonFormField(
                      menuMaxHeight: 300,
                      isExpanded: true,
                      value: salesOrderController.selectedQuoteModel.value,
                      items: salesOrderController.quoteList
                          .map((element) => DropdownMenuItem(
                          onTap: () {
                            salesOrderController.selectedQuoteId.value =
                                element.id.toString();

                          },
                          value: element,
                          child: Text(
                            element.name!,
                            overflow: TextOverflow.ellipsis,
                            style: pMedium12,
                          )))
                          .toList(),
                      onChanged: (dynamic value) {

                        salesOrderController.selectedQuoteId.value =
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
                  Text(
                    "Opportunity".tr,
                    style: pMedium14,
                  ),
                  verticalSpace(8),
                  DropdownButtonFormField(
                      menuMaxHeight: 300,
                      isExpanded: true,
                      value: salesOrderController.selectedOpportunityModel.value,
                      items: salesOrderController.opportunityList
                          .map((element) => DropdownMenuItem(
                          onTap: () {
                            salesOrderController.selectedOpportunityId.value =
                                element.id.toString();
                            salesOrderController.accountId.value=element.accountId.toString();

                            salesOrderController.accountController.text =
                                element.accountName.toString();
                          },
                          value: element,
                          child: Text(
                            element.name!,
                            overflow: TextOverflow.ellipsis,
                            style: pMedium12,
                          )))
                          .toList(),
                      onChanged: (dynamic value) {
                        salesOrderController.accountController.text =
                            value.accountName.toString();
                        salesOrderController.accountId.value=value.accountId.toString();
                        salesOrderController.selectedOpportunityId.value =
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
                  CreateTextField(
                    controller: salesOrderController.accountController,
                    readOnly: true,
                    labelText: 'Account',
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
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 5),
                            child: CommonDropdownButtonWidget(
                              filledColor: AppColor.cWhite,
                              labelText: "Status",
                              list: salesOrderController.statusList,
                              onChanged: (value) {
                                salesOrderController.selectedStatus.value = value;
                              },
                              value: salesOrderController.selectedStatus.value,
                              validator: (value) => Validator.validateRequired(
                                value,
                              ),
                            ),
                          )),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsetsDirectional.only(start: 5),
                              child: CreateTextField(
                                controller:
                                salesOrderController.quoteNumberController,
                                labelText: 'Quote Number',
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  Validator.validateRequired(value);
                                },
                                validator: (value) {
                                  return Validator.validateRequired(
                                      value ?? "");
                                },
                              )))
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    "Date SalesOrder".tr,
                    style: pMedium14,
                  ),
                  verticalSpace(8),
                  GestureDetector(
                    onTap: () async {
                      salesOrderController.selectDate(context);
                    },
                    child: Container(
                      height: 40,
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.cWhite),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                                commonDateFormat(salesOrderController.salesOrderDate.value),
                                style: pRegular12.copyWith(color: AppColor.cLabel),
                              )),
                          Icon(
                            Icons.calendar_month_sharp,
                            color: AppColor.cLabel,
                          )
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsetsDirectional.only(end: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Billing Contact".tr,
                                    style: pMedium14,
                                  ),
                                  verticalSpace(8),
                                  DropdownButtonFormField(
                                      menuMaxHeight: 300,
                                      isExpanded: true,
                                      value: salesOrderController.billingContactModel.value,
                                      items: salesOrderController.billingContactList
                                          .toSet()
                                          .toList()
                                          .map((element) => DropdownMenuItem(
                                          onTap: () {
                                            salesOrderController.billingContactID
                                                .value =
                                                element.id.toString();
                                          },
                                          value: element,
                                          child: Text(
                                            element.name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: pMedium12,
                                          )))
                                          .toList(),
                                      onChanged: (dynamic element) {
                                        salesOrderController.billingContactID.value =
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
                                ],
                              ))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsetsDirectional.only(start: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shipping Contact".tr,
                                    style: pMedium14,
                                  ),
                                  verticalSpace(8),
                                  DropdownButtonFormField(
                                      menuMaxHeight: 300,
                                      isExpanded: true,
                                      value: salesOrderController
                                          .shippingContactModel.value,
                                      items: salesOrderController.shippingContactList
                                          .map((element) => DropdownMenuItem(
                                          onTap: () {
                                            salesOrderController
                                                .shippingContactId
                                                .value =
                                                element.id.toString();
                                          },
                                          value: element,
                                          child: Text(
                                            element.name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: pMedium12,
                                          )))
                                          .toList(),
                                      onChanged: (dynamic element) {
                                        salesOrderController.shippingContactId
                                            .value = element.id.toString();
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
                              ))),
                    ],
                  ),
                  verticalSpace(10),
                  CreateTextField(
                    controller: salesOrderController.billingAddressController,
                    labelText: 'Billing Address'.tr,
                    keyboardType: TextInputType.text,
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
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 5),
                            child: CreateTextField(
                              controller: salesOrderController.billingCityController,
                              labelText: 'Billing City'.tr,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                Validator.validateRequired(value);
                              },
                              validator: (value) {
                                return Validator.validateRequired(value ?? "");
                              },
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 5),
                            child: CreateTextField(
                              controller: salesOrderController.billingStateController,
                              labelText: 'Billing State'.tr,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                Validator.validateRequired(value);
                              },
                              validator: (value) {
                                return Validator.validateRequired(value ?? '');
                              },
                            ),
                          ))
                    ],
                  ),
                  verticalSpace(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 5),
                            child: CreateTextField(
                              controller: salesOrderController.billingCountryController,
                              labelText: 'Billing Country'.tr,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                Validator.validateRequired(value);
                              },
                              validator: (value) {
                                return Validator.validateRequired(value ?? "");
                              },
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 5),
                            child: CreateTextField(
                              controller: salesOrderController.billingZipCodeController,
                              labelText: 'Billing Postal Code'.tr,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                Validator.validateRequired(value);
                              },
                              validator: (value) {
                                return Validator.validateRequired(value ?? "");
                              },
                            ),
                          ))
                    ],
                  ),
                  verticalSpace(10),
                  CreateTextField(
                    controller: salesOrderController.shippingAddressController,
                    labelText: 'Shipping Address'.tr,
                    keyboardType: TextInputType.text,
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
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 5),
                            child: CreateTextField(
                              controller: salesOrderController.shippingCityController,
                              labelText: 'Shipping City'.tr,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                Validator.validateRequired(value);
                              },
                              validator: (value) {
                                return Validator.validateRequired(value ?? "");
                              },
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 5),
                            child: CreateTextField(
                              controller: salesOrderController.shippingStateController,
                              labelText: 'Shipping State'.tr,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                Validator.validateRequired(value);
                              },
                              validator: (value) {
                                return Validator.validateRequired(value ?? "");
                              },
                            ),
                          ))
                    ],
                  ),
                  verticalSpace(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 5),
                            child: CreateTextField(
                              controller: salesOrderController.shippingCountryController,
                              labelText: 'Shipping Country'.tr,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                Validator.validateRequired(value);
                              },
                              validator: (value) {
                                return Validator.validateRequired(value ?? "");
                              },
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 5),
                            child: CreateTextField(
                              controller: salesOrderController.shippingZipCodeController,
                              labelText: 'Shipping Postal Code'.tr,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                Validator.validateRequired(value);
                              },
                              validator: (value) {
                                return Validator.validateRequired(value ?? "");
                              },
                            ),
                          ))
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    "Tax".tr,
                    style: pMedium14,
                  ),
                  verticalSpace(8),
                  DropdownButtonFormField(
                      menuMaxHeight: 300,
                      isExpanded: true,
                      value: salesOrderController.selectedTaxModel.value,
                      items: salesOrderController.taxList
                          .map((element) => DropdownMenuItem(
                          onTap: () {
                            salesOrderController.selectedTaxId.value = element.id.toString();
                          },
                          value: element,
                          child: Text(
                            element.name!,
                            overflow: TextOverflow.ellipsis,
                            style: pMedium12,
                          ))).toList(),
                      onChanged: (dynamic element) {
                        salesOrderController.selectedTaxId.value = element.id.toString();
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
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(end: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Shipping Provider".tr,
                                style: pMedium14,
                              ),
                              verticalSpace(8),
                              DropdownButtonFormField(
                                  menuMaxHeight: 300,
                                  isExpanded: true,
                                  value: salesOrderController
                                      .shippingProviderModel.value,
                                  items: salesOrderController.shippingProviderList
                                      .map((element) => DropdownMenuItem(
                                      onTap: () {
                                        salesOrderController.shippingProviderId
                                            .value = element.id.toString();
                                      },
                                      value: element,
                                      child: Text(
                                        element.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: pMedium12,
                                      )))
                                      .toList(),
                                  onChanged: (dynamic element) {
                                    salesOrderController.shippingProviderId.value =
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
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(end: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Assign User".tr,
                                style: pMedium14,
                              ),
                              verticalSpace(8),
                              DropdownButtonFormField(
                                  menuMaxHeight: 300,
                                  isExpanded: true,
                                  value: salesOrderController.assignUserModel.value,
                                  items: salesOrderController.assignUserList
                                      .map((element) => DropdownMenuItem(
                                      onTap: () {
                                        salesOrderController.assignUserId.value =
                                            element.id.toString();
                                      },
                                      value: element,
                                      child: Text(
                                        element.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: pMedium12,
                                      )))
                                      .toList(),
                                  onChanged: (value) {
                                    /* ticketController.categoryValue.value =
                                          value.toString()*/
                                    ;
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
                    ],
                  ),
                  verticalSpace(10),
                  CreateTextField(
                    controller: salesOrderController.descriptionController,
                    labelText: 'Description'.tr,
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
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: AppColor.gray, width: 1.0),
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
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: 8),
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                _debouncer.run((){
                                  if (formKey.currentState!.validate()) {
                                    if (Prefs.getBool(AppConstant.isDemoMode) ==
                                        true) {
                                      commonToast(AppConstant.demoString);
                                    } else {
                                      salesOrderController.createSalesOrder(
                                          isUpdate ?? false, salesOrderId ?? "");
                                    }
                                  }
                                });

                              },
                              // ignore: sort_child_properties_last
                              child: Text(
                                'Save'.tr,
                                style:
                                pMedium18.copyWith(color: AppColor.cWhite),
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