// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
// import 'package:smart_cleaning_application/core/routing/routes.dart';
// import 'package:smart_cleaning_application/core/theming/colors/color.dart';
// import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
// import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
// import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
// import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
// import 'package:smart_cleaning_application/generated/l10n.dart';

// class ButtonsDetailsBuild extends StatelessWidget {
//   final int id;
//   const ButtonsDetailsBuild({
//     super.key,
//     required this.id,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DefaultElevatedButton(
//         name: S.of(context).deleteButton,
//         onPressed: () {
//           showCustomDialog(context, S.of(context).deleteMessage, () {
//             context.read<UserManagementCubit>().userDeleteInDetails(id);
//             context.pushNamedAndRemoveLastTwo(Routes.userManagmentScreen);
//           });
//         },
//         color: AppColor.primaryColor,
//         height: 48,
//         width: double.infinity,
//         textStyles: TextStyles.font20Whitesemimedium);
//   }
// }
