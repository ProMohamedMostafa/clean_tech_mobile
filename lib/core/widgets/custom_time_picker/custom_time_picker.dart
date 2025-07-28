import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class CustomTimePicker {
  static Future<String?> show({
    required BuildContext context,
  }) async {
    String selectedTime = DateFormat('HH:mm').format(DateTime.now());

    return await showDialog(
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 140.h,
                  width: 335.w,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (val) {
                        selectedTime = DateFormat('HH:mm').format(val);
                      })),
              verticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 48.h,
                    width: 130.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        side: WidgetStateProperty.all(BorderSide(
                          color: AppColor.thirdColor,
                        )),
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        overlayColor:
                            WidgetStateProperty.all(AppColor.thirdColor),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12.r,
                            ),
                          ),
                        ),
                        elevation: WidgetStateProperty.all(1),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ),
                  ),
                  horizontalSpace(10),
                  SizedBox(
                    height: 48.h,
                    width: 130.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColor.primaryColor),
                        overlayColor:
                            WidgetStateProperty.all(AppColor.thirdColor),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12.r,
                            ),
                          ),
                        ),
                        elevation: WidgetStateProperty.all(1),
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop(selectedTime);
                      },
                      child: Text(
                        "Save",
                        style: TextStyles.font14WhiteMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
