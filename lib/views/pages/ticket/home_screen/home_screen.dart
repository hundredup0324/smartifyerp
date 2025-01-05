// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/ticket/home_controller.dart';
import 'package:attendance/core/controller/ticket/tickets_controller.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'home_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/images.dart';
import 'package:attendance/utils/base_api_ticket.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TicketHomeController homeController = Get.put(TicketHomeController());

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getHomeApi();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
            child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppTitleRow(
                "Dashboard".tr,
                () {},
                dateFormatted(
                  date: DateTime.now().toString(),
                  formatType: formatForDateTime(FormatType.date),
                ),
              ),
              verticalSpace(26),
              support_ticketTitleWidget(
                  title: "Ticket System".tr, subTitle: API.baseUrl),
              verticalSpace(13),
              profileDataWidget(
                profileUrl: Prefs.getString(AppConstant.profileImage) ??
                    DefaultImages.profileImage,
                userName: Prefs.getString(AppConstant.userName),
                email: Prefs.getString(AppConstant.emailId),
                totalTicket: homeController.openTicket.value.toString(),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  "Statistics".tr,
                  style: pRegular20,
                ),
              ),
              Row(
                children: [
                  statisticsWidget(
                    color: AppColor.cBackGround,
                    icnColor: AppColor.cGreenFont,
                    icon: DefaultImages.categoryIcn,
                    title: 'Total'.tr,
                    subTitle: 'Categories'.tr,
                    total: homeController.totalCategories.value.toString(),
                  ),
                  horizontalSpace(16),
                  statisticsWidget(
                    color: AppColor.themeGreenColor,
                    icnColor: AppColor.cWhite,
                    icon: DefaultImages.categoryIcn,
                    title: 'Open'.tr,
                    subTitle: 'Tickets'.tr,
                    total: homeController.openTicket.value.toString(),
                  ),
                ],
              ),
              verticalSpace(16),
              Row(
                children: [
                  statisticsWidget(
                    color: AppColor.cRed,
                    icnColor: AppColor.cWhite,
                    icon: DefaultImages.categoryIcn,
                    title: 'Close'.tr,
                    subTitle: 'Tickets'.tr,
                    total: homeController.closeTickets.value.toString(),
                  ),
                  horizontalSpace(16),
                  Expanded(child: SizedBox())
                ],
              ),
              verticalSpace(25),
              Text(
                "This Year Tickets",
                style: pRegular20,
              ),
              verticalSpace(20),
              AnalyticsGraph(),
              verticalSpace(20),
              Text(
                "Categories",
                style: pRegular20,
              ),
              verticalSpace(15),
              CategoriesGraph(
              ),
              verticalSpace(20),
            ],
          ),
        )),
      ),
    );
  }

  Widget statisticsWidget({
    Color? color,
    Color? icnColor,
    String? icon,
    String? title,
    String? subTitle,
    String? total,
    String? increment,
  }) {
    return Expanded(
      child: Card(
        color: AppColor.cBackGround,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        margin: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: AppColor.cBorder,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: Row(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: AppColor.cBorder,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: FittedBox(
                  child: Column(
                    children: [
                      assetSvdImageWidget(
                        image: icon,
                        height: 21,
                        width: 21,
                        colorFilter: ColorFilter.mode(
                          icnColor ?? AppColor.cGreenFont,
                          BlendMode.srcIn,
                        ),
                      ),
                      verticalSpace(5),
                      Text(
                        title!,
                        style: pSemiBold8.copyWith(
                            color: icnColor ?? AppColor.cGreenFont),
                      ),
                      FittedBox(
                        child: Text(
                          subTitle!,
                          style: pSemiBold10,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Text(
                  total!,
                  style: pBold30,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
