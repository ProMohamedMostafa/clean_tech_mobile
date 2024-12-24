import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final double radius = 4.0;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final Function(String?) validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final Function(String?)? onChanged;
  final Function? suffixPressed;
  final Widget? perfix;
  final List<TextInputFormatter>? inputFormatters;

  const DefaultTextField(
      {super.key,
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
      this.perfix,
      this.inputFormatters,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      validator: (value) {
        return validator(value);
      },
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      style: TextStyle(color: Colors.black, fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyles.font13Blackmedium,
        isDense: false,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  {
                    suffixPressed!();
                  }
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    suffixIcon,
                    color: Colors.black,
                  ),
                ),
              )
            : null,
        prefix: perfix,
        prefixStyle: TextStyles.font16BlackRegular,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: AppColor.secondaryColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: AppColor.secondaryColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: AppColor.secondaryColor,
            )),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.red),
        ),
        fillColor: Colors.white,
        filled: true,
        errorText: errorMsg,
      ),
    );
  }
}
