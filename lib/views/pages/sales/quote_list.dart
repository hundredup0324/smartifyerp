// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/sales/quote_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/sales/quote_item.dart';
import 'package:attendance/views/pages/sales/create_quote.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

class QuoteListScreen extends StatefulWidget {
  QuoteListScreen({super.key});

  @override
  State<QuoteListScreen> createState() => _QuoteListScreenState();
}

class _QuoteListScreenState extends State<QuoteListScreen> {
  QuoteController quoteController = Get.put(QuoteController());
  ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void initState() {
    super.initState();
    quoteController.quoteList.clear();
    quoteController.isScroll.value = true;
    quoteController.currantPage.value = 1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initApi();
    });
    scrollController.addListener(() {
      print("maxScrollExtent ${scrollController.position.maxScrollExtent}");
      print("pixels ${scrollController.position.pixels}");
      print("isScroll ${quoteController.isScroll.value}");
      if (quoteController.isScroll.value == true &&
          scrollController.position.maxScrollExtent ==
              scrollController.position.pixels) {
        quoteController.currantPage.value += 1;
        quoteController.getQuotes(quoteController.currantPage.value);
      }
    });
  }

  initApi() async
  {
    quoteController.isLoading(true);

    try {
      List<dynamic> results = await Future.wait([quoteController.getRequestData(), quoteController.getQuotes(quoteController.currantPage.value)]);
      // Process the results of both API calls
      print('API 1 result: ${results[0]}');
      print('API 2 result: ${results[1]}');
    } catch (error) {
      print('Error: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.appBackgroundColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primaryColor,
          onPressed: () {
            quoteController.clearData();

            Get.to(() => CreateQuote(isUpdate: false,))?.then((value) {
              if (value == true) {
                quoteController.isScroll.value=true;
                quoteController.currantPage.value==1;
                quoteController.getQuotes(quoteController.currantPage.value);
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () => quoteController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Manage Quote".tr,
                                    style: pMedium24),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      Expanded(
                        child:quoteController.quoteList.isEmpty ? Center(
                          child: Text("Quote Not Found".tr,style: pMedium14,),
                        ) : ListView.builder(
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsetsDirectional.only(top: 10),
                                child: QuoteItemList(
                                    quoteData: quoteController.quoteList[index],onTap: () {
                                  print("tap QuoteJson${jsonEncode(quoteController.quoteList[index])}");

                                  quoteController.updateSetData(quoteController.quoteList[index]);
                                  Get.to(() => CreateQuote(isUpdate: true,quoteId: quoteController.quoteList[index].id.toString(),data: quoteController.quoteList[index],))?.then((value) {
                                    if (value == true) {
                                      quoteController.isScroll.value=true;
                                      quoteController.currantPage.value==1;
                                      quoteController.getQuotes(quoteController.currantPage.value);
                                    }
                                  });

                                },));
                          },
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: quoteController.quoteList.length,
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
