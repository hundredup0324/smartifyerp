import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:attendance/core/model/home_response_project.dart';
import 'package:attendance/network_dio/network_dio_project.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_pro.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/loading_widget.dart';

class HomeControllers extends GetxController {

  RxString totalProject="".obs;
  RxString totalTask="".obs;
  RxString totalBug="".obs;
  RxString totalUser="".obs;

  RxInt onGoing=0.obs;
  RxInt finished=0.obs;
  RxInt onHold=0.obs;
  HomeResponse? homeData;
  RxList<Tasks> taskList=<Tasks>[].obs;

  RxBool isLoading =false.obs;

  getHomeScreenData() async {
    isLoading.value=true;
    var response = await NetworkHttps.postRequest(API.home,{"workspace_id": Prefs.getString(AppConstant.workspaceId)});
    print("=========$response");
    if (response != null) {
      if (response['status'] == 1) {
        homeData = HomeResponse.fromJson(response);
        taskList.addAll(homeData!.data!.tasks!);
        totalProject.value=homeData!.data!.totalProject.toString();
        totalBug.value=homeData!.data!.totalBugs.toString();
        totalUser.value=homeData!.data!.totalMembers.toString();
        totalTask.value=homeData!.data!.totalTask.toString();

        onHold.value=homeData!.data!.status!.onHold??0;
        finished.value=homeData!.data!.status!.finished??0;
        onGoing.value=homeData!.data!.status!.ongoing??0;

        taskList.refresh();
        isLoading.value=false;

      } else {
        commonToast(response['message']);
        isLoading.value=false;

      }
    }
  }

  String getFormattedDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(dateTime);
    return formattedDate;
  }




}
