// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:get/get.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_style.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final double? horizontal;
  final double? fontSize;
  final Function()? onPressed;
  final Color? bColor;
  final Color? btnColor;
  final Color? textColor;

  CommonButton({
    Key? key,
    this.title,
    this.height,
    this.width,
    this.onPressed,
    this.bColor,
    this.btnColor,
    this.textColor, this.fontSize, this.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? Get.width,
        // height: height ?? Get.height * 0.07,
        height: height ?? 45,
        decoration: BoxDecoration(
            color: btnColor ?? AppColor.themeGreenColor,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: bColor ?? AppColor.cTransparent)),
        padding: EdgeInsets.symmetric(horizontal: horizontal??Get.width * 0.1),
        child: Center(
          child: Text(
            title!,
            style: pBold14.copyWith(color: textColor ?? AppColor.cWhite,fontSize: fontSize??14),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
class CommonIconButton extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final double? horizontal;
  final double? radius;
  final String? iconData;
  final Function()? onPressed;
  final Color? bColor;
  final Color? btnColor;
  final Color? textColor;

  CommonIconButton({
    Key? key,
    this.title,
    this.height,
    this.width,
    this.onPressed,
    this.bColor,
    this.btnColor,
    this.iconData,
    this.radius,
    this.textColor, this.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? Get.width,
        // height: height ?? Get.height * 0.07,
        height: height ?? 45,
        decoration: BoxDecoration(
            color: btnColor ?? AppColor.themeGreenColor,
            borderRadius: BorderRadius.circular(radius ?? 35),
            border: Border.all(color: bColor ?? AppColor.cTransparent, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            assetSvdImageWidget(
              image: iconData!,
              height: 12,
              width: 12,
              colorFilter: ColorFilter.mode(textColor??AppColor.cWhite, BlendMode.srcIn)
            ),
            horizontalSpace(horizontal??10),
            Text(
              title!,
              style: pMedium12.copyWith(color: textColor ?? AppColor.cWhite),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
