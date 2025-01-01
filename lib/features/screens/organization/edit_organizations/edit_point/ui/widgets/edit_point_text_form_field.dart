import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class EditPointTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final double radius = 8.0;
  final TextInputType keyboardType;
  final Function(String?) validator;
  final Function(String?)? onChanged;

  const EditPointTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.keyboardType,
    required this.validator,
    this.focusNode,
    this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: TextFormField(
        validator: (value) {
          return validator(value);
        },
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.black, fontSize: 14.sp),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyles.font14BlackSemiBold,
          isDense: true,
          prefixStyle: TextStyles.font16BlackRegular,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(
                color: AppColor.thirdColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(
                color: AppColor.thirdColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(
                color: AppColor.thirdColor,
              )),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: Colors.red),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 11.sp,
            color: AppColor.thirdColor,
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
