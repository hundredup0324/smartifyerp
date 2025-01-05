import 'package:attendance/network_dio/network_dio.dart';
import 'package:attendance/utils/base_api.dart';
import 'package:attendance/utils/prefer.dart';

class LogoutRepository {

  logOutFun() async {
    var response = await NetworkHttps.postRequest(API.logoutUrl, {});
    return response;
  }


  deleteUser() async {
    var response =await NetworkHttps.postRequest(API.deleteUser,{});
    return response;
  }

}