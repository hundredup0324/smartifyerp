// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:attendance/network_dio/network_dio_sales.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/views/pages/sales/home_screen.dart';
import 'package:attendance/views/pages/sales/opportunities_list.dart';
import 'package:attendance/views/pages/sales/quote_list.dart';
import 'package:attendance/views/pages/sales/sales_orders.dart';
import 'package:attendance/views/pages/sales/settings_screen.dart';


class SalesDashboardController extends GetxController {
  RxInt currantIndex = 0.obs;

  List itemList = [
    {
      "icon": ImagePath.ic_home,
      "screen": HomeScreenSales(),
    },
    {
      "icon": ImagePath.opportunityIcn,
      "screen": OpportunitiesScreen(),
    },
    {
      "icon": ImagePath.salesOrderIcn,
      "screen": SalesOrder(),
    },
    {
      "icon": ImagePath.quoteIcn,
      "screen": QuoteListScreen(),
    },

    // {
    //   "icon": ImagePath.settingsIcn,
    //   "screen": SettingsScreen(),
    // },
  ];


  @override
  void onInit() {
    currantIndex = 0.obs;
    super.onInit();
  }
}
