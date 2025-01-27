import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final bool onlyRead;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final Widget? perfixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? suffixPressed;
  final Color? color;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hint,
    this.validator,
    this.suffixIcon,
    this.perfixIcon,
    this.onChanged,
    this.suffixPressed,
    required this.onlyRead,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: onlyRead,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(color: Colors.black, fontSize: 14.sp),
      decoration: _buildInputDecoration(),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      isDense: true,
      suffixIcon: _buildSuffixIcon(),
      prefixIcon: _buildPerffixIcon(),
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildBorder(),
      errorBorder: _buildErrorBorder(),
      hintText: hint,
      hintStyle: TextStyles.font12GreyRegular,
      fillColor: Colors.white,
      filled: true,
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: color ?? AppColor.thirdColor,
      ),
    );
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
