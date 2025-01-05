// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/sales/home_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:attendance/core/model/home_response_sales.dart';

class BarChart extends StatefulWidget {
  List<LineChartData>? charDataList;

  BarChart({super.key, this.charDataList});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  SalesHomeController homeController = Get.put(SalesHomeController());

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        enableAxisAnimation: true,
        plotAreaBorderWidth: 0,

        legend: Legend(isVisible: true),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
        ),
        primaryYAxis: NumericAxis(
            borderWidth: 0,
            majorGridLines: MajorGridLines(color: Colors.grey,width: 0.3),
            axisLine: AxisLine(width: 0, color: Colors.grey),
            majorTickLines: MajorTickLines(width: 0)),

        primaryXAxis: CategoryAxis(
          borderWidth: 0,
          autoScrollingMode: AutoScrollingMode.start,
          autoScrollingDelta: 5,
          maximumLabels: 100,
          majorGridLines: MajorGridLines(color: AppColor.cBorder,width: 0),
          axisLine: AxisLine(width: 0, color: Colors.transparent),
          interval: 5,
          majorTickLines: MajorTickLines(width: 0),
          axisBorderType: AxisBorderType.withoutTopAndBottom
        ),
        series: <ColumnSeries<LineChartData, String>>[
          ColumnSeries<LineChartData, String>(
              dataSource: homeController.chartList,
              name: 'Invoice',
              xValueMapper: (LineChartData data, _) => getGraphDate(data.day.toString()),
              yValueMapper: (LineChartData data, _) => double.parse(data.invoiceAmount.toString()),
              dataLabelSettings: DataLabelSettings(isVisible: false),
              color: Color.fromRGBO(255, 60, 112, 1)),
          ColumnSeries<LineChartData, String>(
              dataSource: homeController.chartList,
              xValueMapper: (LineChartData data, _) => getGraphDate(data.day.toString()),
              name: 'Quote',
              yValueMapper: (LineChartData data, _) => double.parse(data.quoteAmount.toString()),
              dataLabelSettings: DataLabelSettings(isVisible: false),
              color: Color.fromRGBO(65, 202, 214, 1)),

          ColumnSeries<LineChartData, String>(
              dataSource: homeController.chartList,
              xValueMapper: (LineChartData data, _) => getGraphDate(data.day.toString()),
              name: 'SalesOrder',
              yValueMapper: (LineChartData data, _) => double.parse(data.salesorderAmount.toString()),
              dataLabelSettings: DataLabelSettings(isVisible: false),
              color: Color.fromRGBO(69, 59, 133, 1)),

        ]);
  }
}
