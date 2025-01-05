// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:attendance/core/model/faq_model.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:attendance/config/repository/faq_repository.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';

class FaqController extends GetxController {
  FaqRepository faqRepository = FaqRepository();
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  RxInt defaultPage = 1.obs;
  RxInt currantPage = 1.obs;
  RxInt perPage = 10.obs;
  RxBool isScroll = true.obs;
  FaqModel? faqClass;
  RxList<FaqModelData> faqList = <FaqModelData>[].obs;

  getFaqData({int? page, int? perPage}) async {
    Loader.showLoader();
    var response = await faqRepository.getFaqData(page: page, perPage: perPage);
    print("faq response---->$response");
    if (response != null) {
      if (response['status'] == 1) {
        faqClass = FaqModel.fromJson(response);
        faqList.addAll(faqClass!.data!);
        faqList.refresh();
        print("faq faqList----->$faqList");
      }
      Get.back();
    }
  }


}
