import 'package:attendance/core/controller/attendence/holiday_list_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HolidayList extends StatefulWidget {
  HolidayList({super.key});

  @override
  State<HolidayList> createState() => _HolidayListState();
}

class _HolidayListState extends State<HolidayList> {
  ScrollController scrollController = ScrollController();

  final HolidayListController holidayController =
      Get.put(HolidayListController());

  @override
  void initState() {
    super.initState();

    holidayController.holidayList.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      holidayController.getHolidayList(Prefs.getString(AppConstant.workspaceId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Holidays".tr,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: AppColor.appBackGround,
      body: SafeArea(
        child: Obx(() {
          return holidayController.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : holidayController.holidayList.isEmpty
                  ? Center(
                      child: Text("Data Not Found",
                          style: pMedium16.copyWith(color: AppColor.cBlack)))
                  : ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: holidayController.holidayList.length,
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      itemBuilder: (context, index) {
                        var data = holidayController.holidayList[index];

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            height: 100,
                            decoration: BoxDecoration(
                                color: AppColor.cWhite,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.title.toString(),
                                  style: TextStyle(
                                    color: AppColor.cLabel,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    assetSvdImageWidget(
                                        image:
                                            "asset/image/svg_image/ic_calender.svg",
                                        width: 22,
                                        height: 22),
                                    horizontalSpace(8),
                                    Text(
                                      dateFormatted(
                                          date: data.start ?? "",
                                          formatType: formatForDateTime(
                                              FormatType.date)),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.cLabel),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          dateFormatted(
                                              date: data.start ?? "",
                                              formatType: formatForDateTime(
                                                  FormatType.day)),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.cLabel),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
        }),
      ),
    );
  }
}
