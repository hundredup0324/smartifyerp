// ignore_for_file: prefer_const_constructors
import 'package:flutter/services.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogTextField extends StatefulWidget {
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
  final int? maxLines;
  final List<TextInputFormatter>? listInputFormatter;

  final String? obscuringCharacter;

  const DialogTextField({
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
    this.maxLines,
    this.listInputFormatter,
    this.prefix,
    this.suffix,
    this.focusNode,
  }) : super(key: key);

  @override
  State<DialogTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<DialogTextField> {
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
        widget.labelText == '' ? verticalSpace(0) : verticalSpace(10),
        Center(
          child: Container(
            height: widget.maxLines != 1
                ? null
                : err == ''
                    ? 45
                    : 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: widget.controller,
              cursorColor: AppColor.greenColor,
              autofocus: widget.autofocus ?? false,
              focusNode: _focus,
              readOnly: widget.readOnly ?? false,
              validator: widget.validator,
              inputFormatters: widget.listInputFormatter??[],
              maxLines: widget.maxLines,
              onChanged: widget.onChanged,
              obscureText: widget.obscureText ?? false,
              obscuringCharacter: widget.obscuringCharacter ?? ' ',
              keyboardType: widget.keyboardType,
              style: pMedium12.copyWith(),

              decoration: InputDecoration(
                fillColor: AppColor.cWhite,
                filled: true,
                hintText: widget.hintText,
                suffixIcon: widget.suffix,
                suffixIconConstraints:
                    BoxConstraints(maxWidth: 45, minWidth: 42),
                hintStyle: pMedium12.copyWith(color: AppColor.cBorder),
                errorStyle: pMedium10.copyWith(color: AppColor.redColor),
                contentPadding: EdgeInsets.symmetric(vertical: widget.maxLines==1?0:16,horizontal: 16),

                // contentPadding: EdgeInsets.only(left: 16, right: 16),
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
                  borderSide: BorderSide(color: AppColor.redColor, width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.textFieldBg, width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.textFieldBg, width: 0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
