// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/ticket/knowledgebase_controller.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/pages/ticket/knowledgebase/knowledgebase_detail.dart';

class KnowledgeBaseScreen extends StatefulWidget {
  KnowledgeBaseScreen({super.key});

  @override
  State<KnowledgeBaseScreen> createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {

  final KnowledgeBaseController _controller = Get.put(KnowledgeBaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.cBackGround,
        appBar: AppBar(
          backgroundColor: AppColor.cBackGround,
          title: Text('Knowledge Base',style: pMedium24,),
          centerTitle: true,
        ),
        body: Obx(()=> _controller.knowLedgeList.isNotEmpty?
                  ListView.builder(
        padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
        itemBuilder: (context, index) {
          var data = _controller.knowLedgeList[index];
          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: Card(
              elevation: 1.0,
              clipBehavior: Clip.none,
              color: AppColor.cWhite,
              child: GestureDetector(
                onTap: (){
                  Get.to(KnowledgeBaseDetail(title: _controller.knowLedgeList[index].title,description: _controller.knowLedgeList[index].description,));
                },
                child: ListTile(
                  title: Text(data.title.toString(),style: pMedium16.copyWith(color: AppColor.cBlack),),
                  trailing: Icon(Icons.arrow_forward_ios_outlined,color: AppColor.cBlack,),
                ),
              ),
            ),
          );
        },
        itemCount: _controller.knowLedgeList.length,
        shrinkWrap: true,
                  ) :Center(
        child: Text(
          "Data Not Found".tr,
          style: pRegular16.copyWith(
              color: AppColor.cText),
        ),
                  ),
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getKnowledgeData();
    });
  }
}
