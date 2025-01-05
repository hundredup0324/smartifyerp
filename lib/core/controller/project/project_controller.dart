import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:attendance/core/model/GetUserListResponse.dart';
import 'package:attendance/core/model/project_list_response.dart';
import 'package:attendance/network_dio/network_dio_project.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_pro.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/loading_widget.dart';

class ProjectController extends GetxController {
  RxList<String> categoriesList = ["All", "Ongoing", "OnHold", "Finished"].obs;
  RxInt selectedIndex = 0.obs;
  RxInt currantPage = 1.obs;
  RxBool isScroll = true.obs;
  RxList<Projects> projectList = <Projects>[].obs;
  RxList<String> userEmailList = <String>[].obs;
  final MultiSelectController userController = MultiSelectController();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxList<ValueItem> valueItemList = <ValueItem>[].obs;

  RxList<UserData> userDataList = <UserData>[].obs;

  RxString selectUserID = "".obs;



  @override
  void onInit() {
    nameController.clear();
    descriptionController.clear();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.clear();
    descriptionController.clear();
    super.dispose();
  }

  changeTab(String title, int index) {
    selectedIndex.value = index;
    if (!Prefs.getBool(AppConstant.isDemoMode)) {
      getProjectList(title);
    }
    print("selectedindex ${selectedIndex.value}");
    categoriesList.refresh();
  }

  getProjectList(String type) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(API.projectList, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "type": type,
    });

    if (response["status"] == 1) {
      projectList.clear();
      var projectResponse = ProjectListResponse.fromJson(response);
      projectList.addAll(projectResponse.data!.projects!);
      projectList.refresh();
      Loader.hideLoader();
    } else {
      commonToast(response['message']);
      Loader.hideLoader();
    }
  }

  getworkspaceUsers() async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(API.getworkspaceUser,
        {"workspace_id": Prefs.getString(AppConstant.workspaceId)});
    if (response["status"] == 1) {
      userDataList.clear();
      var userResponse = GetUserListResponse.fromJson(response);
      userDataList.addAll(userResponse.data!);
      valueItemList.value = userDataList.map((element) {
        return ValueItem(label: element.email ?? "", value: element.email);
      }).toList();
    } else {
      commonToast(response['message']);
    }
    Get.back();
  }

  createProject() async {
    Loader.showLoader();
    var response =
        await NetworkHttps.postRequest(API.create_and_update_project, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "name": nameController.text,
      "description": descriptionController.text,
      "users_list": userEmailList,
    });
    if (response["status"] == 1) {
      nameController.clear();
      descriptionController.clear();
      userEmailList.clear();
      getProjectList(categoriesList[selectedIndex.value]);
    } else {
      commonToast(response['message']);
    }
    Get.back();
  }

  deleteProject(String projectId) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(API.deleteProject, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "project_id": projectId
    });

    if (response["status"] == 1) {
      Get.back();

      getProjectList(categoriesList[selectedIndex.value]);
      commonToast(response['message']);
    } else {
      commonToast(response['message']);
      Get.back();
    }
    Get.back();
  }
}
