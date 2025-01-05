// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/multi/lib/multi_dropdown.dart';
import 'package:attendance/utils/debouncer.dart';
import 'package:attendance/core/model/request_data_response.dart';
import 'package:attendance/core/controller/sales/quote_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/create_text_field.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/input_decoration.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/core/model/quote_response.dart';
import 'package:attendance/views/widgets/common_drop_down_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class CreateQuote extends StatefulWidget {
  bool isUpdate = false;
  String? quoteId;
  QuoteData? data;

  CreateQuote({super.key, this.isUpdate = false, this.quoteId, this.data});

  @override
  State<CreateQuote> createState() => _CreateQuoteState();
}

class _CreateQuoteState extends State<CreateQuote> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  QuoteController quoteController = Get.find();

  final Debouncer _debouncer = Debouncer(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate == true) {
      for (var tax in widget.data!.tax ?? []) {
        print("tax id ${tax.id}");
        quoteController.controller.selectWhere((taxItem) {
          print("select where ${taxItem.value.id}");
          return taxItem.value.id == tax.id;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.appBackgroundColor,
        appBar: AppBar(
            backgroundColor: AppColor.cWhite,
            surfaceTintColor: Colors.transparent,
            title: Text(
              !widget.isUpdate ? "Create New Quote".tr : "Update Quote".tr,
              style: pMedium16,
            )),
        body: Padding(
          padding: EdgeInsetsDirectional.only(
              end: 16, start: 16, top: 16, bottom: 25),
          child: SingleChildScrollView(
            child: Obx(
              () => Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreateTextField(
                      controller: quoteController.nameController,
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
                      "Opportunity".tr,
                      style: pMedium14,
                    ),
                    verticalSpace(8),
                    DropdownButtonFormField(
                        menuMaxHeight: 300,
                        isExpanded: true,
                        value: quoteController.selectedOpportunityModel.value,
                        items: quoteController.opportunityList
                            .map((element) => DropdownMenuItem(
                                onTap: () {
                                  quoteController.selectedOpportunityId.value =
                                      element.id.toString();

                                  quoteController.accountController.text =
                                      element.accountName.toString();
                                },
                                value: element,
                                child: Text(
                                  element.name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: pMedium14,
                                )))
                            .toList(),
                        onChanged: (dynamic value) {
                          quoteController.accountController.text =
                              value.accountName.toString();
                          quoteController.selectedOpportunityId.value =
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
                      controller: quoteController.accountController,
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
                            list: quoteController.statusList,
                            onChanged: (value) {
                              quoteController.selectedStatus.value = value;
                            },
                            value: quoteController.selectedStatus.value,
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
                                      quoteController.quoteNumberController,
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
                      "Date Quoted".tr,
                      style: pMedium14,
                    ),
                    verticalSpace(8),
                    GestureDetector(
                      onTap: () async {
                        quoteController.selectDate(context);
                      },
                      child: Container(
                        height: 40,
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.cWhite),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              quoteController.getFormattedDate(
                                  quoteController.quotedDate.value),
                              style: pMedium12.copyWith(color: AppColor.cLabel),
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
                                        value: quoteController
                                            .billingContactModel.value,
                                        items: quoteController
                                            .billingContactList
                                            .toSet()
                                            .toList()
                                            .map((element) => DropdownMenuItem(
                                                onTap: () {
                                                  quoteController
                                                          .billingContactID
                                                          .value =
                                                      element.id.toString();
                                                },
                                                value: element,
                                                child: Text(
                                                  element.name!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: pMedium12,
                                                )))
                                            .toList(),
                                        onChanged: (dynamic element) {
                                          quoteController.billingContactID
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
                                        value: quoteController
                                            .shippingContactModel.value,
                                        items: quoteController
                                            .shippingContactList
                                            .map((element) => DropdownMenuItem(
                                                onTap: () {
                                                  quoteController
                                                          .shippingContactId
                                                          .value =
                                                      element.id.toString();
                                                },
                                                value: element,
                                                child: Text(
                                                  element.name!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: pMedium12,
                                                )))
                                            .toList(),
                                        onChanged: (dynamic element) {
                                          quoteController.shippingContactId
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
                      controller: quoteController.billingAddressController,
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
                            controller: quoteController.billingCityController,
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
                            controller: quoteController.billingStateController,
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
                            controller:
                                quoteController.billingCountryController,
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
                            controller:
                                quoteController.billingZipCodeController,
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
                      controller: quoteController.shippingAddressController,
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
                            controller: quoteController.shippingCityController,
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
                            controller: quoteController.shippingStateController,
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
                            controller:
                                quoteController.shippingCountryController,
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
                            controller:
                                quoteController.shippingZipCodeController,
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
                    MultiDropdown<DropdownModel>(

                      controller: quoteController.controller,
                      items: quoteController.valueItemList,
                      maxSelections: 3,
                      fieldDecoration: FieldDecoration(
                        hintText: 'Select Tax',
                        hintStyle: pMedium14,
                        labelStyle: pMedium14.copyWith(color: AppColor.cWhite),
                        showClearIcon: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    dropdownDecoration: DropdownDecoration(
                      backgroundColor: AppColor.primaryColor
                    ),
                      dropdownItemDecoration: DropdownItemDecoration(
                        selectedBackgroundColor: AppColor.primaryColor,
                        backgroundColor: AppColor.primaryColor,
                          selectedIcon: Icon(Icons.check_circle)),
                      chipDecoration: ChipDecoration(
                        labelStyle: pMedium14.copyWith(color: AppColor.cWhite),
                        padding: EdgeInsets.all(8),
                        backgroundColor: AppColor.greenColor,
                        wrap: true,
                        runSpacing: 2,
                        spacing: 10,
                      ),
                    ),
                    /*       MultiSelectDropDown(
                      selectedOptions: quoteController.selectedTaxList,
                      dropdownBackgroundColor: AppColor.cWhite,
                      controller: quoteController.controller,
                      onOptionSelected: (List<ValueItem> selectedOptions) {
                        quoteController.taxCategoryList.value =
                            selectedOptions.map((data) => data.value).toList();
                      },
                      options: quoteController.valueItemList,
                      maxItems: 3,
                      hint: "Select Tax",
                      fieldBackgroundColor: AppColor.cWhite,
                      borderRadius: 10,
                      borderColor: AppColor.textFieldBg,
                      borderWidth: 0,
                      selectionType: SelectionType.multi,
                      hintColor: AppColor.cLabel,
                      chipConfig: const ChipConfig(
                        wrapType: WrapType.wrap,
                        spacing: 4,
                        runSpacing: 4,
                      ),
                      dropdownHeight: 200,
                      optionTextStyle: const TextStyle(fontSize: 12),
                      selectedOptionIcon: const Icon(Icons.check_circle),
                    ),*/
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
                                    value: quoteController
                                        .shippingProviderModel.value,
                                    items: quoteController.shippingProviderList
                                        .map((element) => DropdownMenuItem(
                                            onTap: () {
                                              quoteController.shippingProviderId
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
                                      quoteController.shippingProviderId.value =
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
                                    value:
                                        quoteController.assignUserModel.value,
                                    items: quoteController.assignUserList
                                        .map((element) => DropdownMenuItem(
                                            onTap: () {
                                              quoteController
                                                      .assignUserId.value =
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
                      controller: quoteController.descriptionController,
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
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  _debouncer.run(() {
                                    if (formKey.currentState!.validate()) {
                                      if (Prefs.getBool(
                                              AppConstant.isDemoMode) ==
                                          true) {
                                        commonToast(AppConstant.demoString);
                                      } else if (quoteController
                                          .controller.selectedItems.isEmpty) {
                                        commonToast("Tax is required");
                                      } else {
                                        quoteController.createQuote(
                                            widget.isUpdate,
                                            widget.quoteId ?? "");
                                      }
                                    }
                                  });
                                },
                                // ignore: sort_child_properties_last
                                child: Text(
                                  'Save'.tr,
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

  @override
  void dispose() {
    super.dispose();
    quoteController.controller.clearAll();
  }
}
