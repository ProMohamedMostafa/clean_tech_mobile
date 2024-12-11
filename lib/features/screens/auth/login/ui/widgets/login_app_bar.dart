// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_cleaning_application/core/app_cubit/app_cubit.dart';
// import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

// AppBar loginAppBar(BuildContext context) {
//   return AppBar(
//     leading: SizedBox.shrink(),
//     actions: [
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: TextButton(
//           onPressed: () {
//             final newLanguage =
//                 context.read<AppCubit>().locale.toString() == 'en'
//                     ? 'ar'
//                     : 'en';
//             context.read<AppCubit>().changeLanguage(newLanguage);
//           },
//           child: Text(
//             context.read<AppCubit>().locale.toString() == 'en' ? 'AR' : 'EN',
//             style: TextStyles.font14Primarybold,
//           ),
//         ),
//       )
//     ],
//   );
// }
