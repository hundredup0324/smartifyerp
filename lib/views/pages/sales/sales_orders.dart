// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:attendance/core/controller/sales/sales_oreder_controller.dart';
import 'package:attendance/core/model/sales_order_response.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/sales/sales_order_item.dart';
import 'package:attendance/views/pages/sales/create_new_order.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

class SalesOrder extends StatefulWidget {
  SalesOrder({
    super.key,
  });

  @override
  State<SalesOrder> createState() => _SalesOrderState();
}

class _SalesOrderState extends State<SalesOrder> {
  SalesOrderController salesOrderController = Get.put(SalesOrderController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    salesOrderController.salesOrderList.clear();
    salesOrderController.currantPage.value = 1;
    salesOrderController.isScroll.value = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      apiCalls();
    });
    scrollController.addListener(() {
      if (salesOrderController.isScroll.value == true &&
          scrollController.position.maxScrollExtent ==
              scrollController.position.pixels) {
        salesOrderController.currantPage.value += 1;
        salesOrderController
            .getSalesOrderList(salesOrderController.currantPage.value);
      }
    });
  }

  apiCalls() async {
    salesOrderController.isLoading(true);
    await salesOrderController.getRequestData();
    await salesOrderController.getSalesOrderList(salesOrderController.currantPage.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.appBackgroundColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primaryColor,
          onPressed: () {
            salesOrderController.clearData();
            Get.to(() => CreateNewOrders(
              isUpdate: false,
              salesOrderId: "",
            ))!
                .then((value) {
              if (value == true) {
                salesOrderController.isScroll.value = true;
                salesOrderController.currantPage.value == 1;
                salesOrderController.getSalesOrderList(
                    salesOrderController.currantPage.value);
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () => salesOrderController.isLoading.value == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      vertical: 16, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Sales Order".tr,
                                    style: pMedium24),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      Expanded(
                        child: salesOrderController.salesOrderList.isEmpty
                            ? Center(
                                child: Text(
                                  "Sales Order Not Found".tr,
                                  style: pMedium14,
                                ),
                              )
                            : ListView.builder(
                                controller: scrollController,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding:
                                          EdgeInsetsDirectional.only(top: 10),
                                      child: SalesOrderListItem(
                                        salesData: salesOrderController
                                            .salesOrderList[index],
                                        onTap: () {
                                          salesOrderController.updateSetData(
                                              salesOrderController
                                                  .salesOrderList[index]);
                                          Get.to(() => CreateNewOrders(
                                                    isUpdate: true,
                                                    salesOrderId:
                                                        salesOrderController
                                                            .salesOrderList[
                                                                index]
                                                            .id
                                                            .toString(),
                                                  ))!
                                              .then((value) {
                                            if (value == true) {
                                              salesOrderController
                                                  .isScroll.value = true;
                                              salesOrderController
                                                      .currantPage.value ==
                                                  1;
                                              salesOrderController
                                                  .getSalesOrderList(
                                                      salesOrderController
                                                          .currantPage.value);
                                            }
                                          });
                                        },
                                      ));
                                },
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount:
                                    salesOrderController.salesOrderList.length,
                              ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
