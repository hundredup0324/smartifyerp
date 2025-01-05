import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/project/project_detail_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/views/widgets/common_drop_down_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/dialog_text_field.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class EditProject extends StatelessWidget {
  const EditProject({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectDetailController projectDetailController = Get.find();
    return Obx(
      () => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                color: AppColor.cWhite,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        "Edit Project".tr,
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
                    controller: projectDetailController.nameController,
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
                  DialogTextField(
                    controller: projectDetailController.descriptionController,
                    labelText: 'Description',
                    hintText: "Add Description".tr,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      Validator.validateName(value, "Add Description");
                    },
                    validator: (value) {
                      return Validator.validateEmail(value!);
                    },
                  ),
                  verticalSpace(10),
                  CommonDropdownButtonWidget(
                    labelText: "Status",
                    filledColor: AppColor.textFieldBg,
                    list: projectDetailController.staticStatusList,
                    onChanged: (value) {
                      projectDetailController.projectStatus.value = value;
                    },
                    value: projectDetailController.projectStatus.value,
                    validator: (value) =>
                        Validator.validateName(value, "The Status"),
                  ),
                  verticalSpace(10),
                  DialogTextField(
                    controller: projectDetailController.budgetController,
                    labelText: 'Budget',
                    hintText: "Budget".tr,
                    listInputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,

                    onChanged: (value) {
                      Validator.validateName(value, "Budget");
                    },
                    validator: (value) {
                      return Validator.validateEmail(value!);
                    },
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
                            projectDetailController.selectStartDate(context);
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
                                      projectDetailController.getFormattedDate(
                                          projectDetailController
                                              .startDate.value),
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
                            projectDetailController.selectEndDate(context);
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
                                  projectDetailController.getFormattedDate(
                                      projectDetailController.endDate.value),
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
                            Get.back();
                            if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                              commonToast(AppConstant.demoString);
                            } else {
                              projectDetailController.updateProject();
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
                              'Update',
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
        ),
      ),
    );
  }
}
