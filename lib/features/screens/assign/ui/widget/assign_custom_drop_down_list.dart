import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

class AssignCustomDropDownList extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final Function(String?)? onChanged;
  final Function? suffixPressed;
  final List<String> items;
  final FormFieldValidator<String>? validator;
  final bool? isRead;

  const AssignCustomDropDownList({
    super.key,
    required this.items,
    this.validator,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.suffixIcon,
    this.onChanged,
    this.suffixPressed,
    this.isRead,
  });

  @override
  State<AssignCustomDropDownList> createState() =>
      _AssignCustomDropDownListState();
}

class _AssignCustomDropDownListState extends State<AssignCustomDropDownList> {
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
            _buildTextFormField(),
            if (isClicked) _buildDropdownContainer(),
          ],
        ),
      ],
    );
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.next,
      validator: widget.validator,
      onChanged: _onTextChanged,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      readOnly: widget.isRead ?? true,
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: widget.suffixIcon != null ? _buildSuffixIcon() : null,
        border: _buildBorder(Colors.grey),
        enabledBorder: _buildBorder(Colors.grey),
        focusedBorder: _buildBorder(Colors.grey),
        errorBorder: _buildBorder(Colors.red),
        fillColor: AppColor.secondaryColor,
        filled: true,
        hintText: widget.hint,
        hintStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
      ),
    );
  }

  IconButton _buildSuffixIcon() {
    return IconButton(
      onPressed: _onSuffixIconPressed,
      icon: Padding(
        padding: const EdgeInsets.only(right: 9),
        child: Icon(
          widget.suffixIcon,
          color: Colors.white,
          size: 23.sp,
        ),
      ),
    );
  }

  void _onSuffixIconPressed() {
    setState(() {
      isClicked = !isClicked;
      filteredItems = widget.items; // Reset list on click
    });
    widget.suffixPressed?.call();
  }

  void _onTextChanged(String value) {
    setState(() {
      isClicked = value.isNotEmpty;
      filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(value.toLowerCase()))
          .toList();
      widget.onChanged?.call(value);
    });
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildDropdownContainer() {
    return Container(
      padding: EdgeInsets.zero,
      height: filteredItems.length > 2 ? 150.h : filteredItems.length * 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.r,
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
    );
  }

  List<Widget> _buildDropdownItems(List<String> items) {
    return items.map((item) {
      return InkWell(
        onTap: () => _onItemSelected(item),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item, style: TextStyle(fontSize: 16.sp)),
              if (items.last != item)
                Divider(color: Colors.grey.shade400, thickness: 0.8),
            ],
          ),
        ),
      );
    }).toList();
  }

  void _onItemSelected(String item) {
    setState(() {
      selectedValue = item;
      widget.controller.text = item;
      isClicked = false;
    });
    widget.onChanged?.call(item);
  }
}
