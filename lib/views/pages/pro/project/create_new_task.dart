// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:attendance/core/controller/project/project_controller.dart';
import 'package:attendance/core/controller/project/task_controller.dart';
import 'package:attendance/core/model/project_detail_response.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/views/widgets/common_drop_down_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/dialog_text_field.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class CreateNewTask extends StatelessWidget {
  bool? isEdit;
  String? taskId;
  List<ValueItem>? selectedUserList;

  CreateNewTask({super.key, this.isEdit, this.taskId, this.selectedUserList});

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find();

    return Container(
      height: Get.height - 200,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: AppColor.cWhite,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      isEdit == true ? "Update Task" : "Create New Task".tr,
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
                verticalSpace(20),
                DialogTextField(
                  controller: taskController.titleController,
                  labelText: 'Title',
                  hintText: "Enter Title".tr,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    Validator.validateName(value, "Title");
                  },
                  validator: (value) {
                    return Validator.validateName(value!, "title");
                  },
                ),
                verticalSpace(10),
                Text(
                  "MileStone",
                  style: pMedium12,
                ),
                verticalSpace(10),
                DropdownButtonFormField(
                  value: taskController.selectedMileStone.value,
                  items: taskController
                      .projectDetailController.mileStoneList
                      .map((element) => DropdownMenuItem(
                          onTap: () {
                            taskController.selectedMileStoneId.value =
                                element.id.toString();
                          },
                          value: element.title,
                          child: Text(
                            element.title!,
                            style: pMedium12,
                          )))
                      .toList(),
                  onChanged: (value) {
                    taskController.selectedMileStone.value = value.toString();
                  },
                  dropdownColor: AppColor.cBackGround,
                  icon: assetSvdImageWidget(
                    image: ImagePath.dropDownIcn,
                    colorFilter: ColorFilter.mode(
                      AppColor.cLabel,
                      BlendMode.srcIn,
                    ),
                  ),
                  isExpanded: true,
                  padding: EdgeInsets.zero,
                  hint: Text(
                    "Select Milestone".tr,
                    textAlign: TextAlign.center,
                    style: pMedium12.copyWith(color: AppColor.cLabel),
                  ),
                  decoration: InputDecoration(
                    fillColor: AppColor.textFieldBg,
                    filled: true,

                    // hintStyle: pMedium12.copyWith(color: AppColor.cLabel),
                    contentPadding:
                        EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColor.textFieldBg, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColor.textFieldBg, width: 0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColor.redColor, width: 0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColor.textFieldBg, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColor.textFieldBg, width: 0),
                    ),
                  ),
                ),
                verticalSpace(10),
                CommonDropdownButtonWidget(
                  labelText: "Priority",
                  filledColor: AppColor.textFieldBg,
                  list: taskController.priorityList,
                  onChanged: (value) {
                    taskController.selectedPriority.value = value;
                  },
                  value: taskController.selectedPriority.value,
                  validator: (value) =>
                      Validator.validateName(value, "Priority"),
                ),
                verticalSpace(10),
                Text(
                  "Assign To",
                  style: pMedium14.copyWith(color: AppColor.cLabel),
                ),
                verticalSpace(10),
                MultiSelectDropDown(
                  selectedOptions: selectedUserList ?? [],
                  dropdownBackgroundColor: AppColor.textFieldBg,
                  controller: taskController.controller,
                  onOptionSelected: (List<ValueItem> selectedOptions) {
                    taskController.userIdList.value = selectedOptions
                        .map((data) => data.value.toString())
                        .toList();

                    debugPrint(selectedOptions.toString());
                  },
                  options:
                      taskController.projectDetailController.valueItemList,
                  maxItems: 3,
                  hint: "Assign to",
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
                          taskController.selectStartDate(context);
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.textFieldBg,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                assetSvdImageWidget(
                                    image: ImagePath.calender),
                                horizontalSpace(8),
                                Text(
                                    taskController.getFormattedDate(
                                        taskController.startDate.value),
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
                          taskController.selectEndDate(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.textFieldBg,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              assetSvdImageWidget(image: ImagePath.calender),
                              horizontalSpace(8),
                              Text(
                                taskController.getFormattedDate(
                                    taskController.endDate.value),
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
                verticalSpace(20),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Get.back();
                          // Add your onPressed action here
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
                          if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                            commonToast(AppConstant.demoString);
                          } else {
                            Get.back();
                            if (isEdit == true) {
                              taskController.updateTask(taskId ?? "");
                            } else {
                              taskController.createTask();
                            }
                          }

                          // Add your onPressed action here
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
                            isEdit == true ? 'Update' : "Create",
                            style: TextStyle(
                                fontSize: 16.0, color: AppColor.cWhite),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
