import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:attendance/core/model/get_userlist_response.dart';
import 'package:attendance/core/model/lead_board.dart';
import 'package:attendance/core/model/pipeline_response.dart';
import 'package:attendance/network_dio/network_dio_lead.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_lead.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class LeadController extends GetxController {
  RxList<LeadData> leadBoardList = <LeadData>[].obs;

  RxList<Stages> stageList = <Stages>[].obs;
  RxInt selectedIndex = 0.obs;

  RxString currentTaskStages = "".obs;
  var assignUser = UserData().obs;
  RxString assignUserIdValue = "".obs;

  RxInt selectedTaskStages = 0.obs;
  RxInt selectedTaskStagesId = 0.obs;


  TextEditingController subjectController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxList<String> userIdList = <String>[].obs;
  RxList<UserData> userDataList = <UserData>[].obs;


  RxBool isLoading = false.obs;
  RxBool isCompany = false.obs;

  final followUpDate = DateTime.now().obs;


  @override
  void onInit() {
    super.onInit();
    if (Prefs.getString(AppConstant.userType) == "company") {
      isCompany(true);
    }else
      {
        isCompany(false);
      }
  }

  changeTab(int index) {
    selectedIndex.value = index;
    print("lead Count ${leadBoardList[selectedIndex.value].leads?.length}");
  }

  changeStages(String leadId, String newStatus) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(APILEAD.changeStages, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "new_status": newStatus,
      "lead_id": leadId,
      "pipeline_id": Prefs.getString(AppConstant.pipeLineId),
    });
    if (response["status"] == 1) {
      getLeadList(false);
    } else {
      commonToast(response['message']);
    }
    Get.back();
  }

  getworkspaceUsers() async {
    var response = await NetworkHttps.postRequest(APILEAD.getworkspaceUser,
        {"workspace_id": Prefs.getString(AppConstant.workspaceId)});
    if (response["status"] == 1) {
      userDataList.clear();
      var userResponse = GetUserListResponse.fromJson(response);
      userDataList.addAll(userResponse.data!);

      assignUser.value = userDataList.isNotEmpty?  userDataList.first:UserData();
      assignUserIdValue.value = userDataList.isNotEmpty?  userDataList.first.id.toString():"0";



    } else {
      commonToast(response['message']);
    }
  }

  getFollowUpDate(String? followUpDate) {
    var yyyyMMddFormat = DateFormat("yyyy-MM-dd");
    var date = yyyyMMddFormat.parse(followUpDate.toString());
    var ddMMyyyy = DateFormat("dd-MM-yyyy");
    return ddMMyyyy.format(date);
  }

  getLeadList(bool loading) async {
    isLoading.value = loading;
    var response = await NetworkHttps.postRequest(APILEAD.leadBoard, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "pipeline_id": Prefs.getString(AppConstant.pipeLineId)
    });

    if (response["status"] == 1) {
      leadBoardList.clear();
      var leadResponse = LeadBoardResponse.fromJson(response);
      leadBoardList.addAll(leadResponse.data!);
      isLoading.value = false;
    } else {
      commonToast(response['message']);
      isLoading.value = false;
    }
  }

  String getFormattedDate(DateTime now) {
    final formatter = DateFormat('dd/MM/yyyy');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: followUpDate.value,
      firstDate: followUpDate.value,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != followUpDate.value) {
      followUpDate.value = picked;
    }
    print("startDate ${followUpDate.value}");
  }

  String getParameterFormattedDate(DateTime now) {
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }

  Future<bool> createLead() async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(APILEAD.create_and_update_lead, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "pipeline_id": Prefs.getString(AppConstant.pipeLineId),
      "name": nameController.text,
      "subject": subjectController.text,
      "phone": phoneController.text,
      "user": assignUserIdValue.value,
      "email": emailController.text,
      "follow_up_date": getParameterFormattedDate(followUpDate.value),
    });
    if (response["status"] == 1) {
      commonToast(response['message']);

      Get.back();
      return true;
    } else {
      commonToast(response['message']);
      Get.back();
      return false;
    }
  }

  Future<bool> updateLead(String leadId) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(APILEAD.create_and_update_lead, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "pipeline_id": Prefs.getString(AppConstant.pipeLineId),
      "name": nameController.text,
      "subject": subjectController.text,
      "phone": phoneController.text,
      "user": assignUserIdValue.value,
      "email": emailController.text,
      "lead_id": leadId,
      "follow_up_date": getParameterFormattedDate(followUpDate.value),
    });
    if (response["status"] == 1) {
      commonToast(response['message']);

      Get.back();
      return true;
    } else {
      commonToast(response['message']);
      Get.back();
      return false;
    }
  }

  deleteLead(String leadId) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(APILEAD.deleteLead, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "pipeline_id": Prefs.getString(AppConstant.pipeLineId),
      "lead_id": leadId,
    });
    if (response["status"] == 1) {
      getLeadList(true);
      // getTaskList(projectDetailController.projectId.value, false);
    } else {
      commonToast(response['message']);
    }

    Get.back();
  }
}
