// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:attendance/config/repository/ticket_repository.dart';
import 'package:attendance/core/model/create_ticket_data_response.dart';
import 'package:attendance/core/model/ticket_list_response.dart';
import 'package:attendance/core/model/ticket_status_model.dart';
import 'package:attendance/utils/base_api_ticket.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:http/http.dart' as http;

import '../../../network_dio/network_dio_ticket.dart';

class TicketController extends GetxController {
  TicketRepository ticketRepository = TicketRepository();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController subjectDescriptionController = TextEditingController();
  RxList categoryList = [].obs;
  RxString categoryValue = ''.obs;

  RxList<AccountType> accountFieldNameList = <AccountType>[].obs;
  RxList staffList = [].obs;
  RxList clientList = [].obs;
  RxList vendorList = [].obs;
  final accountNameField= AccountType().obs;
  RxString selectedCategoryId = ''.obs;
  RxList<String> statusList = <String>["In Progress", "On Hold", "Closed"].obs;
  RxList<String> accountTypeList = <String>["Custom", "Staff", "Client", "Vendor"].obs;
  RxString selectedAccountType = "Custom".obs;
  RxString statusValue = ''.obs;
  RxInt defaultPage = 1.obs;
  RxInt currantPage = 1.obs;
  RxBool isScroll = true.obs;

  RxList<TicketData> ticketList = <TicketData>[].obs;

  TicketStatus? ticketStatus;




  getTickets(int pageNo) async {
    Loader.showLoader();
    var response = await ticketRepository.getTicket(pageNo: pageNo);
    print("response---->$response");
    if (response['status'] == 1) {
      var ticketsModel = TicketListResponse.fromJson(response);
      if(currantPage.value==1)
        {
          ticketList.clear();
        }
      ticketList.addAll(ticketsModel.data!.data!);
      ticketList.refresh();
      if (currantPage.value == ticketsModel.data!.lastPage) {
        isScroll.value = false;
      }
    } else {
      commonToast(response["message"]);
    }

    Loader.hideLoader();
  }

  createTicketData() async {
    Loader.showLoader();
    var response = await ticketRepository.createTicketData();

    if (response['status'] == 1) {
      categoryList.clear();
      staffList.clear();
      clientList.clear();
      vendorList.clear();
      var ticketDataResponse = CreateTicketDataResponse.fromJson(response);
      categoryList.addAll(ticketDataResponse.data!.category!);
      vendorList.addAll(ticketDataResponse.data!.vendor!);
      clientList.addAll(ticketDataResponse.data!.client!);
      staffList.addAll(ticketDataResponse.data!.staff!);
      staffList.refresh();
      vendorList.refresh();
      clientList.refresh();
      categoryList.refresh();
      print("CategorySize ${categoryList.length}");
    } else {
      commonToast(response['message']);
    }
    Loader.hideLoader();
  }

  deleteTicket(String ticketId) async {
    Loader.showLoader();
    var response = await ticketRepository.deleteTicket(ticketId);
    if (response != null) {
      print("delete response--->${response}");
      if (response['status'] == 1) {
        commonToast("Successfully deleted.");
        ticketList.clear();
      }
      getTickets(defaultPage.value);
      Get.back();
    }
  }

  createNewTicket() async {
    var accountTypeValue = selectedAccountType.value.replaceFirst(
        selectedAccountType.value[0],
        selectedAccountType.value[0].toLowerCase());
    Loader.showLoader();
    var request = {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "account_type": accountTypeValue,
      'name': selectedAccountType.value == "Custom" ? nameController.text
          .toString() : accountNameField.value.id.toString(),
      'email': emailController.text,
      'category': selectedCategoryId.value,
      'subject': subjectController.text,
      'status': statusValue.value,
      'description': subjectDescriptionController.text
    };


    var response = await NetworkHttps.postRequest(API.createTicketUrl, request);
    if (response['status'] == 1) {
      nameController.clear();
      emailController.clear();
      subjectDescriptionController.clear();
      selectedCategoryId.value = "";
      commonToast(response["message"]);
      isScroll.value = true;
      currantPage(1);
      Loader.hideLoader();
      await getTickets(defaultPage.value);

    } else {
      commonToast(response["message"]);
    }

    Loader.hideLoader();
  }

  updateTicket(String? ticketId) async {
    var accountTypeValue = selectedAccountType.value.replaceFirst(
        selectedAccountType.value[0],
        selectedAccountType.value[0].toLowerCase());
    Loader.showLoader();
    print("status ${statusValue.value}");
    var request = {
      "workspace_id": Prefs.getString(AppConstant.workspaceId),
      "account_type": accountTypeValue,
      'name': selectedAccountType.value == "Custom" ? nameController.text.toString() : accountNameField.value.id.toString(),
      'email': emailController.text,
      'category': selectedCategoryId.value,
      'subject': subjectController.text,
      'status': statusValue.value,
      'description': subjectDescriptionController.text
    };


    var response = await NetworkHttps.postRequest("${API.updateTicketUrl}/$ticketId", request);

    if (response['status'] == 1) {
      nameController.clear();
      emailController.clear();
      subjectDescriptionController.clear();
      selectedCategoryId.value = "";
      commonToast(response["message"]);
      isScroll.value = true;
      currantPage(1);
      Loader.hideLoader();
      // Get.back();

      await getTickets(defaultPage.value);

    } else {
      commonToast(response["message"]);
    }
    Loader.hideLoader();
  }
}



class AccountType {
  String? id;

  String? name;

  String? email;

  AccountType( {this.id, this.name, this.email});
}

