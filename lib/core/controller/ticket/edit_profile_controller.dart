import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/core/controller/ticket/setting_controller.dart';
import 'package:attendance/utils/base_api_ticket.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/loading_widget.dart';

class EditProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  SettingControllerTicket settingController =Get.find<SettingControllerTicket>();

  final ImagePicker _picker = ImagePicker();
  RxString imagePath = ''.obs;
  RxString profileImage = ''.obs;



  @override
  void onInit() {
    super.onInit();
    imagePath.value = '';
    nameController.text = Prefs.getString(AppConstant.userName);
    emailController.text = Prefs.getString(AppConstant.emailId);
    phoneController.text = Prefs.getString(AppConstant.phoneNo);
    profileImage.value = Prefs.getString(AppConstant.profileImage);
  }

  pickImage({required ImageSource imageSource}) async {
    final XFile? media = await _picker.pickImage(source: imageSource);
    Get.back();
    print("media--->$media");
    if (media != null) {
      imagePath.value = media.path;
      print("imagePath---->(£$imagePath)");
    } else {
      commonToast("Image not pick");
    }
  }

  saveProfileData({
    String? email,
    String? name,
    String? phoneNo,
    String? avatar,
  }) async {
    String url = API.mainUrl + API.editProfileUrl;
    print("url==>$url");
    print("data==>${{'name': name!, 'email': email!, "mobile_no": phoneNo!}}");
    Loader.showLoader();
    var headers = {
      "Authorization": 'Bearer ${Prefs.getToken()}',
    };
    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.fields.addAll({
      'name': name,
      'email': email,
      "mobile_no": phoneNo,
    });
    print("avatar${avatar}");
    if (avatar != '') {
      request.files.add(await http.MultipartFile.fromPath('profile', avatar!));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var decodedData = jsonDecode(await response.stream.bytesToString());
    print(response.statusCode);
    print(jsonEncode(decodedData['data']));
    if (response.statusCode == 200) {
      if (decodedData['status'] == 1) {
        Prefs.setString(AppConstant.userName, decodedData['data']['name']);
        Prefs.setString(AppConstant.emailId, decodedData['data']['email']);
        Prefs.setString(AppConstant.phoneNo, decodedData['data']['mobile_no']);
        Prefs.setString(AppConstant.profileImage, decodedData['data']['avatar']);
        commonToast(decodedData['message']);
        settingController.name.value=decodedData['data']['name'];
        settingController.email.value=decodedData['data']['email'];
        settingController.profileImage.value=decodedData['data']['avatar'];
        Loader.hideLoader();
        Get.back(result: true);
      } else if (decodedData['status'] == 0) {
        Loader.hideLoader();
        commonToast(decodedData['message']);
      } else {
        commonToast(decodedData['message']);

      }
    }else {
      commonToast(decodedData['message']);

    }
  }
}
