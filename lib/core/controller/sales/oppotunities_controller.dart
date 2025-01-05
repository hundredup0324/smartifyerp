import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:attendance/core/model/opprtunity_response.dart';
import 'package:attendance/core/model/request_data_response.dart';
import 'package:attendance/network_dio/network_dio_sales.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_sales.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/loading_widget.dart';

class OpportunitiesController extends GetxController {
  RxList<OpportunityData> opportunityList = <OpportunityData>[].obs;
  RxBool isLoading = false.obs;
  RxInt currantPage = 1.obs;
  RxBool isScroll = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController probabilityController = TextEditingController();

  var selectedAccountValue = ''.obs;
  RxList accountList = [].obs;
  var account = DropdownModel().obs;

  var contact = DropdownModel().obs;
  RxList contactList = [].obs;
  var selectedContactValue = ''.obs;

  var leadSource = DropdownModel().obs;
  RxList leadSourceList = [].obs;
  var selectedLeadSourceValue = ''.obs;

  var selectedOpportunityStage = DropdownModel().obs;
  RxList opportunityStageList = [].obs;
  var selectedOpportunityStageId = ''.obs;

  var assignUser = DropdownModel().obs;
  RxList assignUserList = [].obs;
  var assignUserIdValue = ''.obs;

  final closeDate = DateTime.now().obs;

  clearData() {
    nameController.clear();
    descriptionController.clear();
    amountController.clear();
    probabilityController.clear();


    account.value =accountList.isNotEmpty?  accountList.first:DropdownModel();
    assignUser.value = assignUserList.isNotEmpty?  assignUserList.first:DropdownModel();
    contact.value = contactList.isNotEmpty? contactList.first:DropdownModel();
    leadSource.value =  leadSourceList.isNotEmpty? leadSourceList.first:DropdownModel();
    selectedOpportunityStage.value =opportunityStageList.isNotEmpty? opportunityStageList.first:DropdownModel();

    selectedContactValue.value = contactList.isNotEmpty?   contactList.first.id.toString():"0";
    selectedAccountValue.value =accountList.isNotEmpty?  accountList.first.id.toString():"0";
    assignUserIdValue.value = assignUserList.isNotEmpty? assignUserList.first.id.toString():"0";
    selectedLeadSourceValue.value =leadSourceList.isNotEmpty? leadSourceList.first.id.toString():"0";
    selectedOpportunityStageId.value =opportunityStageList.isNotEmpty?  opportunityStageList.first.id.toString():"0";


  }

  updateData(OpportunityData data) {
   /* var amount=data.amount!.replaceAll(RegExp(r'[$,]'), '');

    if (amount.isNotEmpty) {
      amount=  amount.replaceAll(new RegExp(r'[^0-9]'),'');
      // amount = amount.substring(0, amount.length - 1);
    }*/
    nameController.text = data.name.toString();
    descriptionController.text = data.description.toString();
    amountController.text = cleanValue(data.amount??"00");
    probabilityController.text = data.probability.toString();

    try {
      DateFormat formatter = DateFormat("dd-MM-yyyy");
      DateTime parsedDate = formatter.parse(data.closeDate.toString());
      closeDate.value = parsedDate;
      print(parsedDate); // Output: 2023-02-12 00:00:00.000000Z
    } on FormatException catch (e) {
      print("Error parsing date: $e");
      // Handle the parsing error
    }
    // closeDate.value=DateTime.parse(data.closeDate.toString());

    account.value = getSelectedModel(accountList, data.accountId??0);
    assignUser.value = getSelectedModel(assignUserList, data.assignUserId??0);
    leadSource.value = getSelectedModel(leadSourceList, data.leadSource ==null?leadSourceList.first.id: data.leadSource?.id);
    selectedOpportunityStage.value = getSelectedModel(opportunityStageList, data.opportunityStageId??0);
    contact.value=  getSelectedModel(contactList,data.contactId??0);

    selectedContactValue.value=getUserId(contactList, data.contactId);
    selectedOpportunityStageId.value = getUserId(opportunityStageList, data.opportunityStageId);
    selectedLeadSourceValue.value = data.leadSource?.id.toString() ?? leadSourceList.first.id.toString();
    assignUserIdValue.value = getUserId(assignUserList, data.assignUserId);
    selectedAccountValue.value = getUserId(accountList, data.accountId);
  }
  String cleanValue(String value) {
    String cleaned = value.replaceAll(RegExp(r'[$,]'), '');
    String integerPart = cleaned.split('.')[0];
    return integerPart;
  }


  String getUserId(List list,int? id)
  {
    if(id!=null && id!=0)
    {
      return id.toString();
    }else {
      return list.first.id.toString();
    }
  }

  DropdownModel getSelectedModel(List list, int id) {
    try {
      print("id $id");
      print("list ${jsonEncode(list)}");
      print("model ${jsonEncode(list.singleWhere((element) => element.id==id))}");
      return list.singleWhere((element) => element.id==id);

    }catch(exception)
    {
      return list.first;
    }
  }



