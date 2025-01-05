import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:attendance/multi/lib/multi_dropdown.dart';
import 'package:attendance/core/model/quote_response.dart';
import 'package:attendance/core/model/request_data_response.dart';
import 'package:attendance/network_dio/network_dio_sales.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_sales.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/loading_widget.dart';

class QuoteController extends GetxController {
  RxBool isLoading = false.obs;
  RxList quoteList = [].obs;
  RxInt currantPage = 1.obs;
  RxBool isScroll = true.obs;
  final MultiSelectController<DropdownModel> controller = MultiSelectController();

  TextEditingController nameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController quoteNumberController = TextEditingController();

  TextEditingController billingAddressController = TextEditingController();
  TextEditingController billingCityController = TextEditingController();
  TextEditingController billingStateController = TextEditingController();
  TextEditingController billingCountryController = TextEditingController();
  TextEditingController billingZipCodeController = TextEditingController();

  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController shippingCityController = TextEditingController();
  TextEditingController shippingStateController = TextEditingController();
  TextEditingController shippingCountryController = TextEditingController();
  TextEditingController shippingZipCodeController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  RxList<DropdownItem<DropdownModel>> valueItemList =
      <DropdownItem<DropdownModel>>[].obs;

  var taxCategoryList = [].obs;

  var billingContactModel = DropdownModel().obs;
  var billingContactID = ''.obs;
  RxList billingContactList = [].obs;

  var assignUserModel = DropdownModel().obs;
  var assignUserId = ''.obs;
  RxList assignUserList = [].obs;

  var shippingContactModel = DropdownModel().obs;
  var shippingContactId = ''.obs;
  RxList shippingContactList = [].obs;

  var shippingProviderModel = DropdownModel().obs;
  var shippingProviderId = ''.obs;
  RxList shippingProviderList = [].obs;

  RxString selectedOpportunityId = ''.obs;
  var selectedOpportunityModel = DropdownModel().obs;
  RxList opportunityList = [].obs;

  RxString selectedStatus = "".obs;
  RxList statusList = ["Open", "Cancelled"].obs;

