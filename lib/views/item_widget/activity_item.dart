// ignore_for_file: sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:attendance/core/model/lead_detail_response.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';

class ActivityItem extends StatelessWidget
{
  LeadActivity? activityData;

   ActivityItem({super.key,this.activityData});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            assetSvdImageWidget(image: ImagePath.icnActivity),
            horizontalSpace(12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activityData?.remark.toString()??"",style: pMedium14,maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: true,),
                  Text(activityData?.time??"",style: pRegular12.copyWith(color: AppColor.cGrey ),),
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: AppColor.cWhite,
          borderRadius: BorderRadius.circular(10),

        ),
      ),
    );


  }

}