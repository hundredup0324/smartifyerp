import 'package:attendance/network_dio/network_dio_ticket.dart';
import 'package:attendance/utils/base_api_ticket.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';

class FaqRepository {
  getFaqData({int? page, int? perPage}) async {
    var response = await NetworkHttps.getRequest(
        "${API.faqUrl}?workspace_id=${Prefs.getString(AppConstant.workspaceId)}");
    return response;
  }
}