  var quotedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    selectedStatus.value = statusList.first;
    quoteList.clear();
  }

  String getFormattedDate(DateTime now) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: quotedDate.value,
      firstDate: quotedDate.value,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != quotedDate.value) {
      quotedDate.value = picked;
    }
  }

  Future<void> getQuotes(int? page) async {
    if (page == 1) {
      isLoading.value = true;
    } else {
      Loader.showLoader();
    }
    var response = await NetworkHttps.getRequest(
        "${API.quote}?workspace_id=${Prefs.getString(AppConstant.workspaceId)}&page=$page");
    if (response['status'] == 1) {
      isLoading.value = false;

      if (currantPage.value == 1) {
        quoteList.clear();
      }
      var responseData = QuoteResponse.fromJson(response);
      quoteList.addAll(responseData.data!.data!);
      if (currantPage.value == responseData.data!.lastPage) {
        isScroll.value = false;
      }
      Loader.hideLoader();
    } else {
      isLoading.value = false;
      Loader.hideLoader();
      commonToast(response['message']);
    }
  }

  void updateSetData(QuoteData data) {
    nameController.text = data.name.toString();
    accountController.text = data.account.toString();
    descriptionController.text = data.description.toString();
    quoteNumberController.text = data.quoteNumber.toString();

    billingCountryController.text = data.billingCountry.toString();
    billingAddressController.text = data.billingAddress.toString();
    billingStateController.text = data.billingState.toString();
    billingZipCodeController.text = data.billingPostalcode.toString();
    billingCityController.text = data.billingCity.toString();

    shippingAddressController.text = data.shippingAddress.toString();
    shippingCountryController.text = data.shippingCountry.toString();
    shippingCityController.text = data.shippingCity.toString();
    shippingZipCodeController.text = data.shippingPostalcode.toString();
    shippingStateController.text = data.shippingState.toString();

    billingContactModel.value =
        getSelectedModel(billingContactList, data.billingContactId ?? 0);
    shippingContactModel.value =
        getSelectedModel(shippingContactList, data.shippingContactId ?? 0);
    shippingProviderModel.value =
        getSelectedModel(shippingProviderList, data.shippingProviderId ?? 0);
    assignUserModel.value =
        getSelectedModel(assignUserList, data.assignUserId ?? 0);
    selectedOpportunityModel.value =
        getSelectedModel(opportunityList, data.opportunityId ?? 0);

    selectedOpportunityId.value =
        getUserId(opportunityList, data.opportunityId);
    shippingProviderId.value =
        getUserId(shippingProviderList, data.shippingProviderId);
    shippingContactId.value =
        getUserId(shippingContactList, data.shippingContactId);
    assignUserId.value = getUserId(assignUserList, data.assignUserId);
    billingContactID.value =
        getUserId(billingContactList, data.billingContactId);

    selectedStatus.value = data.status.toString();

    quotedDate.value = DateFormat("dd-MM-yyyy").parse(data.dateQuoted.toString());
  }

  String getUserId(List list, int? id) {
    if (id != null && id != 0) {
      return id.toString();
    } else {
      return list.first.id.toString();
    }
  }

  DropdownModel getSelectedModel(List list, int id) {
    try {
      return list.singleWhere((element) => element.id == id);
    } catch (exception) {
      return list.first;
    }
  }

  void clearData() {
    nameController.clear();
    descriptionController.clear();
    notesController.clear();
    accountController.clear();
    quoteNumberController.clear();
    controller.clearAll();

    billingAddressController.clear();
    billingZipCodeController.clear();
    billingStateController.clear();
    billingCityController.clear();
    billingCountryController.clear();

    shippingAddressController.clear();
    shippingCountryController.clear();
    shippingCityController.clear();
    shippingStateController.clear();
    shippingZipCodeController.clear();

    selectedStatus.value = statusList.first;

    shippingProviderId.value = shippingProviderList.isNotEmpty
        ? shippingProviderList.first.id.toString()
        : "0";
    shippingProviderModel.value = shippingProviderList.isNotEmpty
        ? shippingProviderList.first
        : DropdownModel();

    shippingContactId.value = shippingContactList.isNotEmpty
        ? shippingContactList.first.id.toString()
        : "0";
    shippingContactModel.value = shippingContactList.isNotEmpty
        ? shippingContactList.first
        : DropdownModel();

    assignUserModel.value =
    assignUserList.isNotEmpty ? assignUserList.first : DropdownModel();
    assignUserId.value =
    assignUserList.isNotEmpty ? assignUserList.first.id.toString() : "0";
    selectedOpportunityId.value =
    opportunityList.isNotEmpty ? opportunityList.first.id.toString() : "0";
    selectedOpportunityModel.value =
    opportunityList.isNotEmpty ? opportunityList.first : DropdownModel();

    accountController.text =
    opportunityList.isNotEmpty ? opportunityList.first.accountName : "";

    billingContactModel.value = billingContactList.isNotEmpty
        ? billingContactList.first
        : DropdownModel();
    billingContactID.value = billingContactList.isNotEmpty
        ? billingContactList.first.id.toString()
        : "";
  }

  createQuote(bool isUpdate, String quoteId) async {
    Loader.showLoader();

    var createUpdateApi =
    isUpdate ? "${API.updateQuote}/$quoteId" : API.createQuote;


    var taxlist =controller.selectedItems.map((data) => data.value.id).toList();
    var response = await NetworkHttps.postRequest(createUpdateApi, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "name": nameController.text.toString(),
      "opportunity": selectedOpportunityId.value,
      "status": selectedStatus.value,
      "date_quoted": getParameterFormattedDate(quotedDate.value),
      "quote_number": quoteNumberController.text.toString(),
      "shipping_contact": shippingContactId.value,
      "billing_contact": billingContactID.value,
      "billing_address": billingAddressController.text.toString(),
      "billing_city": billingCityController.text.toString(),
      "billing_state": billingStateController.text.toString(),
      "billing_country": billingCountryController.text.toString(),
      "billing_postalcode": billingZipCodeController.text.toString(),
      "shipping_address": shippingAddressController.text.toString(),
      "shipping_city": shippingCityController.text.toString(),
      "shipping_state": shippingStateController.text.toString(),
      "shipping_country": shippingCountryController.text.toString(),
      "shipping_postalcode": shippingZipCodeController.text.toString(),
      "shipping_provider": shippingProviderId.value,
      "assign_user_id": assignUserId.value,
      "description": descriptionController.text.toString(),
      "tax": taxlist,
    });

    if (response['status'] == 1) {
      Loader.hideLoader();
      commonToast(response["message"]);
      clearData();
      Get.back(result: true);
    } else {
      Loader.hideLoader();
      commonToast(response["message"]);
    }
  }

  getRequestData() async {
    var response = await NetworkHttps.getRequest(
        "${API.requestData}?workspace_id=${Prefs.getString(AppConstant.workspaceId)}");

    if (response['status'] == 1) {
      opportunityList.clear();
      shippingContactList.clear();
      billingContactList.clear();
      assignUserList.clear();
      shippingProviderList.clear();
      valueItemList.clear();
      taxCategoryList.clear();
      controller.clearAll();

      var responseData = RequestDataResponse.fromJson(response);
      opportunityList.addAll(responseData.data!.opportunities!);

      shippingContactList.addAll(responseData.data!.contacts!);
      billingContactList.addAll(responseData.data!.contacts!);
      assignUserList.addAll(responseData.data!.users!);
      shippingProviderList.addAll(responseData.data!.shippingProvider!);

      print("billingContactList list  ${jsonEncode(billingContactList)}");
      print("shippingContactList list  ${jsonEncode(shippingContactList)}");

      valueItemList.value = responseData.data!.tax!.map((element) {
        return DropdownItem(
            label: element.name ?? "",
            value: DropdownModel(name: element.name, id: element.id));
      }).toList();
      selectedStatus.value = statusList.first;

      shippingProviderId.value = shippingProviderList.isNotEmpty
          ? shippingProviderList.first.id.toString()
          : "0";
      shippingProviderModel.value = shippingProviderList.isNotEmpty
          ? shippingProviderList.first
          : DropdownModel();

      shippingContactId.value = shippingContactList.isNotEmpty
          ? shippingContactList.first.id.toString()
          : "0";
      shippingContactModel.value = shippingContactList.isNotEmpty
          ? shippingContactList.first
          : DropdownModel();

      assignUserModel.value =
      assignUserList.isNotEmpty ? assignUserList.first : DropdownModel();
      assignUserId.value =
      assignUserList.isNotEmpty ? assignUserList.first.id.toString() : "0";

      selectedOpportunityId.value = opportunityList.isNotEmpty
          ? opportunityList.first.id.toString()
          : "0";
      selectedOpportunityModel.value =
      opportunityList.isNotEmpty ? opportunityList.first : DropdownModel();

      accountController.text =
      opportunityList.isNotEmpty ? opportunityList.first.accountName : "";

      billingContactModel.value = billingContactList.isNotEmpty
          ? billingContactList.first
          : DropdownModel();
      billingContactID.value = billingContactList.isNotEmpty
          ? billingContactList.first.id.toString()
          : "";
    } else {
      commonToast(response['message']);
    }
  }

  deleteQuote(String? quoteId) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest("${API.deleteQuote}/$quoteId",
        {"workspace_id": Prefs.getString(AppConstant.workspaceId)});

    if (response['status'] == 1) {
      Loader.hideLoader();
      commonToast(response['message']);
      for (var data in quoteList) {
        if (data.id.toString() == quoteId) {
          quoteList.remove(data);
          quoteList.refresh();
          return;
        }
      }
    } else {
      Loader.hideLoader();

      commonToast(response['message']);
    }
  }
}


