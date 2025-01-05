// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/utils/multitap.dart';
import 'package:attendance/core/controller/sales/meeting_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/sales/meeting_item.dart';
import 'package:attendance/views/pages/sales/create_meeting_screen.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen>  {
  MeetingController meetingController = Get.put(MeetingController());

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    meetingController.meetingList.clear();
    meetingController.isScroll.value = true;
    meetingController.currantPage.value = 1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      meetingController.getMeetingList(meetingController.currantPage.value);
      meetingController.getMeetingRequestData();
    });
    scrollController.addListener(() {
      if (meetingController.isScroll.value == true &&
          scrollController.position.maxScrollExtent ==
              scrollController.position.pixels) {
        meetingController.currantPage.value += 1;
        meetingController.getMeetingList(meetingController.currantPage.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: Text("Manage Meetings".tr,
              style: pMedium24.copyWith(
                color: AppColor.textColor,
              )),
          actions: [
            GestureDetector(
              onTap: () {
                meetingController.clearData();
                Get.to(() => CreateMeetings(
                  isUpdate: false,
                  meetingId: "",
                ))?.then((value) {
                  if(value ==true)
                    {
                      meetingController.isScroll.value = true;
                      meetingController.currantPage.value=1;
                      meetingController.meetingList.clear();
                      meetingController.getMeetingList(meetingController.currantPage.value);
                    }
                });
              },
              child: CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                radius: 16,
                child: Icon(
                  Icons.add,
                  size: 20,
                ),
              ),
            ),
            horizontalSpace(16)
          ],
          leading:  GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColor.cWhite,
        ),

        backgroundColor: AppColor.appBackgroundColor,
        body: Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [

              Obx(
                () => meetingController.isLoading.value == true
                    ? Expanded(child: Center(child: CircularProgressIndicator()))
                    : Expanded(
                        child: meetingController.meetingList.isEmpty ? Center(
                          child: Text("Meeting Not Found".tr,style: pMedium14,),
                        ) :

                        ListView.builder(
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsetsDirectional.only(top: 10),
                                child: MeetingItem(
                                  meetingData:
                                      meetingController.meetingList[index],
                                  onTap: () {
                                    meetingController.updateSetDataIntoUi(
                                        meetingController.meetingList[index]);

                                    Get.to(() => CreateMeetings(
                                            isUpdate: true,
                                            meetingId: meetingController
                                                .meetingList[index].id
                                                .toString()))!
                                        .then((value) {
                                      if (value == true) {
                                        meetingController.isScroll.value = true;
                                        meetingController.currantPage.value=1;
                                        meetingController.meetingList.clear();
                                        meetingController.getMeetingList(meetingController.currantPage.value);
                                      }else
                                        {
                                          meetingController.clearData();

                                        }
                                    });
                                  },
                                ));
                          },
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: meetingController.meetingList.length,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
