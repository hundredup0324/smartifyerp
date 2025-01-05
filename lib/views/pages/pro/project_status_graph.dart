// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendance/core/model/home_response.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../utils/prefer.dart';
import '../../../utils/ui_text_style.dart';

class ProjectStatusGraphScreen extends StatefulWidget {
  int? onGoing;
  int? finished;
  int? onHold;

  ProjectStatusGraphScreen(
      {super.key, this.onGoing, this.finished, this.onHold});

  @override
  State<ProjectStatusGraphScreen> createState() =>
      _ProjectStatusGraphScreenState();
}

class _ProjectStatusGraphScreenState extends State<ProjectStatusGraphScreen> {
  List<_ChartData> chartData = <_ChartData>[];

  @override
  void initState() {
    super.initState();

    print(
        " OnGoing ${widget.onGoing} \n OnHold ${widget.onHold}, Finished ${widget.finished}");
    if (Prefs.getBool(AppConstant.isDemoMode) == true) {
      chartData = [
        _ChartData('On Going', 50, AppColor.redStatusColor),
        _ChartData('OnHold', 20, AppColor.orangeColor),
        _ChartData('Finished', 30, AppColor.themeGreenColor),
      ];
    } else {
      chartData = [
        _ChartData('On Going', widget.onGoing ?? 0, AppColor.redStatusColor),
        _ChartData('OnHold', widget.onHold ?? 0, AppColor.orangeColor),
        _ChartData('Finished', widget.finished ?? 0, AppColor.themeGreenColor),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 200,
            child: SfCircularChart(
              series: <CircularSeries>[
                PieSeries<_ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    enableTooltip: true,
                    pointColorMapper: (_ChartData data, _) => data.color,
                    dataLabelSettings: DataLabelSettings(
                      builder: (data, point, series, pointIndex, seriesIndex) {
                        return Text(
                          "${chartData[pointIndex].y.toString()}%",
                          style: pMedium14.copyWith(color: AppColor.cWhite),
                        );
                      },
                      isVisible: true,
                    ))
              ],
            )),
      ],
    );
  }
}

class _ChartData {
  final String x;
  final int y;
  final Color color;

  _ChartData(this.x, this.y, this.color);
}
