// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_function_literals_in_foreach_calls, use_super_parameters

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:attendance/core/controller/ticket/home_controller.dart';
import 'package:attendance/core/model/dashboard_response.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:attendance/utils/constant.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/images.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

Widget buildAppTitleRow(String title, Function() menuFun, String date,
    {bool isHideMenu = false}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: pMedium24,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                date,
                style: pSemiBold16,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget profileDataWidget(
    {String? profileUrl,
    String? userName,
    String? email,
    String? totalTicket,
    Function()? onTap}) {
  return Card(
    color: AppColor.cBackGround,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColor.cBorder),
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColor.cBackGround,
                backgroundImage: NetworkImage(
                  profileUrl!,
                ),
              ),
              horizontalSpace(14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName!,
                    style: pMedium16,
                  ),
                  verticalSpace(4),
                  Text(
                    email!,
                    style: pRegular12.copyWith(color: AppColor.cDarkGreyFont),
                  )
                ],
              ),
            ],
          ),
          verticalSpace(18),
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: AppColor.themeGreenColor,
              borderRadius: BorderRadius.circular(26),
            ),
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                assetSvdImageWidget(
                  image: DefaultImages.circleTicketIcn,
                ),
                horizontalSpace(11),
                Text(
                  "You have  $totalTicket Tickets Open",
                  style: pMedium12.copyWith(color: AppColor.cWhite),
                ),
                horizontalSpace(11),
                assetSvdImageWidget(image: DefaultImages.nextIcn),
                horizontalSpace(32),
                Container(
                  width: 21,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColor.redColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "$totalTicket",
                      style: pSemiBold10.copyWith(color: AppColor.cWhite),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget support_ticketTitleWidget({
  String? title,
  String? subTitle,
}) {
  return Card(
    color: AppColor.cBackGround,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: AppColor.cBackGround,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColor.cBorder),
      ),
      padding: EdgeInsets.fromLTRB(10, 14, 16, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.width / 1.5,
            child: Row(
              children: [

                horizontalSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: pMedium12,
                      ),
                      verticalSpace(2.5),
                      Text(subTitle!,
                          style: pRegular12,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
          assetSvdImageWidget(
            image: DefaultImages.circleDropdownIcn,
            colorFilter: ColorFilter.mode(
              AppColor.cLabel,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget slidableActionWidget(
    {Function()? onTap, String? image, String? title, Color? color}) {
  return Expanded(
    flex: 1,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        decoration: BoxDecoration(
            color: color ?? AppColor.themeGreenColor,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(13))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            assetSvdImageWidget(
                image: image,
                width: 18,
                height: 18,
                colorFilter:
                    ColorFilter.mode(AppColor.cWhite, BlendMode.srcIn)),
            verticalSpace(8),
            Text(
              title!,
              style: pMedium8.copyWith(color: AppColor.cWhite),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ticketWidget({
  String? category,
  Color? categoryColor,
  String? title,
  String? status,
  String? codeNo,
  String? name,
  String? email,
  int? index,
  Function()? updateFun,
  Function()? deleteFun,
  Function()? replyFun,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 13),
    child: Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          slidableActionWidget(
              onTap: replyFun,
              image: DefaultImages.replyIcn,
              title: "Reply",
              color: AppColor.themeNavyBlueColor),
          Prefs.getString(AppConstant.role) == 'Agent'
              ? SizedBox()
              : slidableActionWidget(
                  onTap: deleteFun,
                  image: DefaultImages.deleteIcn,
                  title: "Delete",
                  color: AppColor.redColor),
        ],
      ),
      child: GestureDetector(
        onTap: updateFun,
        child: Stack(
          alignment: Alignment.topLeft,
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: status == "In Progress"
                          ? AppColor.cWhite
                          : status == "On Hold"
                              ? AppColor.cLightRed
                              : AppColor.cLightGreen,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                          color: status == "In Progress"
                              ? AppColor.cBorder
                              : status == "On Hold"
                                  ? AppColor.cRed
                                  : AppColor.themeGreenColor)),
                  padding: EdgeInsets.fromLTRB(14, 17, 14, 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width / 2.5,
                            child: Text(
                              title!.capitalizeFirst!,
                              style:
                                  pSemiBold16.copyWith(color: AppColor.cFont),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: status == "In Progress"
                                    ? AppColor.cLightYellow
                                    : status == "On Hold"
                                        ? AppColor.lightRedColor
                                        : AppColor.lightGreenColor,
                                borderRadius: BorderRadius.circular(16)),
                            padding: EdgeInsets.fromLTRB(7, 2, 14, 2),
                            child: Row(children: [
                              Icon(
                                  status == "In Progress"
                                      ? Icons.remove
                                      : status == "On Hold"
                                          ? Icons.close
                                          : Icons.check,
                                  color: status == "In Progress"
                                      ? AppColor.themeYellowColor
                                      : status == "On Hold"
                                          ? AppColor.cRed
                                          : AppColor.cGreenFont,
                                  size: 16),
                              Text(
                                status!,
                                style: pSemiBold8.copyWith(
                                    color: status == "In Progress"
                                        ? AppColor.themeYellowColor
                                        : status == "On Hold"
                                            ? AppColor.cRed
                                            : AppColor.cGreenFont),
                              )
                            ]),
                          )
                        ],
                      ),
                      verticalSpace(7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: status == "On Hold"
                                        ? AppColor.cBorder
                                        : AppColor.themeGreenColor,
                                  ),
                                ),
                                padding: EdgeInsets.fromLTRB(8, 7, 12, 7),
                                child: Text(
                                  codeNo!,
                                  style: pSemiBold10.copyWith(
                                    color: AppColor.cFont,
                                  ),
                                ),
                              ),
                              horizontalSpace(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name!.capitalizeFirst!,
                                    style: pSemiBold10.copyWith(
                                        color: AppColor.cDarkGreyFont),
                                  ),
                                  Text(
                                    email!,
                                    style: pRegular10.copyWith(
                                        color: AppColor.cDarkGreyFont),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                                color: AppColor.cDarkGreyFont,
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                                child: assetSvdImageWidget(
                                  width: 16,
                                  height: 16,
                              image: DefaultImages.edit,
                              colorFilter: ColorFilter.mode(AppColor.cWhite, BlendMode.srcIn)
                            )),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Positioned(
              left: 25,
              child: category == ''
                  ? SizedBox()
                  : Container(
                      decoration: BoxDecoration(
                        color: AppColor.cWhite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: categoryColor!
                            // color: status == "In Progress"
                            //     ? AppColor.cBlue
                            //     : status == "On Hold"
                            //         ? AppColor.cPurple
                            //         : AppColor.pinkColor,
                            ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        category!,
                        style: pSemiBold8.copyWith(color: categoryColor
                            // color: status == "In Progress"
                            //     ? AppColor.cBlue
                            //     : status == "On Hold"
                            //         ? AppColor.cPurple
                            //         : AppColor.pinkColor,
                            ),
                      ),
                    ),
            )
          ],
        ),
      ),
    ),
  );
}





