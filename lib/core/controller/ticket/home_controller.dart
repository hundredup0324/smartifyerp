// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:attendance/config/repository/home_repository.dart';
import 'package:attendance/core/model/dashboard_response.dart';
import 'package:attendance/network_dio/network_dio_ticket.dart';
import 'package:attendance/utils/base_api_ticket.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:http/http.dart' as http;

class TicketHomeController extends GetxController {
  HomeRepository homeRepository = HomeRepository();
  HomeData? homeData;
  RxString openTicket = '0'.obs;
  RxString totalCategories = '0'.obs;
  RxString closeTickets = '0'.obs;

  RxList<YearWiseChart> yearWiseChart = <YearWiseChart>[].obs;
  RxList<ChartDatas> chartData = <ChartDatas>[].obs;

  getHomeApi() async {
    Loader.showLoader();
    var response = await NetworkHttps.getRequest(API.dashboard +
        API.workspaceId +
        Prefs.getString(AppConstant.workspaceId));
    if (response['status'] == 1) {
      yearWiseChart.clear();
      chartData.clear();
      var dashResponse = DashboardResponse.fromJson(response);
      homeData = dashResponse.data;
      var homeModelData = dashResponse.data!;
      openTicket.value = homeModelData.openTicket.toString();
      closeTickets.value = homeModelData.closeTicket.toString();
      totalCategories.value = homeModelData.totalCategories.toString();

      yearWiseChart.addAll(homeModelData.yearWiseChart!);
      chartData.addAll(homeModelData.chartDatas!);
      chartData.refresh();
      yearWiseChart.refresh();
    } else {
      commonToast(response["message"]);
    }
    Loader.hideLoader();
  }
}
