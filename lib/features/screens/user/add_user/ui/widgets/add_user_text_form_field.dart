import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class AddUserTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final Function(String?) validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final Function(String?)? onChanged;
  final Function? suffixPressed;
  final Widget? prefix;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  const AddUserTextFormField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    required this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.suffixPressed,
    this.prefix,
    this.prefixIcon,
    this.inputFormatters,
    this.hint,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      validator: (value) {
        return validator(value);
      },
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      style: TextStyle(color: Colors.black, fontSize: 14.sp),
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: TextStyles.font12GreyRegular,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  if (suffixPressed != null) suffixPressed!();
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(suffixIcon, color: AppColor.thirdColor),
                ),
              )
            : null,
        prefix: prefix,
        prefixIcon: prefixIcon,
        prefixStyle: TextStyles.font16BlackRegular,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: AppColor.thirdColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: AppColor.thirdColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: AppColor.thirdColor,
            )),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
        fillColor: Colors.white,
        filled: true,
        errorText: errorMsg,
      ),
    );
  }
}
