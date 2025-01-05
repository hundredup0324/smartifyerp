import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:attendance/core/model/home_response_sales.dart';
import 'package:attendance/network_dio/network_dio_sales.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_sales.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesHomeController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<LineChartData> chartList = <LineChartData>[].obs;
  RxList<String> categories = <String>[].obs;
  RxList<int> salesOrderAmount = <int>[].obs;
  RxList<int> invoice = <int>[].obs;

  RxInt totalUsersCount = 0.obs;
  RxInt totalLeadsCount = 0.obs;
  late ZoomPanBehavior zoomPanBehavior;

  var homeData = HomeData().obs;

  @override
  void onInit() {
    super.onInit();
    zoomPanBehavior = ZoomPanBehavior(enablePanning: true);

    if (Prefs.getString(AppConstant.isDemoMode) == true) {
      categories.value = [
        "19-jul",
        "20-jul",
        "21-jul",
        "22-Jul",
        "23-Jul",
        "24-Jul",
        "25-Jul"
      ];
      salesOrderAmount.value = [20, 40, 60, 80, 50, 10, 25];
      salesOrderAmount.value = [20, 40, 60, 80, 50, 10, 25];

      chartList.value = [
        LineChartData(
          day: "2024-05-20",
          invoiceAmount: "5.00",
          quoteAmount: "10.00",
          salesorderAmount: "2.00",
        ),
        LineChartData(
          day: "2024-05-19",
          invoiceAmount: "20.00",
          quoteAmount: "10.00",
          salesorderAmount: "10.00",
        ),
        LineChartData(
          day: "2024-05-18",
          invoiceAmount: "50.00",
          quoteAmount: "15.00",
          salesorderAmount: "10.00",
        ),
        LineChartData(
          day: "2024-05-17",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-16",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-15",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-14",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-13",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-12",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-11",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-10",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-09",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-08",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-07",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
        LineChartData(
          day: "2024-05-06",
          invoiceAmount: "0.00",
          quoteAmount: "0.00",
          salesorderAmount: "0.00",
        ),
      ];
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  getHomeScreenData() async {
    isLoading.value = true;
    var response = await NetworkHttps.getRequest(
        "${API.home}?workspace_id=${Prefs.getString(AppConstant.workspaceId)}");
    print("=========$response");
    if (response['status'] == 1) {
      chartList.clear();
      var responseData = HomeResponse.fromJson(response);

      homeData.value = responseData.data!;
      chartList.addAll(responseData.data!.lineChartData!);

      isLoading.value = false;
    } else {
      commonToast(response['message']);
      isLoading.value = false;
    }
  }
}
