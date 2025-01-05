// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/ticket/tickets_controller.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/images.dart';
import 'package:attendance/utils/input_decoration.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/utils/ticket/validator.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_button.dart';
import 'package:attendance/views/widgets/common_drop_down_widget.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_text_field.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class AddTicketScreen extends StatefulWidget {
  final bool isUpdate;
  final String? ticketID;
  final String? name;
  final String? email;
  final String? categoryName;
  final String? subject;
  final String? status;
  final String? description;
  final String? accountType;

  const AddTicketScreen(
      {super.key,
      required this.isUpdate,
      this.ticketID,
      this.name,
      this.accountType,
      this.email,
      this.categoryName,
      this.subject,
      this.status,
      this.description});

  @override
  State<AddTicketScreen> createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  TicketController ticketController = Get.put(TicketController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      createTicketRequestData();
    });
    if (widget.isUpdate == true) {

      var accountTypeValue = widget.accountType!.replaceFirst(
          widget.accountType![0], widget.accountType![0].toUpperCase());
      print("accountType $accountTypeValue");

      ticketController.nameController.text = widget.name!;
      ticketController.emailController.text = widget.email!;
      ticketController.selectedAccountType.value = accountTypeValue;
      ticketController.subjectController.text = widget.subject!;
      ticketController.subjectDescriptionController.text = widget.description!;
      ticketController.statusValue.value = widget.status!;

      ticketController.accountFieldNameList.clear();


      print("categoryList${ticketController.categoryList.length}");
      for (var element in ticketController.categoryList) {
        if (element.name == widget.categoryName) {
          ticketController.categoryValue.value = element.name;
          ticketController.selectedCategoryId.value = element.id.toString();
        }
      }
    } else {
      ticketController.nameController.clear();
      ticketController.emailController.clear();
      ticketController.subjectController.clear();
      ticketController.subjectDescriptionController.clear();
      if (ticketController.statusList.isNotEmpty) {
        ticketController.statusValue.value = ticketController.statusList.first;
      }

      print("categoryLenth ${ticketController.categoryList.length}");
      if (ticketController.categoryList.isNotEmpty) {
        ticketController.categoryValue.value =
            ticketController.categoryList.first.name;
        ticketController.selectedCategoryId.value =
            ticketController.categoryList.first.id.toString();
      }
    }
    print("statusValue-------${ticketController.statusValue.value}");
    print("categoryValue-------${ticketController.categoryValue.value}");
  }
  createTicketRequestData() async
  {
   await ticketController.createTicketData();
   getValue();
  }

  getValue() {
    if (widget.isUpdate == true) {
      for (var element in ticketController.categoryList) {
        if (element.name == widget.categoryName) {
          ticketController.categoryValue.value = element.name;
          ticketController.selectedCategoryId.value = element.id.toString();
        }
      }


      if (ticketController.selectedAccountType.value == "Staff") {
        for (var item in ticketController.staffList) {
          ticketController.accountFieldNameList.add(AccountType(id: item.id.toString(), name:item.name,email: item.email));
        }
      } else if (ticketController.selectedAccountType.value == "Vendor") {
        for (var item in ticketController.vendorList) {
          ticketController.accountFieldNameList.add(AccountType(id: item.id.toString(), name:item.name,email :item.email));
        }
      } else if (ticketController.selectedAccountType.value == "Client") {
        for (var item in ticketController.clientList) {
          ticketController.accountFieldNameList.add(AccountType(id: item.id.toString(), name:item.name,email :item.email));
        }
      }
      for(var element in ticketController.accountFieldNameList)
      {
        if (element.name == widget.name) {
          print("data ${element.name}");

          ticketController.accountNameField.value=element;
        }
      }

    } else {

      if (ticketController.categoryList.isNotEmpty) {
        ticketController.categoryValue.value =
            ticketController.categoryList.first.name;
        ticketController.selectedCategoryId.value =
            ticketController.categoryList.first.id.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColor.cBackGround,
      ),
      padding: EdgeInsets.all(24),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  verticalSpace(10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.isUpdate == true
                              ? "Update Ticket"
                              : "New Ticket",
                          style: pMedium16,
                        ),
                      ),
                      GestureDetector(onTap: (){
                        Get.back();

                      },  child: Icon(Icons.close,color: AppColor.cLabel,size: 24,))
                    ],
                  ),
                  verticalSpace(10),
                  horizontalDivider(),
                  verticalSpace(10),
                  CommonDropdownButtonWidget(
                    labelText: "Account Type",
                    list: ticketController.accountTypeList,
                    onChanged: (value) {
                      ticketController.accountFieldNameList.clear();
                      ticketController.emailController.clear();
                      ticketController.selectedAccountType.value = value;
                      if (ticketController.selectedAccountType.value ==
                          "Staff") {
                        for (var item in ticketController.staffList) {
                          ticketController.accountFieldNameList
                              .add(AccountType(id: item.id.toString(), name:item.name,email :item.email));
                        }
                      } else if (ticketController.selectedAccountType.value ==
                          "Vendor") {
                        for (var item in ticketController.vendorList) {
                          ticketController.accountFieldNameList
                              .add(AccountType(id: item.id.toString(), name:item.name,email :item.email));
                        }
                      } else if (ticketController.selectedAccountType.value == "Client") {
                        for (var item in ticketController.clientList) {
                          ticketController.accountFieldNameList
                              .add(AccountType(id: item.id.toString(), name:item.name,email :item.email));
                        }
                      }
                      if (ticketController.accountFieldNameList.isNotEmpty) {
                        ticketController.accountNameField.value=ticketController.accountFieldNameList.first;
                        ticketController.emailController.text = ticketController.accountFieldNameList.first.email ?? "";
                      }


                    },
                    value: ticketController.selectedAccountType.value,
                    validator: (value) => Validator.validateRequired(value,
                        string: "The Account Type"),
                  ),
                  verticalSpace(16),
                  ticketController.selectedAccountType.value == "Custom"
                      ? CommonTextField(
                          controller: ticketController.nameController,
                          labelText: 'Name*:',
                          hintText: 'Enter name',
                          validator: (v) {
                            return Validator.validateName(v, "Name");
                          },
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select",
                              style: pMedium12,
                            ),
                            verticalSpace(8),
                            Padding(
                              padding:  EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: DropdownButtonFormField(
                                  value: ticketController.accountNameField.value,
                                  hint: Text(
                                    hintText(),
                                    style: pRegular12,
                                  ),
                                  items: ticketController.accountFieldNameList
                                      .map((element) => DropdownMenuItem(
                                          onTap: () {
                                            ticketController
                                                    .emailController.text =
                                                element.email.toString();
                                          },
                                          value: element,
                                          child: Text(
                                            element.name!,
                                            style: pMedium12,
                                          )))
                                      .toList(),
                                  onChanged: (AccountType? value) {
                                    print("value$value");
                                    ticketController.accountNameField.value=value!;

                                  },
                                  dropdownColor: AppColor.cBackGround,
                                  icon: assetSvdImageWidget(
                                    image: DefaultImages.dropDownIcn,
                                    colorFilter: ColorFilter.mode(
                                      AppColor.cLabel,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  decoration: dropDownDecoration),
                            )
                          ],
                        ),
                  verticalSpace(16),
                  CommonTextField(
                    controller: ticketController.emailController,
                    labelText: 'Email:',
                    hintText: 'Enter Email',
                    readOnly: ticketController.accountFieldNameList.isEmpty
                        ? false
                        : true,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => Validator.validateEmail(v),
                  ),
                  verticalSpace(16),
                  ticketController.categoryList.isEmpty
                      ? SizedBox()
                      : Text(
                          "Category:",
                          style: pMedium12,
                        ),
                  ticketController.categoryList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                          child: SizedBox(),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                          child: DropdownButtonFormField(
                              value: ticketController.categoryValue.value,
                              items: ticketController.categoryList
                                  .map((element) => DropdownMenuItem(
                                      onTap: () {
                                        ticketController.selectedCategoryId
                                            .value = element.id.toString();
                                        print("Category ID ${ticketController.selectedCategoryId.toString()}");
                                      },
                                      value: element.name,
                                      child: Text(
                                        element.name!,
                                        style: pMedium12,
                                      )))
                                  .toList(),
                              onChanged: (value) {
                                ticketController.categoryValue.value =
                                    value.toString();

                              },
                              dropdownColor: AppColor.cBackGround,
                              icon: assetSvdImageWidget(
                                image: DefaultImages.dropDownIcn,
                                colorFilter: ColorFilter.mode(
                                  AppColor.cLabel,
                                  BlendMode.srcIn,
                                ),
                              ),
                              decoration: dropDownDecoration),
                        ),
                  CommonDropdownButtonWidget(
                    labelText: "Status",
                    list: ticketController.statusList,
                    onChanged: (value) {
                      print( "Status $value");
                      ticketController.statusValue.value = value;
                      print( "Status $value");

                    },
                    value: ticketController.statusValue.value,
                    validator: (value) =>
                        Validator.validateRequired(value, string: "The status"),
                  ),
                  verticalSpace(16),
                  CommonTextField(
                    controller: ticketController.subjectController,
                    labelText: 'Subject:',
                    hintText: 'Enter Subject',
                    validator: (v) => Validator.validateRequired(v.toString(),
                        string: "The subject"),
                  ),
                  verticalSpace(16),
                  CommonTextField(
                    controller: ticketController.subjectDescriptionController,
                    labelText: 'Description:',
                    hintText: 'Enter Description',
                    maxLines: 5,
                    validator: (v) => Validator.validateRequired(v,
                        string: "The description"),
                  ),
                  verticalSpace(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonIconButton(
                          title: 'Close',
                          iconData: DefaultImages.closeIcn,
                          onPressed: () {
                            Get.back();
                          },
                          width: 75,
                          height: 35,
                          btnColor: AppColor.cButton,
                          textColor: AppColor.cDarkGreyFont,
                        ),
                      ),
                      horizontalSpace(15),
                      Expanded(
                        flex: 2,
                        child: CommonIconButton(
                          title: widget.isUpdate == true ? "Update" : 'Create',
                          iconData: DefaultImages.whiteDoneIcn,
                          onPressed: () {
                            if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                              commonToast(AppConstant.demoString);
                            } else {
                              //api call
                              if (formKey.currentState!.validate()) {
                                if (ticketController.categoryList.isEmpty) {
                                  commonToast("Please add category");
                                } else {
                                 Get.back();
                                  widget.isUpdate == true
                                      ? ticketController
                                          .updateTicket(widget.ticketID ?? "")
                                      : ticketController.createNewTicket();
                                }
                              }
                            }
                          },
                          width: 240,
                          height: 35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  hintText() {
    if (ticketController.selectedAccountType.value == "Vendor") {
      return "Select Vendor";
    } else if (ticketController.selectedAccountType.value == "Staff") {
      return "Select Staff";
    } else if (ticketController.selectedAccountType.value == "Client") {
      return "Select Client";
    } else {
      return "Select";
    }
  }
}


Widget imageDataWidget({String? title, Function()? delete}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        border: Border.all(color: AppColor.cBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              assetSvdImageWidget(
                  image: DefaultImages.documentIcn,
                  colorFilter:
                      ColorFilter.mode(AppColor.cLabel, BlendMode.srcIn)),
              horizontalSpace(8),
              Text(
                title!,
                style: pSemiBold10,
              )
            ],
          ),
          GestureDetector(
            onTap: delete,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: AppColor.cRed,
              child: Icon(Icons.close, color: AppColor.cWhite, size: 16),
            ),
          ),
        ],
      ),
    ),
  );
}
