import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomStockMonthPicker {
  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? initialDate,
  }) async {
    DateTime? selectedDate = initialDate ?? DateTime.now();

    return await showDialog<DateTime>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.all(20),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 280.h,
                    child: SfDateRangePicker(
                      initialSelectedDate: selectedDate,
                      minDate: DateTime(2025, 1),
                      allowViewNavigation: false,
                      view: DateRangePickerView.year,
                      selectionMode: DateRangePickerSelectionMode.single,
                      rangeSelectionColor:
                          AppColor.primaryColor.withOpacity(0.3),
                      startRangeSelectionColor: AppColor.primaryColor,
                      endRangeSelectionColor: AppColor.primaryColor,
                      backgroundColor: Colors.white,
                      selectionColor: AppColor.primaryColor,
                      headerStyle: DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        backgroundColor: AppColor.primaryColor.withOpacity(0.1),
                        textStyle: TextStyle(
                          color: AppColor.primaryColor,
                        ),
                      ),
                      yearCellStyle: DateRangePickerYearCellStyle(
                        todayTextStyle: TextStyle(color: AppColor.primaryColor),
                        todayCellDecoration: BoxDecoration(),
                      ),
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        if (args.value is DateTime) {
                          setState(() {
                            selectedDate = args.value;
                          });
                        }
                      },
                    ),
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 45.h,
                        width: 130.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: Text(
                             S.of(context).cancelButton,
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.black),
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      SizedBox(
                        height: 45.h,
                        width: 130.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            side: BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {
                            Navigator.pop(dialogContext, selectedDate);
                          },
                          child: Text(
                            S.of(context).saveButton,
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
