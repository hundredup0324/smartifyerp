// ignore_for_file: prefer_const_constructors

import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:flutter/material.dart';
import 'common_space_divider_widget.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final FocusNode? focusNode;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool? autocorrect;
  final Function(String v)? validator;
  final bool? readOnly;
  final String? labelText;
  final String? hintText;
  final String? prefix;
  final Widget? suffix;
  final String? obscuringCharacter;

  const AuthTextField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.onChanged,
    this.obscuringCharacter,
    this.onTap,
    this.validator,
    this.labelText,
    this.hintText,
    this.prefix,
    this.suffix,
    this.focusNode,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final TextAlign textAlign = TextAlign.start;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
    setState(() {});
  }

  String err = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.labelText == ''
            ? verticalSpace(0)
            : Text(
                widget.labelText!,
                style: pRegular16.copyWith(color: AppColor.cLightGrey),
              ),
        widget.labelText == '' ? verticalSpace(0) : verticalSpace(15),
        Center(
          child: SizedBox(
            height: err == '' ? 45 : 50,
            child: TextFormField(
              controller: widget.controller,
              cursorColor: AppColor.cHintFont,
              autofocus: widget.autofocus ?? false,
              focusNode: _focus,
              readOnly: widget.readOnly ?? false,
              validator: (v) {
                print("vv======= $v");

                setState(() {
                  err = widget.validator!(v!);
                });
                print("======= $err");
                if (err == '') {
                  return null;
                } else {
                  return err;
                }
              },
              onChanged: widget.onChanged,
              obscureText: widget.obscureText ?? false,
              obscuringCharacter: widget.obscuringCharacter ?? ' ',
              keyboardType: widget.keyboardType,
              style: pMedium14.copyWith(
                  color: _focus.hasFocus
                      ? AppColor.cGreenFont
                      : AppColor.cLightGrey),
              decoration: InputDecoration(
                // fillColor:
                //     _focus.hasFocus ? AppColor.themeGreenColor : AppColor.cTransparent,
                // filled: true,
                hintText: widget.hintText,
                hintStyle: pMedium14.copyWith(color: AppColor.cDarkGreyFont),
                errorStyle: TextStyle(
                  height: 0,
                  fontSize: 0,
                  decorationThickness: 0,
                ),
                prefixIcon: widget.prefix == null
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: CircleAvatar(
                            radius: 18,
                            backgroundColor: _focus.hasFocus
                                ? AppColor.themeGreenColor
                                : AppColor.cWhite,
                            child: assetSvdImageWidget(image: widget.prefix)),
                      ),
                suffixIcon: widget.suffix,
                prefixIconConstraints: BoxConstraints(
                    maxWidth: widget.prefix == null ? 15 : 45,
                    minWidth: widget.prefix == null ? 15 : 43),
                suffixIconConstraints:
                    BoxConstraints(maxWidth: 45, minWidth: 42),
                contentPadding: EdgeInsets.only(left: 25),
                prefixText: '  ',
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
                  borderSide: BorderSide(color: AppColor.themeGreenColor, width: 1),
                ),
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
