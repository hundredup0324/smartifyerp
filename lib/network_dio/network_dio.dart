
import 'dart:convert';
import 'dart:io';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/base_api.dart';
import '../utils/common_snackbar_widget.dart';
import '../utils/prefer.dart';


class NetworkHttps {
  String accessToken = Prefs.getToken();

  NetworkHttps._privateConstructor();

  static final NetworkHttps getInstance = NetworkHttps._privateConstructor();
  static final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    HttpHeaders.cacheControlHeader: "no-cache",
  };

  static Future getRequest(String endPoint) async {
    var getUrl = API.baseUrl + endPoint;
    print("GET API URL===> $getUrl");
    print("authHeaders===>${Prefs.getToken()}");
    try {
      var response = await http.get(Uri.parse(getUrl), headers: {
        "Authorization": 'Bearer ${Prefs.getToken()}',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.cacheControlHeader: "no-cache",
      });
      print("statusCode===> ${response.statusCode}");
      print("response body===> ${response.body}");
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        await Prefs.clear();
        Get.offAll(() => LoginScreen());
      }
      _handleError(response);
    } on Exception catch (e) {
      print("err->${e.toString()}");
      // commonToast("No Internet connection.");
      throw Exception('No Internet connection.');
    }
  }

  static Future postRequest(String endPoint, Map data) async {
    String postUrl = API.baseUrl + endPoint;
    print("POST API URL===> $postUrl");
    print("data===> ${jsonEncode(data)}");
    print("authHeaders===>${Prefs.getToken()}");
    try {
      var response = await http.post(Uri.parse(postUrl), body: jsonEncode(data), headers: {
        "Authorization": 'Bearer ${Prefs.getToken()}',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.cacheControlHeader: "no-cache",
      });
      print("statusCode===> ${response.statusCode}");
      print("response body===> ${response.body}");
      print("response c===> ${response.statusCode == 200 || response.statusCode == 201}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        await Prefs.clear();
        Get.offAll(() => LoginScreen());
        Get.deleteAll();
      }else {
        Loader.hideLoader();
        commonToast(json.decode(response.body)['message'].toString());

      }
      _handleError(response);
    } on Exception catch (e) {
      print("err->${e.toString()}");

      throw Exception('No Internet connection.---->${e.toString()}');
    }
  }

  static Future deleteRequest(String endPoint) async {
    String deleteUrl = API.baseUrl + endPoint;
    try {
      var response = await http.delete(Uri.parse(deleteUrl), headers: {
        "Authorization": 'Bearer ${Prefs.getToken()}',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.cacheControlHeader: "no-cache",
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        await Prefs.clear();
        Get.offAll(() => LoginScreen());
      }else if (response.statusCode == 403)
      {
        commonToast(json.decode(response.body)['message'].toString());
      }
      _handleError(response);
    } on Exception catch (e) {
      commonToast("err->${e.toString()}");
      throw Exception('No Internet connection.');
    }
  }

  static Exception _handleError(http.Response response) {
    switch (response.statusCode) {
      case 400:
      case 401:
      case 404:
      case 500:
        commonToast(json.decode(response.body)['message'].toString());
        throw Exception(json.decode(response.body).toString());
      default:
        throw Exception("An error occurred, status code: ${response.statusCode}");
    }
  }
}
