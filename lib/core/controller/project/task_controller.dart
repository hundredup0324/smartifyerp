import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:attendance/core/controller/project/project_detail_controller.dart';
import 'package:attendance/core/model/tasklist_response.dart';
import 'package:attendance/network_dio/network_dio_project.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_pro.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/loading_widget.dart';

class TaskController extends GetxController {
  RxList<String> categoriesList = ["Todo", "InProgress", "Review", "Done"].obs;
  RxInt selectedIndex = 0.obs;
  final MultiSelectController controller = MultiSelectController();

  RxBool isLoading = false.obs;
  RxList<String> userIdList = <String>[].obs;


  RxList<TaskListData> taskList = <TaskListData>[].obs;
  ProjectDetailController projectDetailController = Get.find();

  TextEditingController titleController = TextEditingController();

  RxList<String> priorityList = ["Low", "Medium", "High"].obs;

  RxString selectedMileStoneId = "0".obs;
  RxString selectedMileStone = "".obs;
  RxString selectedPriority = "Low".obs;

  RxString currentTaskStages = "".obs;
  RxInt selectedTaskStages = 0.obs;
  RxInt selectedTaskStagesId = 0.obs;

  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();

    selectedPriority.value = priorityList.first;
    if (projectDetailController.mileStoneList.isNotEmpty) {
      selectedMileStone.value = projectDetailController.mileStoneList.first.title ?? "";
      selectedMileStoneId.value = projectDetailController.mileStoneList.first.id.toString() ?? "";
    }
    getTaskList(projectDetailController.projectId.toString(), true);
  }

  changeTab(int index) {
    selectedIndex.value = index;
  }

  getTaskList(String projectId, bool loading) async {
    isLoading.value = loading;

    var response = await NetworkHttps.postRequest(API.taskBoard, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "project_id": projectId
    });

    if (response["status"] == 1) {
      taskList.clear();
      var taskResponse = TaskListResponse.fromJson(response);
      taskList.addAll(taskResponse.data!);
      taskList.refresh();
      isLoading.value = false;
    } else {
      commonToast(response['message']);
      isLoading.value = false;
    }

  }

  changeStages(String taskId, String newStatus) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(API.changeStages, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "new_status": newStatus,
      "task_id": taskId,
      "project_id": projectDetailController.projectId.value,
    });
    if (response["status"] == 1) {
      getTaskList(projectDetailController.projectId.value, false);
    } else {
      commonToast(response['message']);
    }
    Get.back();
  }

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

  createTask() async {
    Loader.showLoader();

    print("titleValue${titleController.text}");
    var response =
        await NetworkHttps.postRequest(API.task_create_update, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "project_id": projectDetailController.projectId.value,
      "start_date": getParameterFormattedDate(startDate.value),
      "due_date": getParameterFormattedDate(endDate.value),
      "priority": selectedPriority.value,
      "title": titleController.text,
      "assign_to": userIdList,
      "milestone_id": selectedMileStoneId.value
    });
    if (response["status"] == 1) {
      userIdList.clear();
      getTaskList(projectDetailController.projectId.value, false);
    } else {
      commonToast(response['message']);
    }
    Get.back();
  }

  updateTask(
    String taskId
  ) async {
    Loader.showLoader();
    var response =
        await NetworkHttps.postRequest(API.task_create_update, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "project_id": projectDetailController.projectId.value,
      "task_id": taskId,
      "start_date": getParameterFormattedDate(startDate.value),
      "due_date": getParameterFormattedDate(endDate.value),
      "priority": selectedPriority.value,
      "title": titleController.text,
      "assign_to": userIdList,
      "milestone_id": selectedMileStoneId.value
    });
    if (response["status"] == 1) {
      userIdList.clear();

      getTaskList(projectDetailController.projectId.value, false);
    } else {
      commonToast(response['message']);
    }
    Get.back();
  }

  deleteTask(String taskId) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(API.deleteTask, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "project_id": projectDetailController.projectId.value,
      "task_id": taskId,
    });
    if (response["status"] == 1) {
      getTaskList(projectDetailController.projectId.value, false);
    } else {
      commonToast(response['message']);
    }

    Get.back();
  }
}
