import 'package:get/get.dart';
import 'package:attendance/core/model/knowledge_base_response.dart';
import 'package:attendance/network_dio/network_dio_ticket.dart';
import 'package:attendance/utils/base_api_ticket.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';

import '../../../views/widgets/loading_widget.dart';

class KnowledgeBaseController extends GetxController {
  RxList<KnowLedgeData> knowLedgeList = <KnowLedgeData>[].obs;

  getKnowledgeData() async {
    Loader.showLoader();

    var response = await NetworkHttps.getRequest("${API.knowledges}?workspace_id=${Prefs.getString(AppConstant.workspaceId)}");

    if (response["status"] == 1) {
      knowLedgeList.clear();
      var responseData = KnowledgeBaseResponse.fromJson(response);
      knowLedgeList.addAll(responseData.data!);
      knowLedgeList.refresh();
    } else {
      commonToast("message");
    }
    Loader.hideLoader();
  }
}
