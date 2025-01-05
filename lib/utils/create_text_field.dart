// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:attendance/utils/input_decoration.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import '../views/widgets/common_space_divider_widget.dart';
import 'app_color.dart';


class CreateTextField extends StatefulWidget {
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
  final FormFieldValidator<String>? validator;

  final bool? readOnly;
  final String? labelText;
  final String? hintText;
  final String? prefix;
  final Widget? suffix;
  final String? obscuringCharacter;
  final int? maxLines;
  final int? maxLength;

  const CreateTextField({
    super.key,
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
    this.maxLines=1,
    this.maxLength,
  });

  @override
  State<CreateTextField> createState() => CreateTextFieldState();
}

class CreateTextFieldState extends State<CreateTextField> {
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
          style: pMedium14.copyWith(color: AppColor.cLabel),
        ),
        widget.labelText == ''
            ? verticalSpace(0)
            :  verticalSpace(8),
        Center(
          child: SizedBox(

            child: TextFormField(
              controller: widget.controller,
              cursorColor: AppColor.greenColor,
              autofocus: widget.autofocus ?? false,
              focusNode: _focus,
              readOnly: widget.readOnly ?? false,
              maxLines: widget.maxLines ?? 1,

              validator:widget.validator,
              onChanged: widget.onChanged,
              obscureText: widget.obscureText ?? false,
              obscuringCharacter: widget.obscuringCharacter ?? ' ',
              keyboardType: widget.keyboardType,
              style: pMedium14.copyWith(),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: pRegular12.copyWith(color: AppColor.cDarkGreyFont),
                errorStyle: pMedium12.copyWith(color: AppColor.redColor),

                fillColor: AppColor.cWhite,
                filled: true ,

                suffixIcon: widget.suffix,

                suffixIconConstraints:
                BoxConstraints(maxWidth: 45, minWidth: 42),
                contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10 ,vertical: widget.maxLines==1 ?0:12),
                prefixText: '  ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent,width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent,width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.cRed,width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent,width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                  BorderSide(color: Colors.transparent, width: 1),
                ),
              ),

            ),
          ),
        ) ,   err == ''
            ? SizedBox()
            : Text(err, style: pMedium12.copyWith(color: AppColor.cRedText)),
      ],
    );
  }
}
