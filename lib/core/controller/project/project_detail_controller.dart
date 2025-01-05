import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:attendance/core/model/project_detail_response.dart';
import 'package:attendance/network_dio/network_dio_project.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_pro.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/loading_widget.dart';

class ProjectDetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxString responseData = ''.obs;
  ProjectDetailData? projectData;
  RxList<Milestones> mileStoneList = <Milestones>[].obs;
  RxList<ValueItem> valueItemList = <ValueItem>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var staticStatusList = <String>["Ongoing", "OnHold", "Finished"];
  RxString projectStatus = "".obs;

  RxList<String> userList = [
    "tom@gmail.com",
    "Alex@yopmail.com",
    "Phillip@yopmail.com",
    "Gary@yopmail.com",
    "sam@example.com"
  ].obs;
  RxString selectedUserValue = "".obs;
  RxString projectId = "".obs;

  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;










  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: startDate.value,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate.value) {
      startDate.value = picked;
      endDate.value = picked;
    }
    print("startDate ${startDate.value}");
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: startDate.value,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate.value) {
      endDate.value = picked;
    }
    print("endDate ${endDate.value}");
  }

  String getFormattedDate(DateTime now) {
    final formatter = DateFormat('dd/MM/yyyy');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }

  String getParameterFormattedDate(DateTime now) {
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }

  getProjectDetails(String projectId) async {
    isLoading.value = true;
    var response = await NetworkHttps.postRequest(API.projectDetails, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "project_id": projectId
    });

    if (response["status"] == 1) {
      var projectResponse = ProjectDetailResponse.fromJson(response);
      projectData = projectResponse.data;

      projectStatus.value = projectData!.status ?? "";
      nameController.text = projectData!.name ?? "";
      budgetController.text = projectData!.budget ?? "";
      descriptionController.text = projectData!.description ?? "";
      startDate.value = DateTime.parse(projectData!.startDate ?? "");
      endDate.value = DateTime.parse(projectData!.endDate ?? "");

      valueItemList.value = projectData!.members!.map((element) {
        return ValueItem(label: element.email ?? "", value: element.id);
      }).toList();

      mileStoneList.value.addAll(projectData!.milestones!);
      print("projectData ${jsonEncode(projectData)}");
      isLoading.value = false;
      this.projectId.value = projectId;
    } else {
      commonToast(response['message']);
      isLoading.value = false;
    }
  }

  updateProject() async {
    Loader.showLoader();
    var response =
        await NetworkHttps.postRequest(API.create_and_update_project, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "project_id": projectId.value,
      "budget": budgetController.text,
      "name": nameController.text,
      "status": projectStatus.value,
      "description": descriptionController.text,
      "users_list": selectedUserValue.value,
      "start_date": getParameterFormattedDate(startDate.value),
      "end_date": getParameterFormattedDate(endDate.value),
    });
    if (response["status"] == 1) {
      commonToast(response['message']);
      getProjectDetails(projectId.value);
    } else {
      commonToast(response['message']);
    }
    Get.back();
  }





}
