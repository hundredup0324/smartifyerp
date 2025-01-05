import 'package:attendance/core/controller/attendence/attendence_history_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:get/get.dart';

class AttendanceHistory extends StatefulWidget {

  AttendanceHistory({super.key});

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  ScrollController scrollController = ScrollController();

  final AttendanceHistoryController historyController = Get.put(AttendanceHistoryController());

  @override
  void initState() {
    super.initState();
    historyController.attendanceHistoryList.clear();
   historyController.attendanceHistory(historyController.currentMonth.value.toString(),historyController.currentYear.toString());
  }

  @override
  Widget build(BuildContext context) {
    String languageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == '' ? 'en' : Prefs.getString(AppConstant.LANGUAGE_CODE);


    return Scaffold(
      backgroundColor: AppColor.appBackGround,
      appBar: AppBar(
        backgroundColor: AppColor.cWhite,
        surfaceTintColor: Colors.transparent,
        title:  Text("Attendance History", style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColor.cLabel,
          fontFamily: 'Outfit',
        )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              verticalSpace(20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColor.cWhite,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(child: assetSvdImageWidget(image:languageCode == 'ar'?ImagePath.ic_next :ImagePath.ic_prev),onTap: (){
                            historyController.navigateToPreviousMonth();
                      },),
                      Expanded(
                        child: Center(
                          child: Text(
                            historyController.selectedDateText.value,
                              style: pSemiBold16.copyWith(color: AppColor.cBlack),
                          ),
                        ),
                      ),
                      InkWell(child:assetSvdImageWidget(image: languageCode == 'ar'?ImagePath.ic_prev :ImagePath.ic_next), onTap: () {
                        historyController.navigateToNextMonth();
                      }),
                    ],
                  ),
                ),
              ),
              verticalSpace(20),
              Expanded(
                child: historyController.isLoading.value==true ?  Center(child: CircularProgressIndicator()):

                historyController.attendanceHistoryList.value.isEmpty ?Center(child: Text("Data Not Found",style: pMedium16.copyWith(color: AppColor.cBlack))):

                ListView.builder(
                    shrinkWrap: true,
                    itemCount: historyController.attendanceHistoryList.value.length,
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    clipBehavior: Clip.hardEdge,
                    itemBuilder: (context, index) {
                      var attendanceData = historyController.attendanceHistoryList[index];
                      var historyList=attendanceData.history??[];

                      return ClipRect(
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColor.cWhite),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topRight:Radius.circular(12),topLeft: Radius.circular(12)),
                                    color: Color(0xFF55469b),
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(child: Text("Date: ${historyController.getFormattedDate(attendanceData.date.toString())}",style: pSemiBold14.copyWith(color: AppColor.cWhite),)),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text("Total Hours : ${attendanceData.totalTime.toString()}",style: pSemiBold14.copyWith(color: AppColor.cWhite)),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: historyList.length,
                                    scrollDirection: Axis.vertical,
                                    clipBehavior: Clip.hardEdge,
                                    itemBuilder: (context,index){

                                      var historyData=historyList[index];
                                      return   Padding(
                                        padding: const EdgeInsets.only(top: 8,left: 16,right: 16,bottom: 8),
                                        child: Column(

                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                timeWidget(ImagePath.check_in,
                                                    historyData.clockIn ?? "", "Check In"),
                                                const VerticalDivider(),
                                                timeWidget(ImagePath.check_out,
                                                    historyData.clockOut ?? "", "Check Out"),
                                                const VerticalDivider(),
                                                timeWidget(ImagePath.total_hrs,
                                                    historyData.total ?? "", "Total Hrs"),
                                              ],
                                            ),
                                            const Divider()
                                          ],

                                        ),
                                      );
                                    })
                              ],
                            )
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget timeWidget(String icon, String time, String titleText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        assetSvdImageWidget(image: icon, width: 16, height: 16),
        verticalSpace(5),
        Text(time, style: pMedium14),
        Text(titleText, style: pRegular14),
      ],
    );
  }
}
