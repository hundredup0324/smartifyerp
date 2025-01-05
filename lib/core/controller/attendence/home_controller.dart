import 'dart:async';

import 'package:attendance/core/model/clock_in_response.dart';
import 'package:attendance/core/controller/lead/setting_controller.dart';
import 'package:attendance/network_dio/network_dio.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:attendance/core/model/home_response.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxBool isCheckIn = false.obs;
  RxString checkInTime = "00:00".obs;
  RxString checkOutTime = "00:00".obs;
  RxString totalHours = "00:00".obs;
  RxString attendanceId = "".obs;

  RxBool isLoading = false.obs;
  RxBool isViewVisible = false.obs;

  var currentTime = DateTime.now().obs;
  late Timer _timer;

  RxList<Announcements> announcementList = <Announcements>[].obs;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    WidgetsBinding.instance.addObserver(AppLifecycleListener());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(AppLifecycleListener());
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        currentTime.value = DateTime.now();
      },
    );
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  isCheckInApi(String type) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(API.isClockIn, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "type": type,
      "attendence_id": attendanceId.value
    });
    if (response['status'] == 1) {
      Loader.hideLoader();
      var attendanceReport = ClockInResponse.fromJson(response);
      Prefs.setString(
          Prefs.Attendance_Id, attendanceReport.data!.attendenceId.toString());
      checkInTime.value = attendanceReport.data!.clockIn ?? "--";
      checkOutTime.value = attendanceReport.data!.clockOut ?? "--";
      totalHours.value = attendanceReport.data!.totalHours ?? "--";
      attendanceId.value = attendanceReport.data!.attendenceId.toString();
      isCheckIn.value = !isCheckIn.value;
    } else {
      Loader.hideLoader();
      commonToast(response["message"]);
    }
  }

  String getFormattedDate(DateTime now) {
    final formatter = DateFormat('MMM dd yyyy EEEE');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }

  String eventDate(String? date) {
    final formatter = DateFormat('dd/MMM/yyyy');
    final formattedDate = formatter.format(DateTime.parse(date ?? ""));
    return formattedDate;
  }

  homeApi() async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(
        API.home, {"workspace_id": Prefs.getString(AppConstant.workspaceId)});
    if (response["status"] == 1) {
      Loader.hideLoader();
      isLoading.value = false;

      var homeResponseData = HomeResponse.fromJson(response);
      checkInTime.value = homeResponseData.data!.clockIn ?? "--";
      checkOutTime.value = homeResponseData.data!.clockOut ?? "--";
      totalHours.value = homeResponseData.data!.totalHours ?? "--";
      attendanceId.value = homeResponseData.data!.attendanceId.toString();
      announcementList.addAll(homeResponseData.data!.announcements!);
      isViewVisible.value = announcementList.isEmpty ? false : true;

      if (homeResponseData.data?.isClockin == 0) {
        isCheckIn = false.obs;
      } else {
        isCheckIn = true.obs;
      }
    } else {
      Loader.hideLoader();
      isLoading.value = false;
    }
  }
}
