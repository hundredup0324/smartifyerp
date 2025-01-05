// ignore_for_file: prefer_const_constructors

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/ticket/replay_ticket_controller.dart';
import 'package:attendance/core/controller/ticket/tickets_controller.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/images.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/utils/ticket/validator.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_button.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_text_field.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

import 'add_ticket_screen.dart';

class ReplayTicketsScreen extends StatefulWidget {
  final String ticketID;

  ReplayTicketsScreen({super.key, required this.ticketID});

  @override
  State<ReplayTicketsScreen> createState() => _ReplayTicketsScreenState();
}

class _ReplayTicketsScreenState extends State<ReplayTicketsScreen> {
  ReplayController replayController = Get.put(ReplayController());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    replayController.descriptionController.clear();
    replayController.imagePathList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColor.cBackGround,
      ),
      padding: EdgeInsets.all(24),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        assetSvdImageWidget(
                          image: DefaultImages.closeIcn,
                          colorFilter: ColorFilter.mode(AppColor.cGreenFont, BlendMode.srcIn),
                        ),
                        horizontalSpace(8),
                        Text(
                          "Close",
                          style: pSemiBold12.copyWith(
                            color: AppColor.cGreenFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(8),
                  Text(
                    "Create",
                    style: pRegular12,
                  ),
                  verticalSpace(10),
                  Text(
                    "Add Reply",
                    style: pRegular18.copyWith(
                      color: AppColor.cGreenFont,
                    ),
                  ),
                  verticalSpace(10),
                  horizontalDivider(),
                  verticalSpace(10),
                  CommonTextField(
                    controller: replayController.descriptionController,
                    labelText: 'Description',
                    hintText: 'Description',
                    validator: (v) => Validator.validateRequired(v, string: 'The Description'),
                    maxLines: 6,
                  ),
                  verticalSpace(16),
                  Text(
                    'Attachments',
                    style: pMedium12,
                  ),
                  verticalSpace(8),
                  Text(
                    '(You can select multiple files)',
                    style: pRegular12.copyWith(color: AppColor.cDarkGreyFont),
                  ),
                  verticalSpace(16),
                  DottedBorder(
                    color: AppColor.cBorder,
                    strokeWidth: 1.5,
                    radius: Radius.circular(10),
                    borderType: BorderType.RRect,
                    dashPattern: [3, 5],
                    strokeCap: StrokeCap.round,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: replayController.imagePathList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = replayController.imagePathList[index];
                            return imageDataWidget(
                              title: data.path.toString().split('/').last,
                              delete: () {
                                replayController.imagePathList.removeAt(index);
                                replayController.imagePathList.refresh();
                              },
                            );
                          },
                        ),
                        verticalSpace(16),
                        CommonIconButton(
                          title: 'Choose file here',
                          iconData: DefaultImages.whiteUploadIcn,
                          onPressed: () {
                            replayController.pickImage();
                          },
                        ),
                      ],
                    ),
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
                          title: 'Create',
                          iconData: DefaultImages.whiteDoneIcn,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                                commonToast(AppConstant.demoString);
                              } else {
                                //api call
                                replayController.addReplay(
                                  ticketId: widget.ticketID,
                                  description: replayController.descriptionController.text.trim(),
                                  imageList: replayController.imagePathList,
                                );
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
}
