import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

class CustomDatePicker {
  static Future<String?> show({
    required BuildContext context,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3025), // End date set to infinity
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor, // Selected day circle color
              onPrimary: Colors.white, // Text color on selected day
              onSurface: Colors.black, // Default text color
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate != null) {
        // Return formatted date
        return DateFormat('yyyy-MM-dd').format(pickedDate);
      }
      return null; // Return null if no date selected
    });
  }
}
