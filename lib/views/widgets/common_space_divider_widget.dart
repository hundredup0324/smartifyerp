import 'package:attendance/utils/ui_text_style.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';


Widget verticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget horizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget horizontalDivider({Color? color}) {
  return Divider(
    color: color ?? AppColor.cDivider,
    thickness: 1,
  );
}


Widget dataNotFound(String message){
  return Center(child: Text(message,style: pMedium18.copyWith(color: AppColor.cBlack),textAlign: TextAlign.center));
}
