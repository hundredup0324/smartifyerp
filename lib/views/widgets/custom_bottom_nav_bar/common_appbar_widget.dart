// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/ticket/helper.dart';
import 'package:attendance/utils/images.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

simpleAppBar({bool isBack = true, required String title}) {
  return PreferredSize(
    preferredSize: Size(Get.width, 70),
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                isBack == true
                    ? GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 43,
                          width: 43,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.cBorder),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Align(
                            child: assetSvdImageWidget(
                                image: DefaultImages.backIcn,
                                width: 11,
                                height: 10,
                                colorFilter: ColorFilter.mode(
                                    AppColor.cLabel, BlendMode.srcIn)),
                          ),
                        ),
                      )
                    : SizedBox(),
                horizontalSpace(isBack == true ? 15 : 0),
                Text(
                  title,
                  style: pMedium16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
