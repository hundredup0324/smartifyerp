// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:attendance/utils/app_color.dart';

InputDecoration get dropDownDecoration => InputDecoration(
  fillColor: AppColor.cWhite,
  filled: true,
  contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: AppColor.textFieldBg, width: 0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: AppColor.textFieldBg, width: 0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: AppColor.redColor, width: 0),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: AppColor.textFieldBg, width: 0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: AppColor.textFieldBg, width: 0),
  ),
);