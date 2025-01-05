// ignore_for_file: prefer_const_constructors

import 'package:attendance/core/controller/attendence/home_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.announcementList.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.homeApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackGround,

      appBar: AppBar(
        backgroundColor: AppColor.cWhite,
        surfaceTintColor: Colors.transparent,
        title: Text("Dashboard", style: pMedium24,),
        centerTitle: true,
      ),
      body: Obx(() {
        final currentTime = homeController.currentTime.value;

        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 16,right: 16, top: 50,bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}',
                    style: TextStyle(
                        fontSize: 36,
                        color: AppColor.darkGreenColor,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    homeController.getFormattedDate(DateTime.now()),
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColor.textColor,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(10),
                  GestureDetector(
                    onTap: () {
                      if (homeController.isCheckIn.value == false) {
                        homeController.isCheckInApi("clockin");
                        Prefs.setBool(Prefs.IS_CHECK_IN, true);
                      } else {
                        Prefs.setBool(Prefs.IS_CHECK_IN, false);
                        homeController.isCheckInApi("clockout");
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: homeController.isCheckIn.isTrue
                          ? AppColor.redColor.withOpacity(0.2)
                          : AppColor.primaryColor.withOpacity(0.2),
                      radius: 90,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: homeController.isCheckIn.isTrue
                            ? AppColor.cRed.withOpacity(1)
                            : AppColor.darkGreenColor.withOpacity(1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            assetSvdImageWidget(
                                image: "asset/image/svg_image/ic_clock_in.svg",
                                height: 36,
                                width: 36),
                            verticalSpace(8),
                            Text(
                              homeController.isCheckIn.isTrue
                                  ? "Check Out".tr
                                  : "Check In".tr,
                              style: TextStyle(
                                  color: AppColor.cWhite, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      timeNote(ImagePath.check_in,
                          homeController.checkInTime.value, "Check In"),
                      timeNote(ImagePath.check_out,
                          homeController.checkOutTime.value, "Check Out"),
                      timeNote(ImagePath.total_hrs,
                          homeController.totalHours.value, "Total Hrs"),
                    ],
                  ),
                  verticalSpace(30),
                  Visibility(
                    visible: homeController.isViewVisible.value,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Announcement's",
                              style: pMedium18.copyWith(
                                  color: AppColor.cBlack, fontSize: 24))),
                    ),
                  ),
                  Visibility(
                    visible: homeController.isViewVisible.value,

                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = homeController.announcementList[index];
                        return Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            height: 110,
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColor.cWhite),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  data.title.toString(),
                                  style: pBold16.copyWith(color: AppColor.cBlack),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                                verticalSpace(3),
                                Text(
                                    "Date : ${homeController.eventDate(data.startDate)} To ${homeController.eventDate(data.endDate)}",
                                    style: pMedium14.copyWith(
                                        color: AppColor.cBlack),
                                    textAlign: TextAlign.center),
                                verticalSpace(3),
                                Text(data.description.toString(),
                                    style: pRegular14.copyWith(
                                        color: AppColor.cBlack),
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.start)
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: homeController.announcementList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget timeNote(String icon, String time, String titleText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        assetSvdImageWidget(image: icon),
        verticalSpace(5),
        Text(time, style: pMedium16),
        verticalSpace(5),
        Text(titleText, style: pRegular14),
      ],
    );
  }
}