class AnalyticsGraph extends StatefulWidget {

  AnalyticsGraph({super.key});

  @override
  State<AnalyticsGraph> createState() => _AnalyticsGraphState();
}

class _AnalyticsGraphState extends State<AnalyticsGraph> {
  TicketHomeController homeController=Get.find();


  @override
  void initState() {
    if (Prefs.getBool(AppConstant.isDemoMode) == true) {
      homeController.yearWiseChart.value = [
        YearWiseChart(name: 'Jan', value: 3),
        YearWiseChart(name: 'Feb', value: 0),
        YearWiseChart(name: 'March', value: 5),
        YearWiseChart(name: 'April', value: 2),
        YearWiseChart(name: 'May', value: 0),
        YearWiseChart(name: 'June', value: 2),
        YearWiseChart(name: 'July', value: 1),
        YearWiseChart(name: 'Aug', value: 0),
        YearWiseChart(name: 'Sept', value: 6),
        YearWiseChart(name: 'Oct', value: 2),
        YearWiseChart(name: 'Nov', value: 0),
        YearWiseChart(name: 'Dec', value: 3),
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColor.cBorder)),
      child: Column(
        children: [
          Expanded(
            child: SfCartesianChart(
              enableAxisAnimation: true,
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                borderWidth: 0,
                autoScrollingMode: AutoScrollingMode.start,
                autoScrollingDelta: 10,
                maximumLabels: 100,
                majorGridLines: MajorGridLines(color: AppColor.cBorder),
                axisLine: AxisLine(width: 0, color: AppColor.cTransparent),
                interval: 1,
                majorTickLines: MajorTickLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                  borderWidth: 0,
                  interval: 1,
                  majorGridLines: MajorGridLines(color: AppColor.cTransparent),
                  axisLine: AxisLine(width: 0, color: AppColor.cTransparent),
                  majorTickLines: MajorTickLines(width: 0)),
              legend: Legend(isVisible: false),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: AppColor.cBackGround,
                activationMode: ActivationMode.singleTap,
                canShowMarker: true,
                builder: (data, point, series, pointIndex, seriesIndex) {
                  var order = homeController.yearWiseChart[pointIndex].value;
                  return Container(
                    // width: 119,
                    // height: 54,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.cBorder),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Tickets",
                          style: pSemiBold12.copyWith(color: AppColor.cDarkGreyFont),
                        ),
                        verticalSpace(8),
                        Text(
                          "\$$order",
                          style: pSemiBold12.copyWith(
                            color: seriesIndex == 1 ? AppColor.cRedText : AppColor.cGreenFont,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              zoomPanBehavior: ZoomPanBehavior(
                enablePanning: true,
              ),
              series: [
                SplineSeries<YearWiseChart, String>(
                  dataSource: homeController.yearWiseChart,
                  xValueMapper: (YearWiseChart sales, _) => sales.name,
                  yValueMapper: (YearWiseChart sales, _) => sales.value,
                  color: AppColor.themeGreenColor,
                  width: 2,
                  dataLabelSettings: DataLabelSettings(isVisible: false),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CategoriesGraph extends StatefulWidget {

  CategoriesGraph({Key? key}) : super(key: key);

  @override
  State<CategoriesGraph> createState() => _CategoriesGraphState();
}

class _CategoriesGraphState extends State<CategoriesGraph> {
  TicketHomeController homeController=Get.find();

  @override
  void initState() {
    if (Prefs.getBool(AppConstant.isDemoMode) == true) {
      homeController.chartData.value = [
        ChartDatas(name: 'Bug', value: 3,color:  "#060ba7"),
        ChartDatas(name: 'Support', value: 3, color: "#eb0a0a"),
        ChartDatas(name: 'New Installation',value:  2,color:"#11e30d"),
      ];
    }

    // else {
    //   chartData.addAll(homeController.chartData);
    // }

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: AppColor.cBorder)),
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 25),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: SfCircularChart(
              series: <CircularSeries>[
                DoughnutSeries<ChartDatas, String>(
                    dataSource:  homeController.chartData,
                    xValueMapper: (ChartDatas data, _) => data.name,
                    yValueMapper: (ChartDatas data, _) => data.value,
                    pointColorMapper: (ChartDatas data, _) => HexColor(data.color??"000000"),
                    explode: true,
                    // explodeIndex: 1,
                    // dataLabelMapper: (_ChartData data, _) => data.x,
                    pointRenderMode: PointRenderMode.segment,
                    dataLabelSettings: DataLabelSettings(
                        builder:
                            (data, point, series, pointIndex, seriesIndex) {
                          return Text(
                            homeController.chartData[pointIndex].value.toString(),
                            style: pMedium10,
                          );
                        },
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                        labelAlignment: ChartDataLabelAlignment.outer))
              ],
            ),
          ),

          Column(
            children: platFormData(),
          ),
        ],
      ),
    );
  }

  List<Widget> platFormData() {
    List<Widget> data = [];
    for (int i = 0; i <  homeController.chartData.length; i++) {
      data.add(browserGraphDetail(title: homeController.chartData[i].name??"", total: homeController.chartData[i].value.toString(), color: HexColor(homeController.chartData[i].color!)));
    }
    return data;
  }

  Widget browserGraphDetail(
      {required String title, required String total, required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.cBorder)),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 3, backgroundColor: color),
                horizontalSpace(9),
                Text(
                  title,
                  style: pMedium10.copyWith(color: color),
                ),
              ],
            ),
            Text(
              total,
              style: pMedium12.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}


