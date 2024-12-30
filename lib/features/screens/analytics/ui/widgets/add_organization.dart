// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
// import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
// import 'package:smart_cleaning_application/core/theming/colors/color.dart';
// import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
// import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
// import 'package:smart_cleaning_application/features/screens/add_organizations/logic/add_organization_cubit.dart';
// import 'package:smart_cleaning_application/features/screens/add_organizations/ui/widgets/organization_text_form_field.dart';
// import 'package:smart_cleaning_application/features/screens/add_organizations/ui/widgets/add_organization_text_form_field.dart';
// import 'package:smart_cleaning_application/generated/l10n.dart';

// class AddOrganizationBottomDialog {
//   int? selectedCityId;
//   void showBottomDialog(BuildContext context, AddOrganizationCubit cubit) {
//     showGeneralDialog(
//       barrierLabel: "showGeneralDialog",
//       barrierDismissible: true,
//       barrierColor: Colors.black.withOpacity(0.6),
//       transitionDuration: const Duration(milliseconds: 400),
//       context: context,
//       pageBuilder: (context, _, __) {
//         return Align(
//           alignment: Alignment.bottomCenter,
//           child: _buildDialogContent(context, cubit),
//         );
//       },
//       transitionBuilder: (_, animation1, __, child) {
//         return SlideTransition(
//           position: Tween(
//             begin: const Offset(0, 1),
//             end: const Offset(0, 0),
//           ).animate(animation1),
//           child: child,
//         );
//       },
//     );
//   }

//   Widget _buildDialogContent(BuildContext context, AddOrganizationCubit cubit) {
//     return Container(
//       width: double.maxFinite,
//       clipBehavior: Clip.antiAlias,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.r),
//           topRight: Radius.circular(16.r),
//         ),
//       ),
//       child: Material(
//         color: Colors.white,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _buildContinueText(),
//                 verticalSpace(8),
//                 _buildDetailsField(context, cubit),
//                 verticalSpace(16),
//                 _buildContinueButton(context, cubit),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContinueText() {
//     return Text(
//       'Add Organization',
//       style: TextStyles.font20BlacksemiBold,
//     );
//   }

//   Widget _buildDetailsField(BuildContext context, AddOrganizationCubit cubit) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Form(
//         key: cubit.formAddKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               S.of(context).addUserText12,
//               style: TextStyles.font16BlackRegular,
//             ),
//             OrganizationTextFormField(
//               hint: "Select country",
//               items: cubit.nationalityModel?.data?.isEmpty ?? true
//                   ? ['No country']
//                   : cubit.nationalityModel?.data
//                           ?.map((e) => e.name ?? 'Unknown')
//                           .toList() ??
//                       [],
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return S.of(context).validationNationality;
//                 }
//               },
//               suffixIcon: IconBroken.arrowDown2,
//               controller: cubit.nationalityController,
//               readOnly: false,
//               keyboardType: TextInputType.text,
//             ),
//             verticalSpace(15),
//             Text(
//               "Area",
//               style: TextStyles.font16BlackRegular,
//             ),
//             OrganizationTextFormField(
//               hint: "Select area",
//               items: cubit.areaModel?.data?.isEmpty ?? true
//                   ? ['No area']
//                   : cubit.areaModel?.data
//                           ?.map((e) => e.name ?? 'Unknown')
//                           .toList() ??
//                       [],
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Area is required";
//                 }
//               },
//               suffixIcon: IconBroken.arrowDown2,
//               controller: cubit.areaController,
//               readOnly: false,
//               keyboardType: TextInputType.text,
//             ),
//             verticalSpace(15),
//             Text(
//               "City",
//               style: TextStyles.font16BlackRegular,
//             ),
//             OrganizationTextFormField(
//               hint: "Select city",
//               items: cubit.cityModel?.data?.isEmpty ?? true
//                   ? ['No city']
//                   : cubit.cityModel?.data
//                           ?.map((e) => e.name ?? 'Unknown')
//                           .toList() ??
//                       [],
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "City is required";
//                 }
//               },
//               suffixIcon: IconBroken.arrowDown2,
//               controller: cubit.cityController,
//               readOnly: false,
//               keyboardType: TextInputType.text,
//             ),
//             verticalSpace(15),
//             Text(
//               "Add organization",
//               style: TextStyles.font16BlackRegular,
//             ),
//             AddOrganizationTextField(
//               controller: cubit.addOrganizationController,
//               obscureText: false,
//               keyboardType: TextInputType.text,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Organization is required";
//                 }
//               },
//             ),
//             verticalSpace(15),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContinueButton(
//       BuildContext context, AddOrganizationCubit cubit) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         DefaultElevatedButton(
//           name: "Close",
//           onPressed: () {
//             Navigator.of(context, rootNavigator: true).pop();
//           },
//           color: AppColor.primaryColor,
//           height: 45,
//           width: 150,
//           textStyles: TextStyles.font20Whitesemimedium,
//         ),
//         DefaultElevatedButton(
//           name: "Save",
//           onPressed: () {
//             if (cubit.formAddKey.currentState!.validate()) {
//               final selectedCity = cubit.cityModel?.data?.firstWhere(
//                   (city) => city.name == cubit.cityController.text);
//               if (selectedCity != null) {
//                 selectedCityId = selectedCity.id;
//               }

//               cubit.createOrganization(selectedCityId!);
//             }
//           },
//           color: AppColor.primaryColor,
//           height: 45,
//           width: 150,
//           textStyles: TextStyles.font20Whitesemimedium,
//         ),
//       ],
//     );
//   }
// }
