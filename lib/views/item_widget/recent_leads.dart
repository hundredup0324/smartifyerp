// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:attendance/core/model/home_response_lead.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/ui_text_style.dart';

class RecentLeads extends StatelessWidget {
  LatestLeads? latestLeads;
   RecentLeads({super.key,this.latestLeads});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),

        decoration: BoxDecoration(
          color: AppColor.cWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(latestLeads?.name.toString()??"",style: pMedium14,overflow: TextOverflow.ellipsis ,maxLines: 1),
                Text(latestLeads?.createdAt??"",style: pRegular12,overflow: TextOverflow.ellipsis ,maxLines: 1),


              ],
            ),

            Text(latestLeads!.status??"",style: pMedium14.copyWith(color: AppColor.yellow),overflow: TextOverflow.ellipsis ,maxLines: 1,),


          ],
        ),
      ),
    );
  }
}
