import 'dart:developer';

import 'package:attendance/network_dio/network_dio_ticket.dart';
import 'package:attendance/utils/base_api_ticket.dart';
import 'package:attendance/utils/prefer.dart';

class HomeRepository {
  getDashBordData() async {
    var response =
        await NetworkHttps.postRequest(API.homeUrl, {'id': Prefs.getUserID()});
    log("message==> $response");
    return response;
  }
}
