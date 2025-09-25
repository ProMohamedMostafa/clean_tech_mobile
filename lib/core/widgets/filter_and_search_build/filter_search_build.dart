import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';

class FilterAndSearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onFilterTap;
  final ValueChanged<String> onSearchChanged;
  final String? hintText;
  final bool isFilterActive;
  final VoidCallback onClearFilter;

  const FilterAndSearchWidget({
    super.key,
    required this.searchController,
    required this.onFilterTap,
    required this.onSearchChanged,
    required this.hintText,
    required this.isFilterActive,
    required this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: CustomTextFormField(
              color: AppColor.secondaryColor,
              perfixIcon: Icon(IconBroken.search),
              controller: searchController,
              hint: hintText,
              keyboardType: TextInputType.text,
              onlyRead: false,
              onChanged: onSearchChanged,
            ),
          ),
          horizontalSpace(10),
          Expanded(
            flex: 1,
            child: InkWell(
              borderRadius: BorderRadius.circular(10.r),
              onTap: isFilterActive ? onClearFilter : onFilterTap,
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColor.secondaryColor),
                ),
                child: Center(
                  child: Icon(
                    isFilterActive ? Icons.close_rounded : Icons.tune,
                    color: isFilterActive ? Colors.red : AppColor.primaryColor,
                    size: isFilterActive ? 30.sp : 25.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
