import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

class CustomMultiSelectList<T extends Object> extends StatefulWidget {
  final List<T> items;
  final MultiSelectController<T> controller;
  final String hintText;
  final bool enabled;
  final Function(List<T>)? onChanged;

  const CustomMultiSelectList({
    super.key,
    required this.items,
    required this.controller,
    required this.hintText,
    required this.enabled,
    this.onChanged,
  });

  @override
  State<CustomMultiSelectList<T>> createState() =>
      _CustomMultiSelectListState<T>();
}

// class _CustomMultiSelectListState<T extends Object>
//     extends State<CustomMultiSelectList<T>> {
//   @override
//   Widget build(BuildContext context) {
//     final dropdownItems = _mapItemsToDropdownItems(widget.items);

//     return MultiDropdown<T>(
//       items: dropdownItems,
//       controller: widget.controller,
//       enabled: widget.enabled,
//       chipDecoration: ChipDecoration(
//         backgroundColor: Colors.grey[300],
//         wrap: true,
//         runSpacing: 5,
//         spacing: 5,
//       ),
//       fieldDecoration: FieldDecoration(
//         hintText: widget.hintText,
//         hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
//         showClearIcon: false,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.r),
//           borderSide: const BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.r),
//           borderSide: const BorderSide(color: Colors.grey),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.r),
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//       ),
//       dropdownDecoration: const DropdownDecoration(maxHeight: 200),
//       dropdownItemDecoration: DropdownItemDecoration(
//         selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
//       ),
//       onSelectionChange: _onSelectionChange,
//     );
//   }

//   List<DropdownItem<T>> _mapItemsToDropdownItems(List<T> items) {
//     return items.map((item) {
//       return DropdownItem<T>(
//         value: item,
//         label: item.toString(),
//       );
//     }).toList();
//   }

//   void _onSelectionChange(List<T> selectedItems) {
//     if (widget.onChanged != null) {
//       widget.onChanged!(selectedItems);
//     }
//   }
// }
class _CustomMultiSelectListState<T extends Object>
    extends State<CustomMultiSelectList<T>> {
  @override
  Widget build(BuildContext context) {
    final dropdownItems = _mapItemsToDropdownItems(widget.items);

    return MultiDropdown<T>(
      items: dropdownItems, // This is where DropdownItem is used
      controller: widget.controller,
      enabled: widget.enabled,
      chipDecoration: ChipDecoration(
        backgroundColor: Colors.grey[300],
        wrap: true,
        runSpacing: 5,
        spacing: 5,
      ),
      fieldDecoration: FieldDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
        showClearIcon: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      dropdownDecoration: const DropdownDecoration(maxHeight: 200),
      dropdownItemDecoration: DropdownItemDecoration(
        selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
      ),
      onSelectionChange: _onSelectionChange,
    );
  }

  List<DropdownItem<T>> _mapItemsToDropdownItems(List<T> items) {
    return items.map((item) {
      return DropdownItem<T>(
        value: item,
        label: item.toString(), // Customize the label as needed
      );
    }).toList();
  }

  void _onSelectionChange(List<T> selectedItems) {
    if (widget.onChanged != null) {
      widget.onChanged!(selectedItems);
    }
  }
}
