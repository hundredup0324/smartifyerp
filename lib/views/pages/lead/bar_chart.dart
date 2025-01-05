// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/lead/home_controller.dart';
import 'package:attendance/core/model/home_response_lead.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatefulWidget {

  BarChart({super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  LeadHomeController  homeController = Get.find();
  late ZoomPanBehavior _zoomPanBehavior;
  late SelectionBehavior selectionBehavior;

  @override
  void initState() {

    _zoomPanBehavior = ZoomPanBehavior(
        enableDoubleTapZooming: false,
        enablePanning: true,
        enablePinching: false,
        enableSelectionZooming: false,
        zoomMode: ZoomMode.xy
    );
    selectionBehavior = SelectionBehavior(enable: true, selectedColor: AppColor.darkGreen);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        enableAxisAnimation: true,
      onChartTouchInteractionMove: (ChartTouchInteractionArgs args) {
      },
      onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
      },
        plotAreaBorderWidth: 1,

          legend: Legend(isVisible: false),
          zoomPanBehavior: ZoomPanBehavior(
              enableDoubleTapZooming: false,
              enablePanning: true,
              enablePinching: false,
              enableSelectionZooming: false,
              zoomMode: ZoomMode.xy
          ),
          primaryYAxis: NumericAxis(
              borderWidth: 0,
              majorGridLines: MajorGridLines(color: Colors.grey,width: 1),
              minimum: 0,

              axisLine: AxisLine(width: 0, color: Colors.grey),
              majorTickLines: MajorTickLines(width: 0)),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            header: 'Lead by stage',
          ),

         primaryXAxis: CategoryAxis(
            borderWidth: 0,
            autoScrollingMode: AutoScrollingMode.start,
            autoScrollingDelta: 5,
            maximumLabels: 100,
            majorGridLines: MajorGridLines(color: AppColor.cBorder,width: 0),
            axisLine: AxisLine(width: 0, color: Colors.transparent),
            majorTickLines: MajorTickLines(width: 0),
            axisBorderType: AxisBorderType.withoutTopAndBottom
          ),

          series: <ColumnSeries<ChartData, String>>[
            ColumnSeries<ChartData, String>(
                dataSource: homeController.chartList,
                xValueMapper: (ChartData data, _) => data.name,
                yValueMapper: (ChartData data, _) => data.value,
                name: 'Leads',
                animationDuration: 0,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                selectionBehavior:SelectionBehavior(enable: true, selectedColor: AppColor.darkGreen),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                color: Color.fromRGBO(8, 142, 255, 1))
          ],
    );
  }
}
