import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class CustomMultiDropdown<T extends Object> extends StatelessWidget {
  final List<DropdownItem<T>> items;
  final MultiSelectController<T> controller;
  final ValueChanged<List<T>> onSelectionChange;
  final String hint;
  final int? maxSelections;

  const CustomMultiDropdown({
    super.key,
    required this.items,
    required this.controller,
    required this.onSelectionChange,
    required this.hint,
    this.maxSelections,
  });

  @override
  Widget build(BuildContext context) {
    return MultiDropdown<T>(
      items: items,
      controller: controller,
      onSelectionChange: (selectedItems) {
        onSelectionChange(selectedItems);
      },
      maxSelections: maxSelections ?? items.length,
      enabled: true,
      chipDecoration: ChipDecoration(
        backgroundColor: Colors.grey[300],
        wrap: true,
        runSpacing: 5,
        spacing: 5,
      ),
      fieldDecoration: FieldDecoration(
        hintText: hint,
        suffixIcon: const Icon(IconBroken.arrowDown2),
        hintStyle: TextStyles.font12GreyRegular,
        showClearIcon: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColor.primaryColor),
        ),
      ),
      dropdownDecoration: DropdownDecoration(maxHeight: 200.h),
      dropdownItemDecoration: const DropdownItemDecoration(
        selectedIcon: Icon(Icons.check_box, color: Colors.blue),
      ),
    );
  }
}
