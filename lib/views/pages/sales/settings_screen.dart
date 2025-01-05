import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/pages/sales/change_password.dart';
import 'package:attendance/core/controller/sales/setting_controller.dart';
import 'package:attendance/views/pages/sales/edit_profile_screen.dart';
import 'package:attendance/views/pages/sales/workspace_screen.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/app_constant.dart';
import 'package:attendance/utils/common_snackbar_widget.dart';
import 'package:attendance/utils/custom_switch.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/prefer.dart';
import 'package:attendance/views/pages/attendence/login_screen.dart';
import 'package:attendance/views/pages/attendence/menu_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SalesSettingController settingController = Get.put(SalesSettingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: AppColor.cBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(30),
              Container(
                width: 106.0,
                height: 106.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 3.0, // Set the border width
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: settingController.profileImage.value != "" ? CachedNetworkImageProvider(settingController.profileImage.value) : Image.asset(ImagePath.placeholder).image, // Add your image or other child widget here
                ),
              ),
              verticalSpace(5),
              Text(settingController.name.value,style: pSemiBold18.copyWith(color: AppColor.cWhite),textAlign: TextAlign.start),
              verticalSpace(8),
              Text(settingController.email.value, style: pRegular12.copyWith(color: AppColor.cWhite),textAlign: TextAlign.start),
              verticalSpace(20),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                    decoration: BoxDecoration(color: AppColor.cWhite),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        verticalSpace(30),

                        Text("Settings",style: pSemiBold23.copyWith(color: AppColor.cBlack),),
                        verticalSpace(15),
                        titleRowWidget(
                          icn: ImagePath.userEdit,
                          title: "Edit Profile".tr,
                          onTap: ()  {
                            Get.to(EditProfileScreen())?.then((value) {
                              if(value==true)
                              {
                                settingController.profileImage.value = Prefs.getString(AppConstant.profileImage);
                                settingController.name.value = Prefs.getString(AppConstant.userName);
                                settingController.email.value = Prefs.getString(AppConstant.emailId);
                              }
                            });
                          },
                        ),
                        verticalSpace(5),
                        // Divider(height: 1,color: AppColor.divider_Color,),

                        verticalSpace(8),
                        titleRowWidget(
                          icn: ImagePath.password,
                          title: "Change Password".tr,
                          onTap: () {
                            Get.to(() => ChangePasswordScreen());
                          },
                        ),
                        verticalSpace(5),
                        // Divider(height: 1,color: AppColor.divider_Color,),

                        verticalSpace(8),

                        // Divider(height: 1,color: AppColor.divider_Color,),

                        verticalSpace(8),
                        titleRowWidget(
                          icn: ImagePath.wokspace_arrow,
                          title: "workspace".tr,
                          onTap: () {
                            Get.to(() =>  workspaceScreen());
                          },
                        ),
                        verticalSpace(8),

                        // Divider(height: 1,color: AppColor.divider_Color,),
                        verticalSpace(8),
                        titleRowWidget(
                          icn: ImagePath.home,
                          title: "Menu".tr,
                          onTap: () {
                            Get.to(() =>  MenuScreen());
                          },
                        ),
                        // verticalSpace(8),
                        //
                        // titleRowWidget(
                        //   icn: ImagePath.deleteIcn,
                        //   title: "Delete Account".tr,
                        //   onTap: () {
                        //     if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                        //       commonToast(AppConstant.demoString);
                        //     } else {
                        //       _showDeleteAccountDialog();
                        //     }
                        //   },
                        // ),
                        verticalSpace(5),
                        // Divider(height: 1,color: AppColor.divider_Color,),
                        verticalSpace(35),
                        GestureDetector(
                          onTap: (){
                            if (Prefs.getBool(AppConstant.isDemoMode)) {
                              Get.offAll(() => LoginScreen());
                            } else {
                              settingController.logOutData();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height:50,
                            decoration: BoxDecoration(
                                color: AppColor.cDarkGrey,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.logout_outlined,color: AppColor.cRed,),
                                  horizontalSpace(10),
                                  Text("Logout", style: TextStyle(fontSize: 14, color: AppColor.cRed, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(40),
                      ],
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

  @override
  void initState() {
    super.initState();
    if (Prefs.getBool(AppConstant.isDemoMode) == true) {
      settingController.profileImage.value = "";
      settingController.name.value = "Alex";
      settingController.email.value = "alex.turner@example.com";
    } else {
      settingController.profileImage.value = Prefs.getString(AppConstant.profileImage);
      settingController.name.value = Prefs.getString(AppConstant.userName);
      settingController.email.value = Prefs.getString(AppConstant.emailId);
    }
  }


  void _showDeleteAccountDialog() {
    Get.defaultDialog(
      title: 'Delete Account'.tr,
      radius: 10,
      content: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        height: 120.0, // Set the height as per your requirement
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Are you sure you want to delete your account?'.tr,
              style: pRegular14,
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        backgroundColor: AppColor.darkGreen,
                        foregroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: AppColor.darkGreen, width: 1))),
                    onPressed: () {
                      Get.back(); // Close the dialog
                    },
                    child: Text('Cancel'.tr,
                        style: TextStyle(color: AppColor.cWhite)),
                  ),
                ),
                horizontalSpace(20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      settingController.deleteUser();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.transparent, width: 0))),
                    child: Text('Delete'.tr, style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  titleRowWidget({
    required String icn,
    required String title,
    Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
          height: 56,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Row(
              children: [
                SvgPicture.asset(icn, height: 22),
                horizontalSpace(10),
                Expanded(child: Text(title, style: pMedium16)),
                settingController.languageCode.value == 'ar'
                    ?  Icon(Icons.keyboard_arrow_left_outlined)
                    :  Icon(Icons.keyboard_arrow_right_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
