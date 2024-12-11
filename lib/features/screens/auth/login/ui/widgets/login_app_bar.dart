import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_states.dart';

AppBar loginAppBar() {
  return AppBar(
    leading: SizedBox.shrink(),
    actions: [
      BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextButton(
              onPressed: () {
                final newLanguage =
                    context.read<AppCubit>().locale.toString() == 'en'
                        ? 'ar'
                        : 'en';
                context.read<AppCubit>().changeLanguage(newLanguage);
              },
              child: Text(
                context.read<AppCubit>().locale.toString() == 'en'
                    ? 'AR'
                    : 'EN',
                style: TextStyles.font14Primarybold,
              ),
            ),
          );
        },
      )
    ],
  );
}
