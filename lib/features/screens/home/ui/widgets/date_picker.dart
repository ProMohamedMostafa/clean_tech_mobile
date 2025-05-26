import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomMonthPicker {
  static Future<String?> show({
    required BuildContext context,
  }) async {
    DateTime? startMonth;
    DateTime? endMonth;

    return await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        final DateFormat monthFormat = DateFormat('MMM');

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
                  Row(
                    children: [
                      Expanded(
                          child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'From: ',
                              style: TextStyles.font14BlackRegular,
                            ),
                            TextSpan(
                              text: startMonth != null
                                  ? monthFormat.format(startMonth!)
                                  : '',
                              style: TextStyles.font14Primarybold,
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'To: ',
                              style: TextStyles.font14BlackRegular,
                            ),
                            TextSpan(
                              text: endMonth != null
                                  ? monthFormat.format(endMonth!)
                                  : '',
                              style: TextStyles.font14Primarybold,
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                  verticalSpace(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 280.h,
                    child: SfDateRangePicker(
                      minDate: DateTime(2025, 1),
                      allowViewNavigation: false,
                      view: DateRangePickerView.year,
                      selectionMode: DateRangePickerSelectionMode.range,
                      rangeSelectionColor:
                          AppColor.primaryColor.withOpacity(0.3),
                      startRangeSelectionColor: AppColor.primaryColor,
                      endRangeSelectionColor: AppColor.primaryColor,
                      backgroundColor: Colors.white,
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
                        if (args.value is PickerDateRange) {
                          setState(() {
                            startMonth = args.value.startDate;
                            endMonth = args.value.endDate;
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
                            dialogContext.pop();
                          },
                          child: Text(
                            "Cancel",
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
                            if (startMonth != null && endMonth != null) {
                              Navigator.pop(
                                dialogContext,
                                '${monthFormat.format(startMonth!)} - ${monthFormat.format(endMonth!)} ${startMonth!.year}',
                              );
                            }
                          },
                          child: Text(
                            "Save",
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
