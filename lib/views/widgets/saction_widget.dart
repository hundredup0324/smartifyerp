
// ignore_for_file: sort_child_properties_last, prefer_const_constructors


import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionWidget extends StatelessWidget {
  final String imagePath;
  final Color startColor;
  final Color endColor;
  final String count;
  final String name;

  final VoidCallback onPressed;

  const SectionWidget(
      {Key? key,
      required this.imagePath,
      required this.startColor,
      required this.endColor,
      required this.name,
      required this.count,
      required this.onPressed}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      padding: EdgeInsets.all(13),

      child: Column(
        children: [
         SvgPicture.asset(imagePath,width: 54,height: 54),
          SizedBox(height: 16),
          Text(count, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
          SizedBox(height: 8),
          Text(name, style: pSemiBold14.copyWith(color: AppColor.cWhite),maxLines: 1,overflow: TextOverflow.ellipsis),
        ],
      ),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.68, -0.73),
          end: Alignment(-0.68, 0.73),
          colors: [startColor, endColor],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
