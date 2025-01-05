import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:attendance/core/model/request_data_response.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/core/model/sales_order_response.dart';
import 'package:attendance/network_dio/network_dio_sales.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/base_api_sales.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/loading_widget.dart';

class SalesOrderController extends GetxController {
  RxBool isLoading = false.obs;
  RxList salesOrderList = [].obs;
  RxInt currantPage = 1.obs;
  RxBool isScroll = true.obs;
  RxBool btnClick = true.obs;


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

  TextEditingController taxController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  var accountId = ''.obs;

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

  RxString selectedQuoteId = ''.obs;
  var selectedQuoteModel = DropdownModel().obs;
  RxList quoteList = [].obs;

  RxString selectedTaxId = ''.obs;
  var selectedTaxModel = DropdownModel().obs;
  RxList taxList = [].obs;

  RxString selectedStatus = "".obs;
  RxList statusList = ["Open", "Cancelled"].obs;

  var salesOrderDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    selectedStatus.value = statusList.first;
    salesOrderList.clear();
  }

  getSalesOrderList(int? page) async {
    if(page==1)
      {
        isLoading.value=true;
      }else
        {
          Loader.showLoader();

        }
    var response = await NetworkHttps.getRequest(
        "${API.salesOrders}?workspace_id=${Prefs.getString(AppConstant.workspaceId)}&page=$page");
    if (response['status'] == 1) {
      isLoading.value=false;

      Loader.hideLoader();
      if(page==1)
        {
          salesOrderList.clear();

        }

      var responseData = SalesOrderResponse.fromJson(response);
      salesOrderList.addAll(responseData.data!.data!);
      if (currantPage.value == responseData.data!.lastPage) {
        isScroll.value = false;
      }
    } else {
      isLoading.value=false;

      Loader.hideLoader();
      commonToast(response['message']);
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
      taxList.clear();
      quoteList.clear();

      var responseData = RequestDataResponse.fromJson(response);
      opportunityList.addAll(responseData.data!.opportunities!);
      quoteList.addAll(responseData.data!.quotes!);

      shippingContactList.addAll(responseData.data!.contacts!);
      billingContactList.addAll(responseData.data!.contacts!);
      taxList.addAll(responseData.data!.tax!);

      assignUserList.addAll(responseData.data!.users!);
      shippingProviderList.addAll(responseData.data!.shippingProvider!);

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

      accountController.text = opportunityList.isNotEmpty
          ? opportunityList.first.accountName.toString()
          : "";
      accountId.value = opportunityList.isNotEmpty
          ? opportunityList.first.accountId.toString()
          : "0";

      selectedQuoteId.value =
          quoteList.isNotEmpty ? quoteList.first.id.toString() : "0";
      selectedQuoteModel.value =
          quoteList.isNotEmpty ? quoteList.first : DropdownModel();

      billingContactModel.value = billingContactList.isNotEmpty
          ? billingContactList.first
          : DropdownModel();
      billingContactID.value = billingContactList.isNotEmpty
          ? billingContactList.first.id.toString()
          : "0";
    } else {
      commonToast(response['message']);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != salesOrderDate.value) {
      salesOrderDate.value = picked;
    }
  }

  updateSetData(SalesOrderData data) {
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

    // shippingProviderModel.value=getSelectedModel(shippingProviderList, data.shi)
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
    selectedQuoteModel.value = getSelectedModel(quoteList, data.quoteId ?? 0);
    selectedTaxModel.value = taxList.isNotEmpty
        ? getSelectedModel(taxList, data.tax?.id ?? 0)
        : DropdownModel();

    selectedOpportunityId.value =
        getUserId(opportunityList, data.opportunityId);
    shippingProviderId.value =
        getUserId(shippingProviderList, data.shippingProviderId);
    shippingContactId.value =
        getUserId(shippingContactList, data.shippingContactId);
    assignUserId.value = getUserId(assignUserList, data.assignUserId);
    selectedQuoteId.value = getUserId(quoteList, data.quoteId);
    billingContactID.value =
        getUserId(billingContactList, data.billingContactId);
    selectedTaxId.value =
        taxList.isNotEmpty ? getUserId(taxList, data.tax?.id ?? 0) : "0";

    selectedStatus.value = data.status.toString();

    DateFormat formatter = DateFormat("yyyy-MM-dd");
    var ymdFormatterDate=formatter.parse(data.dateQuoted.toString());
    DateFormat dmyFormatter = DateFormat("dd-MM-yyyy");
    var dmyDate=dmyFormatter.format(ymdFormatterDate);
    salesOrderDate.value = dmyFormatter.parse(dmyDate);
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

  createSalesOrder(bool isUpdate, String salesOrderId) async {
    Loader.showLoader();

    var createUpdateApi = isUpdate
        ? "${API.updateSalesOrder}/$salesOrderId"
        : API.createSalesOrders;
    print("startDate sdklfjls");
    var response = await NetworkHttps.postRequest(createUpdateApi, {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "name": nameController.text.toString(),
      "opportunity_id": selectedOpportunityId.value,
      "quote_id": selectedQuoteId.value,
      "status": selectedStatus.value,
      "date_quoted": getParameterFormattedDate(salesOrderDate.value),
      "quote_number": quoteNumberController.text.toString(),
      "shipping_contact_id": shippingContactId.value,
      "billing_contact_id": billingContactID.value,
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
      "shipping_provider_id": shippingProviderId.value,
      "assign_user_id": assignUserId.value,
      "description": descriptionController.text.toString(),
      "tax": selectedTaxId.value,
      "account_id": selectedTaxId.value,
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

  clearData() {
    nameController.clear();
    descriptionController.clear();
    notesController.clear();
    accountController.clear();
    quoteNumberController.clear();

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

    accountController.text = opportunityList.isNotEmpty
        ? opportunityList.first.accountName.toString()
        : "";
    accountId.value = opportunityList.isNotEmpty
        ? opportunityList.first.accountId.toString()
        : "0";

    selectedQuoteId.value =
        quoteList.isNotEmpty ? quoteList.first.id.toString() : "0";
    selectedQuoteModel.value =
        quoteList.isNotEmpty ? quoteList.first : DropdownModel();

    billingContactModel.value = billingContactList.isNotEmpty
        ? billingContactList.first
        : DropdownModel();
    billingContactID.value = billingContactList.isNotEmpty
        ? billingContactList.first.id.toString()
        : "0";

    selectedTaxModel.value =taxList.isNotEmpty? taxList.first:DropdownModel();
    selectedTaxId.value =taxList.isNotEmpty? taxList.first.id.toString():"0";
  }

  deleteSalesOrder(String? orderId) async {
    Loader.showLoader();
    var response = await NetworkHttps.postRequest(
        "${API.deleteSalesOrder}/$orderId",
        {"workspace_id": Prefs.getString(AppConstant.workspaceId)});

    if (response['status'] == 1) {
      Loader.hideLoader();
      commonToast(response['message']);
      for (var data in salesOrderList) {
        if (data.id.toString() == orderId) {
          salesOrderList.remove(data);
          salesOrderList.refresh();
          return;
        }
      }
    } else {
      Loader.hideLoader();

      commonToast(response['message']);
    }
  }
}
