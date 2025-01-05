import 'package:attendance/network_dio/network_dio_ticket.dart';
import 'package:attendance/utils/base_api_ticket.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';

class TicketRepository {
  getTicket({
    required int pageNo,
    String? searchPar,
  }) async {
    var response = await NetworkHttps.getRequest(
        API.ticketUrl + API.workspaceId+ Prefs.getString(AppConstant.workspaceId)+API.pageUrl + pageNo.toString());
    return response;
  }


  deleteTicket(String ticketId) async {
    var response = await NetworkHttps.postRequest("${API.deleteTicketUrl}/$ticketId", {'workspace_id': Prefs.getString(AppConstant.workspaceId)});
    return response;
  }


  createTicketData() async {
    var response =await NetworkHttps.getRequest(API.createTicketData + API.workspaceId + Prefs.getString(AppConstant.workspaceId));
    return response;

  }
}
