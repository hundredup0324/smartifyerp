// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:attendance/core/controller/project/project_controller.dart';
import 'package:attendance/core/controller/project/project_detail_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/views/widgets/common_drop_down_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/dialog_text_field.dart';

class CreateProject extends StatelessWidget {
   CreateProject({super.key});

   ProjectController projectController = Get.find();

   @override
  Widget build(BuildContext context) {

    return Container(
        height: Get.height-200,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          color: AppColor.cWhite,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      "Create New Project".tr,
                      style: pMedium16,
                    )),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColor.cLabel,
                        )),
                  ],
                ),
                verticalSpace(15),
                Divider(
                  height: 1,
                  color: AppColor.ishGrey,
                ),
                verticalSpace(10),
                DialogTextField(
                  controller: projectController.nameController,
                  labelText: 'Name',
                  hintText: "Project Name".tr,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    Validator.validateName(value, "Project Name");
                  },
                  validator: (value) {
                    return Validator.validateEmail(value!);
                  },
                ),
                verticalSpace(10),
                Text("Users", style: pMedium14.copyWith(color: AppColor.cLabel)),
                verticalSpace(10),
                MultiSelectDropDown(
                  clearIcon: Icon(
                    Icons.clear,
                  ),
                  dropdownBackgroundColor: AppColor.textFieldBg,
                  controller: projectController.userController,
                  onOptionSelected: (List<ValueItem> selectedOptions) {
                    projectController.userEmailList.value = selectedOptions.map((data) => data.value.toString()).toList();

                    debugPrint(selectedOptions.toString());
                  },

                  options: projectController.valueItemList,
                  maxItems: 3,
                  hint: "Select User",
                  fieldBackgroundColor: AppColor.textFieldBg,
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
                  dropdownHeight: 300,
                  optionTextStyle: const TextStyle(fontSize: 12),
                  selectedOptionIcon: const Icon(Icons.check_circle),
                ),
                verticalSpace(10),
                verticalSpace(10),
                DialogTextField(
                  controller: projectController.descriptionController,
                  labelText: 'Description',
                  hintText: "Add Description".tr,
                  maxLines: 5,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    Validator.validateName(value, "Add Description");
                  },
                  validator: (value) {
                    return Validator.validateEmail(value!);
                  },
                ),
                verticalSpace(30),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          side:
                              BorderSide(color: AppColor.ishGrey, width: 2.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 16.0, color: AppColor.ishGrey),
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      ElevatedButton(
                        onPressed: () {

                          print("userIdList ${projectController.userEmailList.length}");
                          if (projectController.nameController.text.isEmpty) {
                            commonToast("Name field is required");
                          } else if (projectController.userEmailList.isEmpty) {
                            commonToast("User Selection is required");
                          } else if (projectController
                              .descriptionController.text.isEmpty) {
                            commonToast("Description field is required");
                          } else {
                            Get.back();
                            if (Prefs.getBool(AppConstant.isDemoMode) ==
                                true) {
                              commonToast(AppConstant.demoString);
                            } else {
                              projectController.createProject();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColor.cLabel,
                          textStyle:
                              pMedium16.copyWith(color: AppColor.cWhite),
                          padding: EdgeInsets.all(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                          ),
                          child: Text(
                            'Create',
                            style: TextStyle(
                                fontSize: 16.0, color: AppColor.cWhite),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

    );
  }
}
