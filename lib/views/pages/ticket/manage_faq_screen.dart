// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/ticket/faq_controller.dart';
import 'package:attendance/core/model/faq_model.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/images.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/widgets/common_button.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_appbar_widget.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

class ManageFaqScreen extends StatefulWidget {
  const ManageFaqScreen({super.key});

  @override
  State<ManageFaqScreen> createState() => _ManageFaqScreenState();
}

class _ManageFaqScreenState extends State<ManageFaqScreen> {
  FaqController faqController = Get.put(FaqController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    faqController.faqList.clear();
    faqController.currantPage.value = 1;
    faqController.isScroll.value = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      faqController.getFaqData(
          perPage: faqController.perPage.value,
          page: faqController.currantPage.value);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "FAQ",
                      style: pSemiBold21,
                    ),
                  ],
                ),
                verticalSpace(14),
                faqController.faqList.isEmpty
                    ? Expanded(
                        child: Center(
                        child: Text(
                          "Data not found",
                          style: pRegular16.copyWith(
                              color: AppColor.cText),
                        ),
                      ))
                    : Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: faqController.faqList.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            FaqModelData faq = faqController.faqList[index];
                            return Column(

                              children: [
                                horizontalDivider(),
                                ExpansionTile(
                                  backgroundColor: AppColor.cBackGround,
                                  title: ListTile(

                                    title: Text(
                                      faq.title.toString().tr,
                                      style: pSemiBold16,
                                    ),

                                  ),

                                  childrenPadding: EdgeInsets.symmetric(
                                      horizontal: 16,),
                                  tilePadding: EdgeInsets.zero,
                                  iconColor: AppColor.cText,
                                  collapsedIconColor: AppColor.cText,
                                  shape: InputBorder.none,
                                  collapsedShape: InputBorder.none,
                                  children: [
                                    Text(
                                      faq.description.toString().tr,
                                      style: pRegular16,
                                    ),
                                  ],
                                ),
                                horizontalDivider(),

                              ],
                            );
                          },
                        ),
                      ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
