import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.sw, vertical: 18.sh),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(30.sw),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1.7,
              ),
              borderRadius: BorderRadius.circular(30.sw),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kErrorColor,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(30.sw),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kErrorColor,
            width: 1.7,
          ),
          borderRadius: BorderRadius.circular(30.sw),
        ),
        hintStyle: hintStyle,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: backgroundColor ?? Colors.transparent,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: hintStyle,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
