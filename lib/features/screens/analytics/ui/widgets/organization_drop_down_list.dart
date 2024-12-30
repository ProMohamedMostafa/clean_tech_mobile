// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
// import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
// import 'package:smart_cleaning_application/core/theming/colors/color.dart';

// class OrganizationDropDownList extends StatefulWidget {
//   final String? title;
//   final List<String> items;
//   final Function(String)? onPressed;
//   final String? Function(String?)? validator;

//   const OrganizationDropDownList({
//     super.key,
//     required this.title,
//     required this.items,
//     required this.onPressed,
//     required this.validator,
//   });

//   @override
//   State<OrganizationDropDownList> createState() => _DropdownListState();
// }

// class _DropdownListState extends State<OrganizationDropDownList> {
//   bool isClicked = false;
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isClicked = !isClicked;
//         });
//       },
//       child: DropdownButtonHideUnderline(
//         child: FormField<String>(
//           validator:
//               widget.validator, // Use the validator passed from AddUserBody
//           builder: (FormFieldState<String> state) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 DropdownButton2(
//                   customButton: Container(
//                     width: double.infinity,
//                     height: 47.h,
//                     decoration: BoxDecoration(
//                       borderRadius: isClicked
//                           ? BorderRadius.only(
//                               topLeft: Radius.circular(8.r),
//                               topRight: Radius.circular(8.r),
//                             )
//                           : BorderRadius.circular(8.r),
//                       border: state.hasError
//                           ? Border.all(
//                               width: 1.w,
//                               color: Colors.red,
//                             )
//                           : Border.all(
//                               width: 1.w,
//                               color: AppColor.thirdColor,
//                             ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             selectedValue ?? 'Choose ${widget.title}',
//                             style: TextStyle(
//                               fontSize: 11.sp,
//                               color: selectedValue != null
//                                   ? Colors.black
//                                   : AppColor.thirdColor,
//                             ),
//                           ),
//                           Icon(
//                             IconBroken.arrowDown2,
//                             color: isClicked
//                                 ? AppColor.primaryColor
//                                 : AppColor.thirdColor,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   items: _buildDropdownItems(widget.items),
//                   value: selectedValue,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedValue = value as String;
//                       isClicked = false;
//                     });
//                     // Trigger the validation after selection
//                     state.didChange(value);
//                     if (widget.onPressed != null) {
//                       widget.onPressed!(selectedValue!);
//                     }
//                   },
//                   dropdownStyleData: DropdownStyleData(
//                     maxHeight: 200.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10.r),
//                         bottomRight: Radius.circular(10.r),
//                       ),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 10,
//                           offset: Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     offset: const Offset(0, 0),
//                     scrollbarTheme: ScrollbarThemeData(
//                       thickness: WidgetStateProperty.all(7),
//                       thumbColor: WidgetStateProperty.all(AppColor.thirdColor),
//                       radius: Radius.circular(10.r),
//                     ),
//                   ),
//                 ),
//                 // Show error message if validation fails
//                 if (state.hasError)
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                     child: Text(
//                       state.errorText!,
//                       overflow: TextOverflow.ellipsis,
//                       style:
//                           TextStyle(color: Color(0xFFB3261E), fontSize: 12.sp),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   List<DropdownMenuItem<String>> _buildDropdownItems(List<String> items) {
//     return items
//         .map((item) => DropdownMenuItem<String>(
//               value: item,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   verticalSpace(5),
//                   Text(item, style: TextStyle(fontSize: 16.sp)),
//                   Divider(
//                     color: Colors.grey.shade400,
//                     thickness: 0.8,
//                   ),
//                 ],
//               ),
//             ))
//         .toList();
//   }
// }
