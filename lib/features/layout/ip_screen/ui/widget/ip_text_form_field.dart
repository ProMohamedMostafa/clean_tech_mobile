import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class CustomIpTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool onlyRead;
  final String? label;

  const CustomIpTextFormField({
    super.key,
    required this.controller,
    required this.onlyRead,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: onlyRead,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        LengthLimitingTextInputFormatter(15),
      ],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "IP is Required";
        }

        final ipRegex = RegExp(
          r'^((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)\.){3}'
          r'(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)$',
        );

        if (!ipRegex.hasMatch(value.trim())) {
          return 'Enter a valid IP (e.g. 192.168.1.1)';
        }

        return null;
      },
      style: TextStyle(color: Colors.black, fontSize: 14.sp),
      decoration: _buildInputDecoration(),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      label: label != null ? Text(label!) : null,
      floatingLabelBehavior: label != null
          ? FloatingLabelBehavior.always
          : FloatingLabelBehavior.never,
      labelStyle: TextStyles.font14BlackSemiBold,
      isDense: true,
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildFocusBorder(),
      errorBorder: _buildErrorBorder(),
      hintText: '___.___.___.___',
      hintStyle: TextStyles.font12GreyRegular,
      fillColor: Colors.white,
      filled: true,
    );
  }

  OutlineInputBorder _buildBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      );

  OutlineInputBorder _buildFocusBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColor.primaryColor),
      );

  OutlineInputBorder _buildErrorBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Colors.red),
      );
}
