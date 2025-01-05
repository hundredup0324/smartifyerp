import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/lead/home_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/input_decoration.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/item_widget/recent_leads.dart';
import 'package:attendance/views/pages/lead/bar_chart.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:attendance/views/widgets/loading_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LeadHomeController  homeController;

  late ZoomPanBehavior _zoomPanBehavior;
  late SelectionBehavior selectionBehavior;
  late CrosshairBehavior crosshairBehavior;

  @override
  void initState() {
    super.initState();
    homeController = Get.put(LeadHomeController ());
    _zoomPanBehavior =
        ZoomPanBehavior(enablePanning: true, zoomMode: ZoomMode.xy);
    selectionBehavior =
        SelectionBehavior(enable: true, selectedColor: AppColor.darkGreen);
    crosshairBehavior = CrosshairBehavior(
        activationMode: ActivationMode.doubleTap, enable: true);

    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    await homeController.fetchData();
  }

  Future<void> getChartData() async {
    Loader.showLoader();
    await homeController.getHomeScreenData();
    Loader.hideLoader();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: Obx(
        () => homeController.isLoading.value == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Dashboard",
                        style: pMedium24,
                      ),

                      verticalSpace(20),
                      Text(
                        "PipeLines",
                        style: pMedium14,
                      ),
                      verticalSpace(10),
                      DropdownButtonFormField(
                        value: homeController.selectedPipeLine.value,
                        items: homeController.pipeLineList
                            .map((element) => DropdownMenuItem(
                                onTap: () {
                                  homeController.selectedPipelinesId.value =
                                      element.id.toString();
                                  Prefs.setString(AppConstant.pipeLineId,
                                      element.id.toString());

                                  Prefs.setString(AppConstant.pipeLineName,
                                      element.name.toString());
                                },
                                value: element.name,
                                child: Text(
                                  element.name!,
                                  style: pMedium12,
                                )))
                            .toList(),
                        onChanged: (value) async {
                          homeController.selectedPipeLine.value =
                              value.toString();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            getChartData();
                          });
                        },
                        dropdownColor: AppColor.cBackGround,
                        icon: assetSvdImageWidget(
                          image: ImagePath.dropDownIcn,
                          colorFilter: ColorFilter.mode(
                            AppColor.cLabel,
                            BlendMode.srcIn,
                          ),
                        ),
                        isExpanded: true,
                        padding: EdgeInsets.zero,
                        hint: Text(
                          "Select Pipelines".tr,
                          textAlign: TextAlign.center,
                          style: pMedium12.copyWith(color: AppColor.cLabel),
                        ),
                        decoration: dropDownDecoration,
                      ),
                      verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:

                        Prefs.getString(AppConstant.userType)=="company"?
                        [
                          Expanded(child: Padding(padding: EdgeInsets.only(right: 8),child: dashboardCount(
                            name: "Total User",
                            imagePath: "asset/image/svg_image/ic_total_users.svg",
                            count: homeController.totalUsersCount.value
                                .toString(),
                          ),)),

                          Expanded(child: Padding(padding: EdgeInsets.only(left: 8),child: dashboardCount(
                            name: "Total Leads",
                            imagePath: "asset/image/svg_image/ic_total_leads.svg",
                            count: homeController.totalLeadsCount.value
                                .toString().tr,
                          ),))
                        ]:[
                          Expanded(child: Padding(padding: EdgeInsets.only(left: 8),child: dashboardCount(
                            name: "Total Leads",
                            imagePath: "asset/image/svg_image/ic_total_leads.svg",
                            count: homeController.totalLeadsCount.value
                                .toString().tr,
                          ),))
                        ],

                      ),
                      verticalSpace(20),
                      Text(
                        "Leads by Stage",
                        style: pMedium18,
                      ),
                      verticalSpace(10),
                      Container(height: 350, child: BarChart()),
                      verticalSpace(10),


                   homeController.latestLeads.isEmpty ? SizedBox(): Text(
                        "Recently Created Leads".tr,
                        style: pMedium18,
                      ),
                      verticalSpace(5),

                      ListView.builder(
                        itemBuilder: (context, index) {
                          var leadData = homeController.latestLeads[index];
                          return RecentLeads(
                            latestLeads: leadData,
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeController.latestLeads.length,
                        clipBehavior: Clip.none,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}


Widget dashboardCount({String? name ,String? imagePath,String? count})
{
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(
      color: AppColor.cWhite,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        assetSvdImageWidget(
            image:
            imagePath),
        verticalSpace(3),
        Text(
          name??"",
          style: pMedium16,
        ),
        verticalSpace(3),
        Text(count??"",
          style: pMedium16,
        ),
      ],
    ),
  );
}
