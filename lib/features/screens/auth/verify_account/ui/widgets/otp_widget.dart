import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class CustomPinCodeField extends StatelessWidget {
  const CustomPinCodeField({super.key, required this.pinCodeController});
  final TextEditingController pinCodeController;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      validator: (value) {
        if (value!.isEmpty) {
          return S.of(context).validationPinCodeEmpty;
        }
        return null;
      },
      boxShadows: const [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 1,
          blurRadius: 7,
          offset: Offset(2, 3),
        ),
      ],
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        selectedFillColor: Colors.white,
        activeColor: Colors.black,
        activeFillColor: Colors.white,
        inactiveColor: Colors.grey,
        selectedColor: Colors.black,
        inactiveFillColor: Colors.blue[100],
        borderRadius: BorderRadius.circular(10.r),
        fieldHeight: 55.h,
        fieldWidth: 50.w,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: pinCodeController,
      onCompleted: (v) {
        pinCodeController.text = v;
      },
      beforeTextPaste: (text) {
        return true;
      },
      appContext: context,
      onChanged: (String value) {
        if (value.length == 6) {
          pinCodeController.text = value;
        }
      },
    );
  }
}
