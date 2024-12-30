// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
// import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
// import 'package:smart_cleaning_application/core/theming/colors/color.dart';
// import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
// import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
// import 'package:smart_cleaning_application/features/screens/add_organizations/logic/add_organization_cubit.dart';
// import 'package:smart_cleaning_application/features/screens/add_organizations/logic/add_organization_state.dart';
// import 'package:smart_cleaning_application/features/screens/add_organizations/ui/widgets/organization_text_form_field.dart';
// import 'package:smart_cleaning_application/features/screens/add_organizations/ui/widgets/add_organization_text_form_field.dart';
// import 'package:smart_cleaning_application/generated/l10n.dart';

// class AddCityBottomDialog {
//   int? selectedAreaId;
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
//       'Add Area',
//       style: TextStyles.font20BlacksemiBold,
//     );
//   }

//   Widget _buildDetailsField(BuildContext context, AddOrganizationCubit cubit) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: _DetailsForm(),
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
//               final selectedArea = cubit.areaModel?.data?.firstWhere(
//                   (area) => area.name == cubit.areaController.text);
//               if (selectedArea != null) {
//                 selectedAreaId = selectedArea.id;
//               }

//               cubit.createCity(selectedAreaId!);
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

// class _DetailsForm extends StatefulWidget {
//   @override
//   _DetailsFormState createState() => _DetailsFormState();
// }

