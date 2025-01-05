// ignore_for_file: prefer_const_constructors


import 'package:attendance/utils/ui_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../views/widgets/common_space_divider_widget.dart';
import 'app_color.dart';


class CommonTextField extends StatefulWidget {
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

  const CommonTextField({
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
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
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
                style: pMedium16.copyWith(color: AppColor.cBorder),
              ),
        widget.labelText == ''
            ? verticalSpace(0)
            :  verticalSpace(15),
        Center(
          child: TextFormField(
            controller: widget.controller,
            cursorColor: Color(0xff289ed0),
            autofocus: widget.autofocus ?? false,
            focusNode: _focus,
            readOnly: widget.readOnly ?? false,
            validator: widget.validator,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText ?? false,
            obscuringCharacter: widget.obscuringCharacter ?? ' ',
            keyboardType: widget.keyboardType,
            style: pRegular16.copyWith(),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: pMedium14.copyWith(color: AppColor.cBorder),
              errorStyle: pMedium12.copyWith(color: AppColor.redColor),
              prefixIcon: widget.prefix == null
                  ? SizedBox()
                  : Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: SvgPicture.asset(widget.prefix ?? "")),
              suffixIcon: widget.suffix,
              // prefixIconConstraints: BoxConstraints(maxWidth: 55, minWidth: 54),
              suffixIconConstraints: BoxConstraints(maxWidth: 45, minWidth: 42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.cBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.cBorder),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.redColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.cBorder)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
