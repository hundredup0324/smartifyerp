import 'dart:convert';

import 'package:attendance/core/model/holiday_list_response.dart';
import 'package:attendance/network_dio/network_dio.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HolidayListController extends GetxController {
  RxList<HolidayData> holidayList = <HolidayData>[].obs;
  RxBool isLoading=false.obs;

  @override
  void onInit() {
    super.onInit();
    // holidayList.value.clear();
    WidgetsBinding.instance.addObserver(AppLifecycleListener());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(AppLifecycleListener());
    super.dispose();
  }

  getHolidayList(String workspaceId) async {
    isLoading.value =true;
    var response = await NetworkHttps.postRequest(API.holidayList,{"workspace_id": workspaceId});
    if (response['status'] == 1) {
      isLoading.value =false;

      Loader.hideLoader();
      holidayList.clear();
      var holidayListData=HolidayListResponse.fromJson(response);
      holidayList.value.addAll(holidayListData.data!);
    } else {
      isLoading.value =false;

      Loader.hideLoader();
      commonToast(response["message"]);
      }
  }
}
