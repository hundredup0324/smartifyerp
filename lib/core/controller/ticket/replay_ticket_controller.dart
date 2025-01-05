import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:attendance/utils/base_api_ticket.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:http/http.dart' as http;

class ReplayController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  RxList imagePathList = [].obs;

  pickImage() async {
    final List<XFile> media = await _picker.pickMultiImage();
    print("media--->$media");
    if (media != null) {
      imagePathList.value = media;
      imagePathList.refresh();
      print("imagePath---->(£$imagePathList)");
    } else {
      commonToast("Image not pick");
    }
  }

  addReplay({
    required String ticketId,
    required String description,
    required List imageList,
  }) async {
    Loader.showLoader();

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Prefs.getToken()}',
    };
    String url = "${API.mainUrl}${API.replayTicketUrl}/$ticketId";
    print("url--> $url");
    print("ticketID--> $ticketId");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({'workspace_id': Prefs.getString(AppConstant.workspaceId), 'reply_description': description});
    if (imageList.isNotEmpty) {
      for (int i = 0; i < imageList.length; i++) {
        request.files.add(await http.MultipartFile.fromPath('reply_attachments[$i]', imageList[i].path));
      }
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("-=-==========statusCode= (${response.statusCode})");

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print("-=-==========responseData= ($responseData)");
      var decodedData = jsonDecode(responseData);
      print("-=-=------${decodedData['data']}");
      if (decodedData['status'] == 1) {
        imageList.clear();
        descriptionController.clear();
        commonToast('Reply added successfully');
      } else {
        commonToast(decodedData['data']['massage']);
      }

      Loader.hideLoader();
    } else if (response.statusCode == 401) {
      await Prefs.clear();
      Get.offAll(() => LoginScreen());
    } else {
      print(response.reasonPhrase);
    }
  }
}
