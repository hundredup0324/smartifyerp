// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import '../utils/base_api_ticket.dart';

class NetworkHttps {
  String accessToken = Prefs.getToken();

  NetworkHttps._privateConstructor();

  static final NetworkHttps getInstance = NetworkHttps._privateConstructor();
  static final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    HttpHeaders.cacheControlHeader: "no-cache",
  };

  static Future getRequest(String endPoint) async {
    var getUrl = API.mainUrl + endPoint;
    print("GET API URL===> $getUrl");
    print("authHeaders===>${Prefs.getToken()}");

    try {
      var response = await http.get(Uri.parse(getUrl), headers: {
        "Authorization": 'Bearer ${Prefs.getToken()}',
        'Accept': 'application/json',
        HttpHeaders.contentTypeHeader: "application/json"
      },);
      print("statusCode===> ${response.statusCode}");
      print("response body===> ${response.body}");
      // return response;
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
    String postUrl = API.mainUrl + endPoint;
    print("POST API URL===> $postUrl");
    print("data===> ${jsonEncode(data)}");
    print("authHeaders===>${Prefs.getToken()}");
    try {
      var response =
          await http.post(Uri.parse(postUrl), body: jsonEncode(data), headers: {
        "Authorization": 'Bearer ${Prefs.getToken()}',
        'Accept': 'application/json',
        HttpHeaders.contentTypeHeader: "application/json",
      });
      print("statusCode===> ${response.statusCode}");
      print("response body===> ${response.body}");
      print("response c===> ${response.statusCode == 200 || response.statusCode == 201}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        await Prefs.clear();
        Get.offAll(() => LoginScreen());
      }else {
        Loader.hideLoader();
        commonToast(json.decode(response.body)['message'].toString());

      }
      _handleError(response);
    } on Exception catch (e) {
      print("err->${e.toString()}");

      // commonToast("No Internet connection.");
      throw Exception('No Internet connection.---->${e.toString()}');
    }
  }

  static Future deleteRequest(String endPoint) async {
    String deleteUrl = API.mainUrl + endPoint;

    print(" delete API URL===> $deleteUrl");
    try {
      var response = await http.delete(Uri.parse(deleteUrl), headers: {
        "Authorization": 'Bearer ${Prefs.getToken()}',
        'Accept': 'application/json',
        HttpHeaders.cacheControlHeader: "no-cache",
      });
      print("statusCode===> ${response.statusCode}");
      print("response body===> ${response.body}");
      print(
          "response c===> ${response.statusCode == 200 || response.statusCode == 201}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        await Prefs.clear();
        Get.offAll(() => LoginScreen());
      }
      _handleError(response);
    } on Exception catch (e) {
      commonToast("err->${e.toString()}");
      throw Exception("err->${e.toString()}");
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
