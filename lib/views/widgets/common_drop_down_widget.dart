// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';


class CommonDropdownButtonWidget extends StatefulWidget {
  final String? value;
  final String? labelText;
  final Widget? widget;
  final List? list;
  final ValueChanged? onChanged;
  final FormFieldValidator? validator;
  final Color? fontColor;
  final Color? filledColor;
  final String hint;
  final bool? isExpanded;

  const CommonDropdownButtonWidget(
      {super.key,
      this.hint = '',
      this.value,
      this.labelText,
      this.widget,
      this.list,
      this.onChanged,
      this.validator,
      this.fontColor,
      this.filledColor,
      this.isExpanded});

  @override
  State<CommonDropdownButtonWidget> createState() =>
      _CommonDropdownButtonWidgetState();
}

class _CommonDropdownButtonWidgetState
    extends State<CommonDropdownButtonWidget> {
  String err = '';
  @override
  Widget build(BuildContext context) {

    print("listItem ${widget.list}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText == ''
            ? SizedBox(
                height: 0,
              )
            : Text(
                widget.labelText!,
                style: pMedium12,
              ),
        widget.labelText == '' ? verticalSpace(0) : verticalSpace(8),
        SizedBox(
          height: 44,
          child: DropdownButtonFormField(
            value: widget.value,
            items: widget.list!.map((data) {
              return DropdownMenuItem(
                value: data,
                child: Text(
                  data,
                  style: pMedium12.copyWith(
                    color: widget.fontColor ?? AppColor.cLabel,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            dropdownColor: AppColor.cBackGround,
            icon: assetSvdImageWidget(
              image:  ImagePath.dropDownIcn,
              colorFilter: ColorFilter.mode(
                AppColor.cLabel,
                BlendMode.srcIn,
              ),
            ),
            onChanged: widget.onChanged!,
            validator: (v) {
              setState(() {
                err = widget.validator!(v)!;
              });
              print("======= $err");
              if (err == '') {
                return null;
              } else {
                return err;
              }
            },
            style: pMedium12.copyWith(
              color: AppColor.cLabel,
            ),
            isExpanded: widget.isExpanded??false,
            decoration: InputDecoration(
              fillColor: widget.filledColor ?? Colors.transparent,
              filled: true,
              hintText: widget.hint,
              hintStyle: pMedium12.copyWith(color: AppColor.cHintFont),
              contentPadding: EdgeInsets.only(left: 16,right: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.textFieldBg,width: 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.textFieldBg,width: 0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.redColor,width: 0),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.textFieldBg,width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: AppColor.textFieldBg, width: 0),
              ),
            ),
          ),
        ),
        err == ''
            ? SizedBox()
            : Text(
                err,
                style: pMedium12.copyWith(color: AppColor.cRedText),
              ),
      ],
    );
  }
}

class CommonHintDropdownWidget extends StatefulWidget {
  final String? value;
  final String? labelText;
  final Widget? widget;
  final String hint;

  final List? list;
  final ValueChanged? onChanged;
  final FormFieldValidator? validator;
  final Color? fontColor;
  final Color? filledColor;

  const CommonHintDropdownWidget(
      {super.key,
      this.value,
      this.labelText,
      this.widget,
      this.list,
      this.onChanged,
      this.validator,
      required this.hint,
      this.fontColor,
      this.filledColor});

  @override
  State<CommonHintDropdownWidget> createState() =>
      _CommonHintDropdownWidgetState();
}

class _CommonHintDropdownWidgetState extends State<CommonHintDropdownWidget> {
  String err = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText == ''
            ? SizedBox(
                height: 0,
              )
            : Text(
                widget.labelText!,
                style: pRegular12,
              ),
        widget.labelText == '' ? verticalSpace(0) : verticalSpace(6),
        SizedBox(
          height: 44,
          child: DropdownButtonFormField(
            // value: widget.value,
            items: widget.list!.map((data) {
              return DropdownMenuItem(
                value: data,
                child: Text(
                  data,
                  style: pMedium12.copyWith(color: widget.fontColor),
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
            dropdownColor: AppColor.cBackGround,
            icon: assetSvdImageWidget(
              image: ImagePath.dropDownIcn,
              colorFilter: ColorFilter.mode(
                AppColor.cLabel,
                BlendMode.srcIn,
              ),
            ),
            onChanged: widget.onChanged!,
            style: pRegular14.copyWith(color: AppColor.cLabel),
            borderRadius: BorderRadius.circular(6),
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.filledColor ?? Colors.transparent,
              hintText: widget.hint,
              hintStyle: pRegular14.copyWith(color: AppColor.cHintFont),
              // errorText: '',
              // errorStyle: TextStyle(
              //   height: 0,
              //   fontSize: 0,
              //   decorationThickness: 0,
              // ),
              contentPadding: EdgeInsets.only(left: 25, right: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide(color: AppColor.cBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide(color: AppColor.cBorder),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide(color: AppColor.cRed),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide(color: AppColor.cBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide:
                    BorderSide(color: AppColor.themeGreenColor, width: 1),
              ),
            ),
          ),
        ),
        err == ''
            ? SizedBox()
            : Text(err, style: pMedium12.copyWith(color: AppColor.cRedText)),
      ],
    );
  }
}
