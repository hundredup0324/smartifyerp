// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print, prefer_const_constructors_in_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:attendance/core/model/ticket_list_response.dart';
import 'package:attendance/utils/colors.dart';

import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/images.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/pages/ticket/tickets_screen/reply_ticket_screen.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_button.dart';
import 'package:attendance/views/widgets/common_snak_bar_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:attendance/core/controller/ticket/tickets_controller.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/pages/ticket/home_screen/home_screen_widget.dart';

import 'add_ticket_screen.dart';

class TicketsScreen extends StatefulWidget {

  TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  TicketController ticketController = Get.put(TicketController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ticketController.ticketList.clear();
    ticketController.currantPage.value = 1;
    ticketController.isScroll.value = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ticketController.getTickets(ticketController.currantPage.value);
    });
    scrollController.addListener(() {
      if (ticketController.isScroll.value == true &&
          scrollController.position.maxScrollExtent ==
              scrollController.position.pixels) {
        ticketController.currantPage.value += 1;
        ticketController.getTickets(ticketController.currantPage.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
          ticketController.selectedAccountType("Custom");
          showModalBottomSheet(
            context: context,
            backgroundColor: AppColor.cBackGround,
            barrierColor: AppColor.cBlackOpacity,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            builder: (context) {
              return AddTicketScreen(
                isUpdate: false,
                ticketID: '',
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                print(ticketController.ticketList.length);
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Tickets",
                                style: pMedium24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        itemCount: ticketController.ticketList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          TicketData ticketData = ticketController.ticketList[index];
                          return ticketWidget(
                            index: index,
                            title: ticketData.subject,
                            name: ticketData.name,
                            email: ticketData.email,
                            codeNo: ticketData.ticketId,
                            category: ticketData.categoryName,
                            status: ticketData.status,
                            categoryColor: HexColor(ticketData.color!),
                            deleteFun: () {
                              if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                                commonToast(AppConstant.demoString);
                              } else {
                                ticketController
                                    .deleteTicket(ticketData.id.toString());
                              }
                            },
                            replyFun: () {
                              print("${ticketData.id.toString()}----");
                              if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                                commonToast(AppConstant.demoString);
                              } else {
                                //api
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: AppColor.cBackGround,
                                  barrierColor: AppColor.cBlackOpacity,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  builder: (context) {
                                    return ReplayTicketsScreen(
                                      ticketID: ticketData.id.toString(),
                                    );
                                  },
                                );
                              }
                            },
                            updateFun: () {
                              print("${ticketData.id.toString()}----");
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: AppColor.cBackGround,
                                barrierColor: AppColor.cBlackOpacity,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                builder: (context) {
                                  return AddTicketScreen(
                                    isUpdate: true,
                                    accountType:
                                    ticketData.accountType.toString(),
                                    ticketID: ticketData.id.toString(),
                                    email: ticketData.email,
                                    name: ticketData.name,
                                    status: ticketData.status,
                                    categoryName: ticketData.categoryName,
                                    subject: ticketData.subject,
                                    description: ticketData.description,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    verticalSpace(16),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );

  }

  Widget ticketDataWidget({
    required String ticketId,
    required String name,
    required String email,
    required Function() function,
  }) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: Get.width,
        color: AppColor.cBackGround,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 80,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.themeGreenColor)),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        ticketId,
                        style: pSemiBold10.copyWith(),
                      ),
                    )),
                horizontalSpace(10),
                Text(
                  name.capitalizeFirst!,
                  style: pMedium8.copyWith(
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            Text(
              email,
              style:
                  pMedium8.copyWith(fontSize: 9, color: AppColor.cDarkGreyFont),
            ),
          ],
        ),
      ),
    );
  }

  Widget ticketTitleRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
                width: 80,
                child: Text(
                  'Ticket Id',
                  style: pRegular12.copyWith(color: AppColor.cDarkGreyFont),
                )),
            horizontalSpace(10),
            Text(
              'Name',
              style: pRegular12.copyWith(color: AppColor.cDarkGreyFont),
            ),
          ],
        ),
        Text(
          'Email',
          style: pRegular12.copyWith(color: AppColor.cDarkGreyFont),
        ),
      ],
    );
  }
}
