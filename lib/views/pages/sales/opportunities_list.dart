// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:attendance/core/controller/sales/oppotunities_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/sales/opportunities_item.dart';
import 'package:attendance/views/pages/sales/create_oppertunities.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

class OpportunitiesScreen extends StatefulWidget {
   OpportunitiesScreen({super.key});

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  OpportunitiesController opController = Get.put(OpportunitiesController());
  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    opController.opportunityList.clear();
    opController.currantPage.value = 1;
    opController.isScroll.value = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     initApi();
    });
    scrollController.addListener(() {
      print("maxScrollExtent ${scrollController.position.maxScrollExtent}");
      print("pixels ${scrollController.position.pixels}");
      print("isScroll ${opController.isScroll.value}");
      if (opController.isScroll.value == true && scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        opController.currantPage.value += 1;
        opController.getOpportunities(opController.currantPage.value);
      }
    });
  }

  initApi () async
  {
    opController.isLoading(true);
    await opController.requestData();
    await opController.getOpportunities(opController.currantPage.value);
  }
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.appBackgroundColor,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            onPressed: () {
              opController.clearData();
              Get.to(()=>CreateOpportunities(isUpdate: false,))!.then((value) {
                if(value== true)
                {
                  opController.isScroll.value=true;
                  opController.currantPage.value=1;
                  opController.getOpportunities(opController.currantPage.value);
                }
              });
            },
            child: const Icon(Icons.add),
          ),
          body: opController.isLoading.value == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex:1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Opportunities".tr,
                                    style: pMedium24),
                              ],
                            ),
                          ),

                        ],
                      ),
                      verticalSpace(20),
                      Expanded(
                        child: opController.opportunityList.isEmpty ? Center(
                          child: Text("Opportunity Not Found".tr,style: pMedium14,),
                        ) :ListView.builder(
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsetsDirectional.only(top: 10),
                                child: OpportunitiesItem(data: opController.opportunityList[index],onTap: (){
                                  opController.updateData(opController.opportunityList[index]);
                                  Get.to(()=>CreateOpportunities(isUpdate: true,opportunityId: opController.opportunityList[index].id.toString(),))!.then((value) {
                                    print("value $value");
                                    if(value== true)
                                    {
                                      opController.isScroll.value=true;
                                      opController.currantPage.value=1;
                                      opController.getOpportunities(opController.currantPage.value);

                                    }

                                  });
                                },));
                          },
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: opController.opportunityList.length,
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
