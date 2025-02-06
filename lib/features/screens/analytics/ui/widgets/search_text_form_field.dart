import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final double radius = 20.0;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final Function? suffixPressed;
  final Widget? perfix;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;

  const SearchTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.prefixIcon,
      this.validator,
      this.focusNode,
      this.errorMsg,
      this.onChanged,
      this.suffixPressed,
      this.perfix,
      this.inputFormatters,
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly!,
      inputFormatters: inputFormatters,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      style: TextStyle(color: Colors.black, fontSize: 14.sp),
      decoration: InputDecoration(
        isDense: true,
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
                    color: Colors.grey[400],
                  ),
                ),
              )
            : null,
        prefixIcon: prefixIcon,
        prefix: perfix,
        prefixIconColor: Colors.grey,
        prefixStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: AppColor.primaryColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: AppColor.primaryColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: AppColor.primaryColor,
            )),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.red),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
        errorText: errorMsg,
      ),
    );
  }
}
