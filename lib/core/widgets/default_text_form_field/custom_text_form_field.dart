import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final bool onlyRead;
  final TextEditingController controller;
  final String? hint;
  final bool? obscureText;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final Widget? perfixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? suffixPressed;
  final Color? color;
  final Color? hintColor;
  final String? label;
  final double? height;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.hint,
    this.validator,
    this.suffixIcon,
    this.perfixIcon,
    this.onChanged,
    this.suffixPressed,
    required this.onlyRead,
    this.color,
    this.hintColor,
    this.label,
    this.obscureText,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50.h,
      child: TextFormField(
        obscureText: obscureText ?? false,
        readOnly: onlyRead,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        validator: validator,
        onChanged: onChanged,
        style: TextStyle(color: Colors.black, fontSize: 14.sp),
        decoration: _buildInputDecoration(),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      label: label != null ? Text(label!) : null,
      floatingLabelBehavior: label != null
          ? FloatingLabelBehavior.always
          : FloatingLabelBehavior.never,
      labelStyle: TextStyles.font14BlackSemiBold,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      isDense: true,
      suffixIcon: _buildSuffixIcon(),
      prefixIcon: _buildPerffixIcon(),
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildFocusBorder(),
      errorBorder: _buildErrorBorder(),
      hintText: hint,
      hintStyle: TextStyles.font12GreyRegular.copyWith(color: hintColor),
      fillColor: Colors.white,
      filled: true,
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: color ?? Colors.grey[300]!,
      ),
    );
  }

  OutlineInputBorder _buildFocusBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(
          color: AppColor.primaryColor,
        ));
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: Colors.red),
    );
  }

  Widget? _buildSuffixIcon() {
    if (suffixIcon == null) return null;
    return IconButton(
      onPressed: suffixPressed,
      icon: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Icon(suffixIcon, color: AppColor.thirdColor),
      ),
    );
  }

  Widget? _buildPerffixIcon() {
    return perfixIcon;
  }
}
