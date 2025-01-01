import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

class EditListPointTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool readOnly;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final Function(String?)? onChanged;
  final Function? suffixPressed;
  final List<String> items;
  final Function(String?) validator;

  const EditListPointTextFormField({
    super.key,
    required this.items,
    required this.validator,
    required this.controller,
    required this.hint,
    required this.readOnly,
    required this.keyboardType,
    this.suffixIcon,
    this.onChanged,
    this.suffixPressed,
  });

  @override
  State<EditListPointTextFormField> createState() => _PointTextFormFieldState();
}

class _PointTextFormFieldState extends State<EditListPointTextFormField> {
  bool isClicked = false;
  String? selectedValue;
  List<String> filteredItems = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    filteredItems = widget.items; // Initialize with all items
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.controller,
              readOnly: widget.readOnly,
              keyboardType: widget.keyboardType,
              textInputAction: TextInputAction.next,
              validator: (value) {
                return widget.validator(value);
              },
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    isClicked = false;
                  } else {
                    isClicked = true;
                    filteredItems = widget.items
                        .where((item) =>
                            item.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  }

                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                });
              },
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: widget.suffixIcon != null
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isClicked = !isClicked;
                            filteredItems = widget.items; // Reset list on click
                          });
                          if (widget.suffixPressed != null) {
                            widget.suffixPressed!();
                          }
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: Icon(
                            widget.suffixIcon,
                            color: AppColor.thirdColor,
                            size: 23.sp,
                          ),
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColor.thirdColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColor.thirdColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColor.thirdColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: 11.sp,
                  color: AppColor.thirdColor,
                ),
              ),
            ),
            if (isClicked)
              Container(
                padding: EdgeInsets.zero,
                height: filteredItems.length > 2
                    ? 150.h
                    : filteredItems.length * 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 7,
                  radius: Radius.circular(10.r),
                  trackVisibility: true,
                  controller: _scrollController,
                  child: ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: _buildDropdownItems(filteredItems),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildDropdownItems(List<String> items) {
    return items.map((item) {
      return InkWell(
        onTap: () {
          setState(() {
            selectedValue = item;
            widget.controller.text = item;
            isClicked = false;
          });

          // Trigger onChanged callback when an item is selected
          if (widget.onChanged != null) {
            widget.onChanged!(item);
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item, style: TextStyle(fontSize: 16.sp)),
              Divider(
                color: Colors.grey.shade400,
                thickness: 0.8,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
