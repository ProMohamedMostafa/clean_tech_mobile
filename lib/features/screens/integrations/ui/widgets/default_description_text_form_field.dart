import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class DefaultDescriptionTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const DefaultDescriptionTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        expands: true,
        validator: validator,
        onChanged: onChanged,
        style: TextStyle(color: Colors.black, fontSize: 14.sp),
        decoration: _buildInputDecoration(),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildBorder(),
      errorBorder: _buildErrorBorder(),
      contentPadding: const EdgeInsets.all(5),
      isDense: true,
      hintText: hint,
      hintStyle: TextStyles.font14GreyRegular,
      fillColor: Colors.white,
      filled: true,
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: Colors.grey),
    );
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: Colors.red),
    );
  }
}
