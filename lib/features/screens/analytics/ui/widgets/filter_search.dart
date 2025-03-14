import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

Widget filterSearchOrganizationBuild() {
  return Builder(
    builder: (context) => DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(
          Icons.tune,
          color: AppColor.primaryColor,
          size: 30.sp,
        ),
        items: [
          DropdownMenuItem(
            value: 'Country',
            child: Text('Country', style: TextStyle(fontSize: 16)),
          ),
          DropdownMenuItem(
            value: 'Area',
            child: Text('Area', style: TextStyle(fontSize: 16)),
          ),
          DropdownMenuItem(
            value: 'City',
            child: Text('City', style: TextStyle(fontSize: 16)),
          ),
          DropdownMenuItem(
            value: 'Organization',
            child: Text('Organization', style: TextStyle(fontSize: 16)),
          ),
          DropdownMenuItem(
            value: 'Building',
            child: Text('Building', style: TextStyle(fontSize: 16)),
          ),
          DropdownMenuItem(
            value: 'Floor',
            child: Text('Floor', style: TextStyle(fontSize: 16)),
          ),
          DropdownMenuItem(
            value: 'Point',
            child: Text('Point', style: TextStyle(fontSize: 16)),
          ),
        ],
        onChanged: (value) {
          // String selectedValue = value.toString();
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200.h,
          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 45.h,
        ),
      ),
    ),
  );
}
