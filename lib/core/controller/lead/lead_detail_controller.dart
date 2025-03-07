import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:attendance/core/model/lead_detail_response.dart';
import 'package:attendance/network_dio/network_dio_lead.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_lead.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';

class LeadDetailController extends GetxController {

  RxString pipeLineId="".obs;
  RxBool isRunningTask=false.obs;
  RxBool isLoading=false.obs;

  RxString email="".obs;
  RxString followUpDate="".obs;
  RxString pipeLine="".obs;
  RxString phone="".obs;
  RxString createdAt="".obs;
  RxString percentage="".obs;
  RxString stageName="".obs;



  RxList<LeadActivity> leadActivity=<LeadActivity>[].obs;
  RxList<TasksList> taskList=<TasksList>[].obs;



  getLeadDetail(String pipeLineId,String leadId) async {
    isLoading.value = true;
    var response = await NetworkHttps.postRequest(APILEAD.leadDetails, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "pipeline_id": pipeLineId,
      "lead_id": leadId,
    });

    if (response["status"] == 1) {
      taskList.clear();
      leadActivity.clear();
      var leadResponse = LeadDetailResponse.fromJson(response);

      followUpDate.value=leadResponse.data?.followUpDate.toString()??"";
      email.value=leadResponse.data?.email.toString()??"";
      pipeLine.value=leadResponse.data?.pipelineName.toString()??"";
      stageName.value=leadResponse.data?.stageName.toString()??"";
      percentage.value=leadResponse.data?.percentage.toString()??"";
      createdAt.value=leadResponse.data?.created_at.toString()??"";
      phone.value=leadResponse.data?.phone.toString()??"";

      leadActivity.addAll(leadResponse.data!.leadActivity!);
      taskList.addAll(leadResponse.data!.tasksList!);
      isLoading.value = false;
    } else {
      commonToast(response['message']);
      isLoading.value = false;
    }
  }
  getFollowUpDate()
  {
    var yyyyMMddFormat= DateFormat("yyyy-MM-dd");
    var date=yyyyMMddFormat.parse(followUpDate.value);
    var ddMMyyyy= DateFormat("dd-MM-yyyy");
    return ddMMyyyy.format(date);

  }

  double convertToZeroToOne(String? value) {
    // Ensure that the value is within the range of 0 to 100

    var originalValue=value!.replaceAll("%", "").trim();

    var percentage = int.parse(originalValue).clamp(0, 100);

    // Convert the value to the range of 0 to 1
    double result = percentage / 100.0;

    return result;
  }


}