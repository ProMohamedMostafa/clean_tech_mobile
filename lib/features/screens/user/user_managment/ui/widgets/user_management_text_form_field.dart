import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

class UserManagementTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final Function? onChanged;
  final Function? suffixPressed;
  final Widget? perfix;
  final List<TextInputFormatter>? inputFormatters;
  final Function? onSubmitted;
  final bool readOnly;

  const UserManagementTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.suffixPressed,
    this.perfix,
    this.inputFormatters,
    this.onSubmitted,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      validator: validator,
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      onFieldSubmitted: (s) {
        onSubmitted!(s);
      },
      textInputAction: TextInputAction.next,
      onChanged: (s) {
        if (onChanged != null) {
          onChanged!(s);
        }
      },
      maxLines: null,
      style: TextStyle(color: Colors.black, fontSize: 14.sp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 15),
        prefixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          onPressed: null,
        ),
        isDense: false,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  {
                    suffixPressed!();
                  }
                },
                icon: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 25.sp,
                    color: Colors.grey,
                  ),
                ))
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: AppColor.secondaryColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: AppColor.secondaryColor,
            )),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.red),
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