// class _DetailsFormState extends State<_DetailsForm> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AddOrganizationCubit(),
//       child: BlocConsumer<AddOrganizationCubit, AddOrganizationState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           context.read<AddOrganizationCubit>().getNationality();
//           return Form(
//             key: context.read<AddOrganizationCubit>().formAddKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   S.of(context).addUserText12,
//                   style: TextStyles.font16BlackRegular,
//                 ),
//                 OrganizationTextFormField(
//                   hint: "Select country",
//                   items: context
//                               .read<AddOrganizationCubit>()
//                               .nationalityModel
//                               ?.data
//                               ?.isEmpty ??
//                           true
//                       ? ['No country']
//                       : context
//                               .read<AddOrganizationCubit>()
//                               .nationalityModel
//                               ?.data
//                               ?.map((e) => e.name ?? 'Unknown')
//                               .toList() ??
//                           [],
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         value == 'No country') {
//                       return S.of(context).validationNationality;
//                     }
//                   },
//                   onChanged: (value) {
//                     context
//                         .read<AddOrganizationCubit>()
//                         .nationalityController
//                         .text = value!;
//                     context.read<AddOrganizationCubit>().getArea(value);
//                   },
//                   suffixIcon: IconBroken.arrowDown2,
//                   controller: context
//                       .read<AddOrganizationCubit>()
//                       .nationalityController,
//                   readOnly: false,
//                   keyboardType: TextInputType.text,
//                 ),
//                 verticalSpace(15),
//                 Text(
//                   "Area",
//                   style: TextStyles.font16BlackRegular,
//                 ),
//                 OrganizationTextFormField(
//                   hint: "Select area",
//                   items: context
//                               .read<AddOrganizationCubit>()
//                               .areaModel
//                               ?.data
//                               ?.isEmpty ??
//                           true
//                       ? ['No area']
//                       : context
//                               .read<AddOrganizationCubit>()
//                               .areaModel
//                               ?.data
//                               ?.map((e) => e.name ?? 'Unknown')
//                               .toList() ??
//                           [],
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Area is required";
//                     }
//                   },
//                   suffixIcon: IconBroken.arrowDown2,
//                   controller:
//                       context.read<AddOrganizationCubit>().areaController,
//                   readOnly: false,
//                   keyboardType: TextInputType.text,
//                 ),
//                 verticalSpace(15),
//                 Text(
//                   "Add city",
//                   style: TextStyles.font16BlackRegular,
//                 ),
//                 AddOrganizationTextField(
//                   controller:
//                       context.read<AddOrganizationCubit>().addCityController,
//                   obscureText: false,
//                   keyboardType: TextInputType.text,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "City is required";
//                     }
//                   },
//                 ),
//                 verticalSpace(15),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// showModalBottomSheet(
//                                                       useRootNavigator: true,
//                                                       isScrollControlled: true,
//                                                       context: context,
//                                                       builder: (BuildContext
//                                                           context) {
//                                                         return StatefulBuilder(
//                                                             builder: (context,
//                                                                 updateState) {
//                                                           return SingleChildScrollView(
//                                                             padding: EdgeInsets.only(
//                                                                 bottom: MediaQuery.of(
//                                                                         context)
//                                                                     .viewInsets
//                                                                     .bottom),
//                                                             child: Container(
//                                                               decoration: BoxDecoration(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   borderRadius: BorderRadius.only(
//                                                                       topRight:
//                                                                           Radius.circular(30
//                                                                               .r),
//                                                                       topLeft: Radius
//                                                                           .circular(
//                                                                               30.r))),
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets
//                                                                     .symmetric(
//                                                                     horizontal:
//                                                                         20),
//                                                                 child: Column(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .start,
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .center,
//                                                                   mainAxisSize:
//                                                                       MainAxisSize
//                                                                           .min,
//                                                                   children: [
//                                                                     SizedBox(
//                                                                       height:
//                                                                           10.h,
//                                                                     ),
//                                                                     Center(
//                                                                       child:
//                                                                           Container(
//                                                                         height:
//                                                                             5.h,
//                                                                         width:
//                                                                             133.w,
//                                                                         decoration: BoxDecoration(
//                                                                             color:
//                                                                                 Colors.grey[300],
//                                                                             borderRadius: BorderRadius.circular(30.r)),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height:
//                                                                           30.h,
//                                                                     ),
//                                                                     Center(
//                                                                       child:
//                                                                           Text(
//                                                                         S
//                                                                             .of(context)
//                                                                             .rateTitle1,
//                                                                         style: TextStyle(
//                                                                             fontFamily:
//                                                                                 'Rubik',
//                                                                             fontSize:
//                                                                                 18.sp,
//                                                                             color: Colors.black,
//                                                                             fontWeight: FontWeight.w600),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height:
//                                                                           20.h,
//                                                                     ),
//                                                                     RatingBar
//                                                                         .builder(
//                                                                       initialRating:
//                                                                           ratingg,
//                                                                       minRating:
//                                                                           1,
//                                                                       direction:
//                                                                           Axis.horizontal,
//                                                                       allowHalfRating:
//                                                                           false,
//                                                                       itemCount:
//                                                                           5,
//                                                                       itemSize:
//                                                                           40,
//                                                                       itemBuilder:
//                                                                           (context, _) =>
//                                                                               const Icon(
//                                                                         Icons
//                                                                             .star,
//                                                                         color: Colors
//                                                                             .yellowAccent,
//                                                                       ),
//                                                                       onRatingUpdate:
//                                                                           (rating) {
//                                                                         setState(
//                                                                             () {
//                                                                           ratingg =
//                                                                               rating;
//                                                                         });
//                                                                       },
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height:
//                                                                           20.h,
//                                                                     ),
//                                                                     Center(
//                                                                       child:
//                                                                           Text(
//                                                                         S
//                                                                             .of(context)
//                                                                             .rateTitle2,
//                                                                         textAlign:
//                                                                             TextAlign.center,
//                                                                         style: TextStyle(
//                                                                             fontFamily:
//                                                                                 'Rubik',
//                                                                             fontSize:
//                                                                                 18.sp,
//                                                                             color: Colors.black,
//                                                                             fontWeight: FontWeight.w600),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height:
//                                                                           20.h,
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height:
//                                                                           150.h,
//                                                                       width: double
//                                                                           .infinity,
//                                                                       child:
//                                                                           TextFormField(
//                                                                         controller:
//                                                                             reviewController,
//                                                                         textAlignVertical:
//                                                                             TextAlignVertical.top,
//                                                                         textAlign:
//                                                                             TextAlign.start,
//                                                                         keyboardType:
//                                                                             TextInputType.multiline,
//                                                                         maxLines:
//                                                                             null,
//                                                                         expands:
//                                                                             true,
//                                                                         decoration: InputDecoration(
//                                                                             contentPadding:
//                                                                                 const EdgeInsets.all(5),
//                                                                             hintText: S.of(context).rateTitle3,
//                                                                             hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
//                                                                             isDense: true,
//                                                                             border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height:
//                                                                           30.h,
//                                                                     ),
//                                                                     Center(
//                                                                       child:
//                                                                           SizedBox(
//                                                                         width:
//                                                                             295.w,
//                                                                         height:
//                                                                             54.h,
//                                                                         child: ElevatedButton(
//                                                                             onPressed: isSubmitting
//                                                                                 ? null
//                                                                                 : () async {
//                                                                                     final userId = FirebaseAuth.instance.currentUser?.uid;
//                                                                                     String serviceId = getData['empId'];

//                                                                                     if (userId == null) {
//                                                                                       // Handle user not logged in
//                                                                                       return;
//                                                                                     }

//                                                                                     setState(() {
//                                                                                       isSubmitting = true;
//                                                                                     });

//                                                                                     try {
//                                                                                       final hasRated = await AppCubit.get(context).hasUserRated(userId, serviceId);
//                                                                                       if (hasRated) {
//                                                                                         // Show a message that user has already rated
//                                                                                         toast(text: 'You have already rated this service', color: Colors.red);

//                                                                                         Navigator.pop(context);
//                                                                                       } else {
//                                                                                         await AppCubit.get(context).submitReview(name, userId, serviceId, reviewController.text, ratingg);
//                                                                                         toast(text: 'Your review & rate sent successfully', color: Colors.blue);

//                                                                                         Navigator.pop(context);
//                                                                                       }
//                                                                                     } catch (e) {
//                                                                                       // Handle any errors
//                                                                                       toast(text: e.toString(), color: Colors.red);
//                                                                                     } finally {
//                                                                                       setState(() {
//                                                                                         isSubmitting = false;
//                                                                                       });
//                                                                                     }
//                                                                                   },
//                                                                             style: ElevatedButton.styleFrom(
//                                                                                 surfaceTintColor: Colors.black,
//                                                                                 backgroundColor: Colors.black,
//                                                                                 shape: RoundedRectangleBorder(
//                                                                                   borderRadius: BorderRadius.circular(8.r),
//                                                                                 )),
//                                                                             child: Text(
//                                                                               S.of(context).rateTitle4,
//                                                                               style: TextStyle(fontFamily: 'Rubik', fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
//                                                                             )),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height:
//                                                                           60.h,
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           );
//                                                         });
//                                                       },
//                                                     );