// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:attendance/views/pages/ticket/home_screen/home_screen.dart';
import 'package:attendance/views/pages/ticket/knowledgebase/knowledge_base_screen.dart';
import 'package:attendance/views/pages/ticket/manage_faq_screen.dart';
import 'package:attendance/views/pages/ticket/setting_screen/setting_screen.dart';
import 'package:attendance/views/pages/ticket/tickets_screen/tickets_screen.dart';

import '../../../utils/images.dart';


class DashBoardManagerController extends GetxController {
  RxInt currantIndex = 0.obs;
  List itemList = [
    {"icon": "asset/image/svg_image/home.svg", "title": "Dashboard", "screen": HomeScreen()},
    {"icon": DefaultImages.ticketsIcn, "title": "Tickets", "screen": TicketsScreen()},
    {"icon": DefaultImages.categoryIcn, "title": "Knowledge", "screen": KnowledgeBaseScreen()},
    {"icon": DefaultImages.userIcn, "title": "Faqs", "screen": ManageFaqScreen()},
  ];
}