  getOpportunities(int? page) async {
    if(page==1) {
      isLoading.value = true;
    }else
      {
        Loader.showLoader();

      }
    var response = await NetworkHttps.getRequest(
        "${API.opportunities}?workspace_id=${Prefs.getString(AppConstant.workspaceId)}&page=$page");

    if (response['status'] == 1) {
      isLoading.value=false;
      if (page == 1) {
        opportunityList.clear();
      }
      var responseData = OpportunityResponse.fromJson(response);
      opportunityList.addAll(responseData.data!.data!);
      Loader.hideLoader();
      if (currantPage.value == responseData.data!.lastPage) {
        isScroll.value = false;
      }
    } else {
      isLoading.value=false;

      commonToast(response['message']);
      Loader.hideLoader();
    }
  }

  createOpportunity() async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(API.createOpportunities, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "name": nameController.text.toString(),
      "amount": amountController.text.toString(),
      "description": descriptionController.text.toString(),
      "close_date": getParameterFormattedDate(closeDate.value),
      "probability": probabilityController.text.toString(),
      "contact_id": selectedContactValue.value,
      "lead_source_id": selectedLeadSourceValue.value,
      "opportunity_stage_id": selectedOpportunityStageId.value,
      "sales_account_id": selectedAccountValue.value,
      "assign_user_id": assignUserIdValue.value,
    });

    if (response['status'] == 1) {
      Loader.hideLoader();
      clearData();
      Get.back(result: true);
    } else {
      commonToast(response['message']);
    }
    Loader.hideLoader();
  }

  updateOpportunity(String opportunityId) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(
        "${API.updateOpportunities}/$opportunityId", {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "name": nameController.text.toString(),
      "amount": amountController.text.toString(),
      "description": descriptionController.text.toString(),
      "close_date": getParameterFormattedDate(closeDate.value),
      "probability": probabilityController.text.toString(),
      "contact_id": selectedContactValue.value,
      "lead_source_id": selectedLeadSourceValue.value,
      "opportunity_stage_id": selectedOpportunityStageId.value,
      "sales_account_id": selectedAccountValue.value,
      "assign_user_id": assignUserIdValue.value,
    });

    if (response['status'] == 1) {
      Loader.hideLoader();
      clearData();
      Get.back(result: true);
    } else {
      commonToast(response['message']);
    }
    Loader.hideLoader();
  }

  deleteOpportunities(String? opportunitiesID) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(
        "${API.deleteOpportunities}/$opportunitiesID",
        {"workspace_id": Prefs.getString(AppConstant.workspaceId)});

    if (response['status'] == 1) {
      Loader.hideLoader();
      commonToast(response['message']);
      for (var data in opportunityList) {
        if (data.id.toString() == opportunitiesID) {
          opportunityList.remove(data);
          opportunityList.refresh();
          return;
        }
      }
    } else {
      commonToast(response['message']);
    }

    Loader.hideLoader();
  }

  requestData() async {
    var response = await NetworkHttps.getRequest(
        "${API.requestData}?workspace_id=${Prefs.getString(AppConstant.workspaceId)}");
    if (response['status'] == 1) {
      var responseData = RequestDataResponse.fromJson(response);

      accountList.clear();
      contactList.clear();
      opportunityStageList.clear();
      assignUserList.clear();
      leadSourceList.clear();

      accountList.addAll(responseData.data!.accounts!);
      contactList.addAll(responseData.data!.contacts!);
      opportunityStageList.addAll(responseData.data!.opportunitiesStages!);
      assignUserList.addAll(responseData.data!.users!);
      leadSourceList.addAll(responseData.data!.leadSources!);


      account.value =accountList.isNotEmpty?  accountList.first:DropdownModel();
      assignUser.value = assignUserList.isNotEmpty?  assignUserList.first:DropdownModel();
      contact.value = contactList.isNotEmpty? contactList.first:DropdownModel();
      leadSource.value =  leadSourceList.isNotEmpty? leadSourceList.first:DropdownModel();
      selectedOpportunityStage.value =opportunityStageList.isNotEmpty? opportunityStageList.first:DropdownModel();

      selectedContactValue.value = contactList.isNotEmpty?   contactList.first.id.toString():"0";
      selectedAccountValue.value =accountList.isNotEmpty?  accountList.first.id.toString():"0";
      assignUserIdValue.value = assignUserList.isNotEmpty? assignUserList.first.id.toString():"0";
      selectedLeadSourceValue.value =leadSourceList.isNotEmpty? leadSourceList.first.id.toString():"0";
      selectedOpportunityStageId.value =opportunityStageList.isNotEmpty?  opportunityStageList.first.id.toString():"0";
    } else {
      commonToast(response['message']);
    }
  }

  String getFormattedDate(DateTime now) {
    final formatter = DateFormat('dd/MM/yyyy');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: closeDate.value,
      firstDate: closeDate.value,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != closeDate.value) {
      closeDate.value = picked;
    }
    print("startDate ${closeDate.value}");
  }
}
