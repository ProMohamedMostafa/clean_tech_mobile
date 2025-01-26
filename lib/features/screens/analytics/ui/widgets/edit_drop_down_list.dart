// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
// import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
// import 'package:smart_cleaning_application/core/theming/colors/color.dart';

// class EditDropdownList extends StatefulWidget {
//   final String? title;
//   final String? index;
//   final List<String> items;
//   final Function(String)? onPressed;
//   const EditDropdownList({
//     super.key,
//     required this.title,
//     required this.index,
//     required this.items,
//     required this.onPressed,
//   });

//   @override
//   State<EditDropdownList> createState() => _EditDropdownListState();
// }

// class _EditDropdownListState extends State<EditDropdownList> {
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
//         child: DropdownButton2(
//           customButton: Stack(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 52.h,
//                 margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
//                 decoration: BoxDecoration(
//                   borderRadius: isClicked
//                       ? BorderRadius.only(
//                           topLeft: Radius.circular(8.r),
//                           topRight: Radius.circular(8.r),
//                         )
//                       : BorderRadius.circular(8.r),
//                   border: Border.all(
//                     width: 1.w,
//                     color: AppColor.thirdColor,
//                   ),
//                   shape: BoxShape.rectangle,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(8, 0, 15, 0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         selectedValue ?? ' ${widget.index}',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: selectedValue != null
//                               ? Colors.black
//                               : Colors.grey,
//                         ),
//                       ),
//                       Icon(
//                         IconBroken.arrowDown2,
//                         color: isClicked ? AppColor.primaryColor : Colors.grey,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                   left: 9,
//                   child: Container(
//                     padding: EdgeInsets.only(left: 5, right: 5),
//                     color: Colors.white,
//                     child: Text(
//                       '${widget.title}',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 10.sp,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//             ],
//           ),
//           items: _buildDropdownItems(widget.items),
//           value: selectedValue,
//           onChanged: (value) {
//             setState(() {
//               selectedValue = value as String;
//               isClicked = false;
//             });
//             if (widget.onPressed != null) {
//               widget.onPressed!(selectedValue!);
//             }
//           },
//           dropdownStyleData: DropdownStyleData(
//             maxHeight: 200.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(10.r),
//                 bottomRight: Radius.circular(10.r),
//               ),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 10,
//                   offset: Offset(0, 10),
//                 ),
//               ],
//             ),
//             offset: const Offset(0, 0),
//             scrollbarTheme: ScrollbarThemeData(
//               thickness: WidgetStateProperty.all(7),
//               thumbColor: WidgetStateProperty.all(AppColor.thirdColor),
//               radius: Radius.circular(10.r),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<DropdownMenuItem<String>> _buildDropdownItems(List<String> items) {
//     return items
//         .map((item) => DropdownMenuItem<String>(
//               value: item,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   verticalSpace(5),
//                   Text(item, style: TextStyle(fontSize: 16)),
//                   if (items.last != item)
//                     Divider(
//                       color: Colors.grey.shade400,
//                       thickness: 0.8,
//                     ),
//                 ],
//               ),
//             ))
//         .toList();
//   }
// }
