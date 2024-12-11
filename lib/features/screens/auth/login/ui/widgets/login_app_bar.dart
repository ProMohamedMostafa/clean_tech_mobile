import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_cubit.dart';

AppBar loginAppBar(String currentLanguage, LoginCubit cubit) {
    return AppBar(
          leading: SizedBox.shrink(),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                onPressed: () {
                  final newLanguage = currentLanguage == 'en' ? 'ar' : 'en';
                  cubit.changeLanguage(newLanguage);
                },
                child: Text(
                  currentLanguage == 'en' ? 'AR' : 'EN',
                  style: TextStyles.font14Primarybold,
                ),
              ),
            )
          ],
        );
  }