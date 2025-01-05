import 'package:attendance/core/controller/attendence/leave_request_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/attendence/leave_request.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({super.key});

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  final LeaveRequestController leavesController =
      Get.put(LeaveRequestController());

  @override
  void initState() {
    leavesController.leaveTypes.clear();
    leavesController.myLeavesHistory.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      leavesController.getMyLeaves();
      leavesController.getLeaveTypes();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackGround,
      appBar: AppBar(
        backgroundColor: AppColor.cWhite,

        surfaceTintColor: Colors.transparent,
        title: Text(
          "My Leaves",
            style: pMedium24,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
          Get.to(() => LeaveRequestScreen())?.then((value) {
            if (value == true) {
              leavesController.myLeavesHistory.clear();
              leavesController.getMyLeaves();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Obx(() {
          return leavesController.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : leavesController.myLeavesHistory.isEmpty
                  ? Center(
                      child: Text("Data Not Found",
                          style: pMedium16.copyWith(color: AppColor.cBlack)))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        var leaveData = leavesController.myLeavesHistory[index];

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColor.cWhite),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(leaveData.leaveReason.toString(),
                                          style: pRegular16.copyWith(color: AppColor.cLabel),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,),
                                      verticalSpace(5),
                                      Text(
                                          "${formattedDate(leaveData.startDate ?? "")} - ${formattedDate(leaveData.endDate ?? "")}",
                                          style: pMedium14.copyWith(
                                              color: AppColor.cLabel)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: getStatus(leaveData.status ?? "")
                                  ),
                                  child: Text(
                                    leaveData.status ?? "",
                                    style: pMedium14.copyWith(
                                        color: AppColor.cWhite),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: leavesController.myLeavesHistory.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16));
        }),
      ),
    );
  }

  String formattedDate(String leaveDate) {
    return dateFormatted(
        date: leaveDate, formatType: formatForDateTime(FormatType.ddMMyyyy));
  }

  Color getStatus(String status) {
    if (status == "Pending") {
      return AppColor.pending;
    } else if (status == "Reject") {
      return AppColor.reject;
    } else if (status == "Approved") {
      return AppColor.approved;
    } else {
      return AppColor.approved;
    }
  }
}
