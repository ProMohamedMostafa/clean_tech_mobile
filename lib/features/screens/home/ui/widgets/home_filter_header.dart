import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/date_picker.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FilterHeader extends StatelessWidget {
  final String title;
  final int? count1;
  final int? count2;
  final String chartType;
  final String dateRange;
  final ValueChanged<String>? onFilterSelected;
  final ValueChanged<String>? onChartTypeSelected;
  final ValueChanged<String>? onDateRangeSelected;
  final String filterDropdownLabel;
  final List<(String, String)> filterDropdownItems;
  final ScrollController? scrollController;
  final Widget? extraWidget;

  const FilterHeader({
    super.key,
    required this.title,
    this.count1,
    this.count2,
    required this.chartType,
    required this.dateRange,
    this.onFilterSelected,
    this.onChartTypeSelected,
    this.onDateRangeSelected,
    required this.filterDropdownLabel,
    required this.filterDropdownItems,
    this.scrollController,
    this.extraWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                maxLines: 1,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                      style: TextStyles.font14BlackSemiBold,
                    ),
                    if (count1 != null)
                      TextSpan(
                        text: ' ($count1)',
                        style: TextStyles.font14Primarybold,
                      ),
                    if (count2 != null)
                      TextSpan(
                        text: ' ($count2)',
                        style: TextStyles.font14Primarybold
                            .copyWith(color: Color(0xff46B749)),
                      ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            if (role != 'Cleaner')
              _FilterDropdownForm(
                width: 123.w,
                label: ' $filterDropdownLabel',
                onSelected: onFilterSelected,
                items: filterDropdownItems,
                controller: scrollController!,
              ),
            if (extraWidget != null) ...[
              verticalSpace(10),
              extraWidget!,
            ]
          ],
        ),
        verticalSpace(8),
        Row(
          children: [
            _FilterDropdown(
              width: 120.w,
              label: '${S.of(context).chart_type}: $chartType',
              onSelected: onChartTypeSelected,
              items: [
                ('1', S.of(context).line),
                ('2', S.of(context).bar),
                ('3', S.of(context).pie),
              ],
            ),
            const Spacer(),
            _DateRangeSelector(
              dateRange: dateRange,
              onPressed: () async {
                final result = await CustomMonthPicker.show(context: context);
                if (result != null && onDateRangeSelected != null) {
                  onDateRangeSelected!(result);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _DateRangeSelector extends StatelessWidget {
  final String dateRange;
  final VoidCallback onPressed;

  const _DateRangeSelector({
    required this.dateRange,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          minimumSize: Size.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.calendar_month,
              color: AppColor.primaryColor,
              size: 16.sp,
            ),
            horizontalSpace(5),
            Text(
              dateRange,
              style: TextStyles.font12BlackSemi,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final double? width;
  final String label;

  final List<(String, String)> items;
  final ValueChanged<String>? onSelected;

  const _FilterDropdown({
    this.width,
    required this.label,
    required this.items,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 24.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        color: Colors.white,
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${label.split(':').first}: ',
                        style: TextStyles.font12BlackSemi,
                      ),
                      TextSpan(
                        text: label.split(':').last.trim(),
                        style: TextStyles.font12PrimSemi,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColor.primaryColor,
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        menuPadding: EdgeInsets.zero,
        itemBuilder: (context) => [
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0) PopupMenuDivider(height: 0.5.h),
            PopupMenuItem<String>(
              value: items[i].$1,
              height: 28.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                items[i].$2,
                style: TextStyles.font12BlackSemi,
              ),
            ),
          ],
        ],
        onSelected: (value) {
          // Find and return the display text
          final selectedItem = items.firstWhere((item) => item.$1 == value);
          onSelected?.call(selectedItem.$2);
        },
        offset: Offset(0, 23.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
        constraints: BoxConstraints(
          minWidth: width!,
          maxHeight: 140.h,
        ),
      ),
    );
  }
}

class _FilterDropdownForm extends StatefulWidget {
  final double? width;
  final String label;
  final List<(String, String)> items;
  final ValueChanged<String>? onSelected;
  final ScrollController controller;

  const _FilterDropdownForm({
    this.width,
    required this.label,
    required this.items,
    required this.controller,
    this.onSelected,
  });

  @override
  State<_FilterDropdownForm> createState() => _FilterDropdownFormState();
}

class _FilterDropdownFormState extends State<_FilterDropdownForm> {
  bool isOpen = false;
  OverlayEntry? _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  void _toggleDropdown() {
    if (isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {
      isOpen = !isOpen;
    });
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: widget.width ?? size.width,
        left: offset.dx,
        top: offset.dy + size.height,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(6.r),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 120,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: Colors.black12),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: widget.items.length,
                separatorBuilder: (_, __) => Divider(
                  color: Colors.black12,
                  height: 1,
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return InkWell(
                    onTap: () {
                      widget.onSelected?.call(item.$1);
                      _toggleDropdown();
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(6, 4, 4, 4),
                      child: Text(
                        item.$2,
                        style: TextStyles.font12BlackSemi,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          width: widget.width,
          height: 24.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(6.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.label, style: TextStyles.font12PrimSemi),
              RotatedBox(
                quarterTurns: isOpen ? 3 : 1,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.primaryColor,
                  size: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
