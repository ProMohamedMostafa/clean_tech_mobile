import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDayPicker {
  static Future<String?> show({
    required BuildContext context,
  }) async {
    DateTime? startDate;
    DateTime? endDate;

    final DateFormat dayFormat = DateFormat('dd/MM/yyyy');

    return await showDialog<String>(
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
                                text: startDate != null
                                    ? dayFormat.format(startDate!)
                                    : '',
                                style: TextStyles.font14Primarybold,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                text: endDate != null
                                    ? dayFormat.format(endDate!)
                                    : '',
                                style: TextStyles.font14Primarybold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 280.h,
                    child: SfDateRangePicker(
                      minDate: DateTime(2020),
                      view: DateRangePickerView.month,
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
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                        firstDayOfWeek: 6, // Optional: Start from Saturday
                      ),
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        if (args.value is PickerDateRange) {
                          setState(() {
                            startDate = args.value.startDate;
                            endDate = args.value.endDate;
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
                            side: const BorderSide(color: Colors.grey),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {
                            if (startDate != null && endDate != null) {
                              Navigator.pop(
                                dialogContext,
                                '${dayFormat.format(startDate!)} - ${dayFormat.format(endDate!)}',
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
