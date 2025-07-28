import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  PhoneNumber number = PhoneNumber(isoCode: 'SA'); // Default to SA

  @override
  void initState() {
    super.initState();
    _setInitialPhoneNumber();
  }

  Future<void> _setInitialPhoneNumber() async {
    if (widget.controller.text.isNotEmpty) {
      String phone = widget.controller.text;

      // If number starts with 0 and looks Egyptian, assume +20
      if (phone.startsWith('0')) {
        phone = '+20${phone.substring(1)}';
      }

      final parsedNumber =
          await PhoneNumber.getRegionInfoFromPhoneNumber(phone);
      setState(() {
        number = parsedNumber;
        widget.controller.text = parsedNumber.phoneNumber ?? phone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        widget.onChanged?.call(number.phoneNumber ?? '');
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
        leadingPadding: 8,
        setSelectorButtonAsPrefixIcon: true,
        trailingSpace: false,
      ),
      countries: ['EG', 'SA'],
      initialValue: number,
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: const TextStyle(color: Colors.black),
      textFieldController: widget.controller,
      inputDecoration: InputDecoration(
        isDense: true,
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildFocusBorder(),
        errorBorder: _buildErrorBorder(),
        hintText: 'Enter your phone',
        hintStyle: TextStyles.font12GreyRegular,
        fillColor: Colors.white,
        filled: true,
      ),
      keyboardType: TextInputType.phone,
      formatInput: true,
      spaceBetweenSelectorAndTextField: 0,
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: Colors.grey[300]!),
    );
  }

  OutlineInputBorder _buildFocusBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: AppColor.primaryColor),
    );
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: Colors.red),
    );
  }
}
