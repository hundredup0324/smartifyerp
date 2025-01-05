import 'dart:convert';

import 'package:get/get.dart';
import 'package:attendance/core/model/home_response_lead.dart';
import 'package:attendance/core/model/pipeline_response.dart';
import 'package:attendance/network_dio/network_dio_lead.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_lead.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../views/widgets/loading_widget.dart';

class LeadHomeController  extends GetxController {
  RxBool isLoading = false.obs;

  RxList<LatestLeads> latestLeads = <LatestLeads>[].obs;
  RxList<ChartData> chartList = <ChartData>[].obs;

  RxInt totalUsersCount = 0.obs;
  RxInt totalLeadsCount = 0.obs;
  late ZoomPanBehavior zoomPanBehavior;
  late SelectionBehavior selectionBehavior;

  RxString selectedPipelinesId = "".obs;
  RxString selectedPipeLine = "".obs;

  RxList<PipeLineData> pipeLineList = <PipeLineData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    zoomPanBehavior =
        ZoomPanBehavior(enablePanning: true, zoomMode: ZoomMode.xy);
    selectionBehavior =
        SelectionBehavior(enable: true, selectedColor: AppColor.darkGreen);
  }

  fetchData() async {
    isLoading(true);

    await getHomeScreenData();
    isLoading(false);
  }

  getHomeScreenData() async {
    // isLoading.value = true;
    print("selectedPipeLineId$selectedPipeLine");

    var response = await NetworkHttps.postRequest(APILEAD.home, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      selectedPipelinesId.value ==""?
      "":
      "pipeline_id": selectedPipelinesId.value
    });

    if (response['status'] == 1) {
      latestLeads.clear();
      pipeLineList.clear();
      var homeData = HomeResponse.fromJson(response);

      totalUsersCount.value = homeData.data!.totalUsers ?? 0;
      totalLeadsCount.value = homeData.data!.totalLeads ?? 0;
      latestLeads.addAll(homeData.data!.latestLeads!);
      pipeLineList.addAll(homeData.data!.pipeLineData!);
      // isLoading.value = false;
      if (Prefs.getString(AppConstant.pipeLineId) == null ||
          Prefs.getString(AppConstant.pipeLineId) == "") {
        selectedPipelinesId.value = pipeLineList.first.id.toString();
        selectedPipeLine.value = pipeLineList.first.name.toString();
        Prefs.setString(AppConstant.pipeLineId, selectedPipelinesId.toString());
        Prefs.setString(AppConstant.pipeLineName, selectedPipeLine.toString());

        print("selected pipeline ${selectedPipeLine.value}");
        print("selected PipelineId ${selectedPipelinesId.value}");
        // isLoading.value = false;
      } else {
        selectedPipelinesId.value = Prefs.getString(AppConstant.pipeLineId);
        selectedPipeLine.value = Prefs.getString(AppConstant.pipeLineName);
      }
      chartList.clear();
      chartList.addAll(homeData.data!.chartData!);
      chartList.refresh();
      // await getChartData();

      print("selected pipeline ${selectedPipeLine.value}");
      print("selected PipelineId ${selectedPipelinesId.value}");
    } else {
      commonToast(response['message']);
    }
  }


}
