import 'package:attendance/utils/base_api.dart';

import '../../network_dio/network_dio.dart';

class ChangePasswordRepository {


 changePassword({
  required String oldPassword,
  required String newPassword,
  required String confirmPassword,
 }) async {
  var response = await NetworkHttps.postRequest(API.changePasswordUrl, {
   'password': newPassword,
   'password_confirmation': confirmPassword,
   'current_password': oldPassword
  });
  return response;
 }

}