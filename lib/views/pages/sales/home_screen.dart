// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/sales/home_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/bar_chart.dart';
import 'package:attendance/views/pages/sales/meetings_screen.dart';
import 'package:attendance/views/widgets/common_button.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class HomeScreenSales extends StatefulWidget {
  HomeScreenSales({super.key});

  @override
  State<HomeScreenSales> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenSales> {
  SalesHomeController homeController = Get.put(SalesHomeController());

  @override
  void initState() {
    super.initState();
  homeController.getHomeScreenData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: AppBar(
        title: Align(
          // alignment: Alignment.centerLeft,
          child: Text(
            textAlign: TextAlign.center,
            "Dashboard".tr,
            style: pMedium24,
          ),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColor.appBackgroundColor,
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsetsDirectional.all(16),
          child: homeController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.cWhite),
                          child: BarChart(
                            charDataList: homeController.chartList.value,
                          )),
                      verticalSpace(20),
                      Row(
                        children: [
                          Expanded(
                              child: countContainer(
                                  Colors.green,
                                  "Total Opportunities",
                                  homeController
                                      .homeData.value.totalOpportunities
                                      .toString())),
                          horizontalSpace(8),
                          Expanded(
                              child: countContainer(
                                  Colors.lightBlueAccent,
                                  "Total \n SalesOrder",
                                  homeController.homeData.value.totalSalesorder
                                      .toString())),
                          horizontalSpace(8),
                          Expanded(
                              child: countContainer(
                                  Colors.grey,
                                  "Total \n Invoices",
                                  homeController.homeData.value.totalInvoice
                                      .toString())),
                        ],
                      ),
                      verticalSpace(25),
                      CommonButton(
                          title: "View All Meetings".tr,
                          onPressed: () {
                            Get.to(() => MeetingsScreen())?.then((value) => {});
                          }),
                      verticalSpace(15),
                      overViewContainer(
                        title: "Quote Overview".tr,
                        title1: "Open",
                        title2: "Cancelled",
                        cancelledCount: homeController
                            .homeData.value.quote?.quoteCancelledCount
                            .toString(),
                        cancelledPercentage: double.parse(homeController
                                .homeData
                                .value
                                .quote
                                ?.quoteCancelledPercentage ??
                            "0.00"),
                        openCount: homeController
                            .homeData.value.quote?.quoteOpenCount
                            .toString(),
                        openPercentage: double.parse(homeController
                                .homeData.value.quote?.quoteOpenPercentage ??
                            "0.00"),
                      ),
                      verticalSpace(10),
                      overViewContainer(
                        title: "Sales Order Overview".tr,
                        title1: "Open",
                        title2: "Cancelled",
                        cancelledCount: homeController
                            .homeData.value.salesOrder?.salesorderCancelledCount
                            .toString(),
                        cancelledPercentage: double.parse(homeController
                                .homeData
                                .value
                                .salesOrder
                                ?.salesorderCancelledPercentage ??
                            "0.00"),
                        openCount: homeController
                            .homeData.value.salesOrder?.salesorderOpenCount
                            .toString(),
                        openPercentage: double.parse(homeController.homeData
                                .value.salesOrder?.salesorderOpenPercentage ??
                            "0.00"),
                      ),
                      verticalSpace(10),
                      overViewContainer(
                        title: "Invoice Overview".tr,
                        title1: "Paid",
                        title2: "Not Paid",
                        cancelledCount: homeController
                            .homeData.value.invoice?.invoiceNotPaidCount
                            .toString(),
                        cancelledPercentage: double.parse(homeController
                                .homeData
                                .value
                                .invoice
                                ?.invoiceNotPaidPercentage ??
                            "0.00"),
                        openCount: homeController
                            .homeData.value.invoice?.invoicePaidCount
                            .toString(),
                        openPercentage: double.parse(homeController.homeData.value.invoice?.invoicePaidPercentage ??
                            "0.00"),
                      )
                    ],
                  ),
                ),
        ),
      ),
    ));
  }

  Widget overViewContainer(
      {String? title,
      String? openCount,
      String? cancelledCount,
      String? title1,
      String? title2,
      double? openPercentage,
      double? cancelledPercentage}) {
    return Container(
      padding: EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(
          color: AppColor.cWhite, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: pMedium14,
          ),
          verticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: CircleAvatar(
                        backgroundColor: AppColor.appBackgroundColor,
                        child:
                            assetSvdImageWidget(image: ImagePath.overViewIcn),
                      ),
                    ),
                    Center(
                      child: CustomPaint(
                        size: Size(64, 64), // You can adjust the size here
                        painter: _CircularProgressPainter(
                          firstCategoryValue: openPercentage ?? 0.00,
                          secondCategoryValue: cancelledPercentage ?? 0.00,
                          totalValue: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(20),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 8,
                          height: 8,
                          child: CircleAvatar(
                            backgroundColor: Color(0xFF0CAF60),
                          ),
                        ),
                        horizontalSpace(8),
                        Text(
                          "$openCount $title1 ($openPercentage%)".tr,
                          style: pRegular10,
                        ),
                      ],
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        SizedBox(
                          width: 8,
                          height: 8,
                          child: CircleAvatar(
                            backgroundColor: Color(0xFF3EC9D6),
                          ),
                        ),
                        horizontalSpace(8),
                        Text(
                          "$cancelledCount $title2 ($cancelledPercentage%)"
                              .tr,
                          style: pRegular10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(20),
        ],
      ),
    );
  }

  Widget countContainer(Color color, String title, String count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white, // Border color
              width: 2.0, // Border width
            ),
          ),
          child: CircleAvatar(
            backgroundColor: color,
            radius: 100,
            child: Center(
              child: Text(
                count,
                style: pSemiBold23.copyWith(color: AppColor.cWhite),
              ),
            ),
          ),
        ),
        verticalSpace(10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: pMedium14,
        )
      ],
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double firstCategoryValue;
  final double secondCategoryValue;
  final double totalValue;

  _CircularProgressPainter({
    required this.firstCategoryValue,
    required this.secondCategoryValue,
    required this.totalValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = -90.0;
    double firstSweepAngle = (firstCategoryValue / totalValue) * 360;
    double secondSweepAngle = (secondCategoryValue / totalValue) * 360;
    double remainingSweepAngle = 360 - firstSweepAngle - secondSweepAngle;

    Paint backgroundPaint = Paint()
      ..color = AppColor.appBackgroundColor
      ..strokeWidth = 5.03
      ..style = PaintingStyle.stroke;

    Paint firstCategoryPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.03
      ..style = PaintingStyle.stroke;

    Paint secondCategoryPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 5.03
      ..style = PaintingStyle.stroke;

    Paint remainingPaint = Paint()
      ..color = AppColor.appBackgroundColor
      ..strokeWidth = 5.03
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw background circle
    canvas.drawArc(rect, degreeToRadians(-90), degreeToRadians(360), false,
        backgroundPaint);

    // Draw first category
    canvas.drawArc(rect, degreeToRadians(startAngle),
        degreeToRadians(firstSweepAngle), false, firstCategoryPaint);

    // Update start angle for the second category
    startAngle += firstSweepAngle;

    // Draw second category
    canvas.drawArc(rect, degreeToRadians(startAngle),
        degreeToRadians(secondSweepAngle), false, secondCategoryPaint);

    // Update start angle for the remaining category
    startAngle += secondSweepAngle;

    // Draw remaining
    canvas.drawArc(rect, degreeToRadians(startAngle),
        degreeToRadians(remainingSweepAngle), false, remainingPaint);
  }

  double degreeToRadians(double degree) {
    return degree * 3.141592653589793 / 180;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
