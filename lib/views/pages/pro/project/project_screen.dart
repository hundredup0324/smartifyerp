// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:attendance/core/controller/project/project_controller.dart';
import 'package:attendance/core/model/GetUserListResponse.dart';
import 'package:attendance/core/model/project_list_response.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/pro/project/create_project.dart';
import 'package:attendance/views/pages/pro/project/project_detail.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

import 'project_list_item.dart';

class ProjectScreen extends StatefulWidget {
  ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  ProjectController projectController = Get.put(ProjectController());

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    projectController.currantPage.value = 1;
    projectController.isScroll.value = true;
    projectController.selectedIndex.value = 0;
    projectController.projectList.clear();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      projectController.getProjectList("All");
      projectController.getworkspaceUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.appBackgroundColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primaryColor,
          onPressed: () {
            projectController.userEmailList.clear();
            projectController.userController.clearAllSelection();
            projectController.nameController.clear();
            projectController.descriptionController.clear();

            showModalBottomSheet(
              context: context,
              backgroundColor: AppColor.cWhite,
              barrierColor: AppColor.cGreyOpacity,
              isScrollControlled: true,

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16))),
              builder: (context) {

                return CreateProject();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Project".tr,
                              style: pMedium24),
                        ],
                      )
                    ),


                  ],
                ),
                verticalSpace(20),
                _buildTabBar(),
                Expanded(
                  child: projectController.projectList.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: projectController.projectList.length,
                          itemBuilder: (context, index) {
                            var projectData =
                                projectController.projectList[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 5, right: 0, left: 0),
                              child: ProjectListItem(
                                projectModel: projectData,
                                onTap: () {
                                  Get.to(() => ProjectDetail(
                                        projectId: projectData.id.toString(),
                                      ))?.then((value) {
                                    if (value == true) {
                                      projectController.getProjectList(
                                          projectController.selectedIndex.value
                                              .toString());
                                    }
                                  });
                                },
                              ),
                            );
                          })
                      : dataNotFound("Data Not Found"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projectController.categoriesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => projectController.changeTab(
                projectController.categoriesList[index], index),
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                decoration: BoxDecoration(
                    color: projectController.selectedIndex.value == index
                        ? AppColor.themeGreenColor
                        : AppColor.unSelectedGreyColor,
                    borderRadius: BorderRadius.circular(48)),
                child: Center(
                  child: Text(
                    projectController.categoriesList[index].tr,
                    style: pMedium12.copyWith(color: AppColor.cWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
