import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:attendance/core/model/meeting_list_response.dart';
import 'package:attendance/core/model/request_data_response.dart';
import 'package:attendance/network_dio/network_dio_sales.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_sales.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/core/model/meeting_request_data.dart';
import 'package:attendance/views/widgets/loading_widget.dart';

class MeetingController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt currantPage = 1.obs;
  RxBool isScroll = true.obs;
  RxList<MeetingData> meetingList = <MeetingData>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxList<String> statusList = ["Planned", "Held", "Not Held"].obs;
  RxString statusValue = "".obs;

  RxList<String> parentList = <String>[].obs;
  RxString selectedParentValue = "".obs;

  RxList caseList = [].obs;
  RxList opportunitiesList = [].obs;

  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;

  var parentUser = DropdownModel().obs;
  RxList parentUserList = [].obs;
  RxString selectedParentUserValue = "".obs;

  RxList assignUserList = [].obs;
  var assignedUser = DropdownModel().obs;
  RxString assignedUserValue = "".obs;

  RxList<DropdownModel> accountList = <DropdownModel>[].obs;
  var account = DropdownModel().obs;
  RxString selectedAccountValue = "".obs;

  RxList contactList = [].obs;
  var contact = DropdownModel().obs;
  RxString selectedAttendeesContact = "".obs;

  RxList attendeesUsersList = [].obs;
  var attendeesUser = DropdownModel().obs;
  RxString selectedAttendeesUsers = ''.obs;

  RxList attendeesLeadList = [].obs;
  var attendeesLead = DropdownModel().obs;
  RxString selectedAttendeesLead = "".obs;

  @override
  void onInit() {
    super.onInit();
    meetingList.clear();
  }

  getMeetingList(int? pageNO) async {
    if (pageNO == 1) {
      isLoading.value = true;
    } else {
      Loader.showLoader();
    }
    var response = await NetworkHttps.getRequest(
        "${API.meetingList}?workspace_id=${Prefs.getString(AppConstant.workspaceId)}}&page=$pageNO");

    if (response['status'] == 1) {
      isLoading.value = false;
      if(pageNO!>1)
      {
        Loader.hideLoader();

      }
      var responseData = MeetingListResponse.fromJson(response);
      meetingList.addAll(responseData.data!.data!);
      print("Current Page ${currantPage.value }");
      print("lastPage Page ${responseData.data!.lastPage}");
      if (currantPage.value == responseData.data!.lastPage) {
        isScroll.value = false;
      }
    } else {
      isLoading.value = false;
      if(pageNO!>1)
        {
          Loader.hideLoader();

        }

      commonToast(response['message']);
    }
  }

  deleteMeeting(String? meetingId) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(
        "${API.deleteMeetings}/$meetingId",
        {"workspace_id": Prefs.getString(AppConstant.workspaceId)});

    if (response['status'] == 1) {
      Loader.hideLoader();
      commonToast(response['message']);

      for (var data in meetingList) {
        if (data.id.toString() == meetingId) {
          meetingList.remove(data);
          meetingList.refresh();
          return;
        }
      }
    } else {
      Loader.hideLoader();

      commonToast(response['message']);
    }
  }

  updateSetDataIntoUi(MeetingData data) {
    nameController.text = data.name.toString();
    descriptionController.text = data.description.toString();

    if (data.account!.isEmpty) {
      account.value = accountList.first;
      selectedAccountValue.value = accountList.first.id.toString();
    } else {
      account.value = getSelectedModel(accountList, data.accountId ?? 0) ??
          accountList.first;
      selectedAccountValue.value =
          getUserId(assignUserList, data.accountId) ?? '';
    }

    assignedUser.value =
        getSelectedModel(assignUserList, data.assignUserId ?? 0) ??
            assignUserList.first;
    contact.value =
        getSelectedModel(contactList, data.attendeescontactId ?? 0) ??
            contactList.first;
    attendeesLead.value =
        getSelectedModel(attendeesLeadList, data.attendeesLeadId ?? 0) ??
            attendeesLeadList.first;
    attendeesUser.value =
        getSelectedModel(attendeesUsersList, data.attendeesUserId ?? 0) ??
            attendeesUsersList.first;

    DateFormat formatter = DateFormat("yyyy-MM-dd");

    startDate.value = formatter.parse(data.startDate.toString());
    endDate.value = formatter.parse(data.endDate.toString());

    selectedParentValue.value = data.parent.toString();

    assignedUserValue.value =
        getUserId(assignUserList, data.assignUserId) ?? '';
    selectedAttendeesContact.value =
        getUserId(contactList, data.attendeescontactId) ?? '';

    selectedAttendeesUsers.value =
        getUserId(attendeesUsersList, data.attendeesUserId) ?? '';

    selectedAttendeesLead.value =
        getUserId(attendeesLeadList, data.attendeesLeadId) ?? '';

    getParentUserList(data.parent.toString());

    for (var status in statusList) {
      if (status == data.status) {
        statusValue.value = status;
        return;
      }
    }
  }

  String? getUserId(List list, int? id) {
    if (id != null && id != 0) {
      return id.toString();
    } else {
      return list.first.id.toString();
    }
  }

  DropdownModel? getSelectedModel(List list, int id) {
    try {
      return list.singleWhere((element) => element.id == id);
    } catch (exception) {
      return list.first;
    }
  }

  clearData() {
    account.value =
        accountList.isNotEmpty ? accountList.first : DropdownModel();
    assignedUser.value =
        assignUserList.isNotEmpty ? assignUserList.first : DropdownModel();
    contact.value =
        contactList.isNotEmpty ? contactList.first : DropdownModel();
    attendeesLead.value = attendeesLeadList.isNotEmpty
        ? attendeesLeadList.first
        : DropdownModel();
    attendeesUser.value =
        assignUserList.isNotEmpty ? assignUserList.first : DropdownModel();
    statusValue.value = statusList.first;
    selectedParentValue.value = parentList.isNotEmpty ? parentList.first : "";

    selectedAccountValue.value =
        accountList.isNotEmpty ? accountList.first.id.toString() : "0";
    assignedUserValue.value =
        assignUserList.isNotEmpty ? assignUserList.first.id.toString() : "0";
    selectedAttendeesContact.value =
        contactList.isNotEmpty ? contactList.first.id.toString() : "0";
    selectedAttendeesUsers.value = attendeesUsersList.isNotEmpty
        ? attendeesUsersList.first.id.toString()
        : "0";
    selectedAttendeesLead.value = attendeesLeadList.isNotEmpty
        ? attendeesLeadList.first.id.toString()
        : "0";

    parentUser.value =
        parentUserList.isNotEmpty ? parentUserList.first : DropdownModel();
    selectedParentUserValue.value =
        parentUserList.isNotEmpty ? parentUserList.first.id.toString() : "0";

    startDate.value = DateTime.now();
    endDate.value = DateTime.now();
    nameController.clear();
    descriptionController.clear();
  }

  getMeetingRequestData() async {
    var response = await NetworkHttps.getRequest(
        "${API.meetingRequestData}?workspace_id=${Prefs.getString(AppConstant.workspaceId)}");
    if (response['status'] == 1) {
      var responseData = MeetingRequestData.fromJson(response);

      accountList.clear();
      contactList.clear();
      caseList.clear();
      opportunitiesList.clear();
      attendeesLeadList.clear();
      parentList.clear();
      assignUserList.clear();
      attendeesUsersList.clear();

      accountList.addAll(responseData.data!.account!);
      contactList.addAll(responseData.data!.contact!);
      caseList.addAll(responseData.data!.caseList!);
      opportunitiesList.addAll(responseData.data!.opportunities!);

      attendeesLeadList.addAll(responseData.data!.lead!);
      parentList.addAll(responseData.data!.parent!);

      assignUserList.addAll(responseData.data!.users!);
      attendeesUsersList.addAll(responseData.data!.users!);

      account.value =
          accountList.isNotEmpty ? accountList.first : DropdownModel();
      assignedUser.value =
          assignUserList.isNotEmpty ? assignUserList.first : DropdownModel();
      contact.value =
          contactList.isNotEmpty ? contactList.first : DropdownModel();
      attendeesLead.value = attendeesLeadList.isNotEmpty
          ? attendeesLeadList.first
          : DropdownModel();
      statusValue.value = statusList.first;

      attendeesUser.value =
          assignUserList.isNotEmpty ? assignUserList.first : DropdownModel();

      statusValue.value = statusList.first;
      selectedParentValue.value = parentList.isNotEmpty ? parentList.first : "";

      selectedAccountValue.value =
          accountList.isNotEmpty ? accountList.first.id.toString() : "0";
      assignedUserValue.value =
          assignUserList.isNotEmpty ? assignUserList.first.id.toString() : "0";
      selectedAttendeesContact.value =
          contactList.isNotEmpty ? contactList.first.id.toString() : "0";
      selectedAttendeesUsers.value = attendeesUsersList.isNotEmpty
          ? attendeesUsersList.first.id.toString()
          : "0";
      selectedAttendeesLead.value = attendeesLeadList.isNotEmpty
          ? attendeesLeadList.first.id.toString()
          : "0";

      print("account List $accountList");
      print("selectedParentValue$selectedParentValue");
      print("Parent List $parentList");

      getParentUserList(selectedParentValue.value);
      // isLoading.value = false;
    } else {
      commonToast(response['message']);
      // isLoading.value = false;
    }
  }

  createMeeting(bool isUpdate, String meetingId) async {
    print("isUpdate $isUpdate");

    var createUpdateApi =
        isUpdate ? "${API.updateMeeting}/$meetingId" : API.createMeeting;
    print("api name $createUpdateApi");

    Loader.showLoader();
    var response = await NetworkHttps.postRequest(createUpdateApi, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "name": nameController.text.toString(),
      "description": descriptionController.text.toString(),
      "parent": selectedParentValue.toString(),
      "assign_user": assignedUserValue.value,
      "status": statusValue.value,
      "attendees_contact": selectedAttendeesContact.value,
      "attendees_user": selectedAttendeesUsers.value,
      "attendees_lead": selectedAttendeesLead.value,
      "account": selectedAccountValue.value,
      "start_date": getParameterFormattedDate(startDate.value),
      "end_date": getParameterFormattedDate(endDate.value),
      "parent_id": selectedParentUserValue.value,
    });
    if (response['status'] == 1) {
      Loader.hideLoader();
      commonToast(response['message']);
      clearData();
      Get.back(result: true);
    } else {
      commonToast(response['message']);
      Loader.hideLoader();
    }
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

  getParentUserList(String? type) {
    print("type $type");
    print("accountList ${accountList}");
    parentUserList.clear();
    if (type == "account") {
      parentUserList.addAll(accountList);
    } else if (type == "contact") {
      parentUserList.addAll(contactList);
    } else if (type == "case") {
      parentUserList.addAll(caseList);
    } else if (type == "opportunities") {
      parentUserList.addAll(opportunitiesList);
    }
    parentUser.value = parentUserList.isNotEmpty ? parentUserList.first : DropdownModel();
    selectedParentUserValue.value = parentUserList.isNotEmpty ? parentUserList.first.id.toString() : "";
    print("parent userdata ${parentUserList.map((element) => element.name)}");
    parentUserList.refresh();
  }
}
