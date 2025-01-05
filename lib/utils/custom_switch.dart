import 'package:attendance/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0, // Set your desired height
      decoration: BoxDecoration(
        color: value ==true ? AppColor.themeGreenColor:Colors.transparent,
        borderRadius: BorderRadius.circular(15.0), // Half of the height to make it a circle
        border: Border.all(
          color: value ==true ? AppColor.themeGreenColor:Colors.transparent, // Set the border color
          width: 1.5,          // Set the border width
        ),
      ),
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: Colors.transparent,
        inactiveTrackColor: Colors.transparent,
        activeColor: AppColor.cWhite,
        inactiveThumbColor: AppColor.textColor,
      ),
    );
  }
}