// import 'package:flutter/material.dart';
// import 'package:multi_dropdown/multi_dropdown.dart';

// class CustomMultiSelect<T> extends StatefulWidget {
//   final List<DropdownItem<T>> items;
//   final MultiSelectController<T> controller;
//   final String hintText;
//   final FormFieldValidator<List<T>>? validator;
//   final ValueChanged<List<T>>? onSelectionChange;

//   const CustomMultiSelect({
//     Key? key,
//     required this.items,
//     required this.controller,
//     required this.hintText,
//     this.validator,
//     this.onSelectionChange,
//   }) : super(key: key);

//   @override
//   State<CustomMultiSelect<T>> createState() => _CustomMultiSelectState<T>();
// }

// class _CustomMultiSelectState<T> extends State<CustomMultiSelect<T>> {
//   @override
//   Widget build(BuildContext context) {
//     return FormField<List<T>>(
//       validator: widget.validator,
//       builder: (state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             MultiDropdown<T>(
//               items: widget.items,
//               controller: widget.controller,
//               enabled: true,
//               chipDecoration: const ChipDecoration(
//                 // backgroundColor: Colors.yellow,
//                 wrap: true,
//                 runSpacing: 5,
//                 spacing: 5,
//               ),
//               fieldDecoration: FieldDecoration(
//                 hintText: widget.hintText,
//                 hintStyle: const TextStyle(color: Colors.black87),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Colors.black87),
//                 ),
//               ),
//               dropdownDecoration: const DropdownDecoration(maxHeight: 500),
//               dropdownItemDecoration: DropdownItemDecoration(
//                 selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
//               ),
//               onSelectionChange: (selectedItems) {
//                 if (widget.onSelectionChange != null) {
//                   widget.onSelectionChange!(selectedItems);
//                 }
//                 state.didChange(selectedItems); // Updates the form state
//               },
//             ),
//             if (state.hasError)
//               Padding(
//                 padding: const EdgeInsets.only(top: 5),
//                 child: Text(
//                   state.errorText ?? '',
//                   style: const TextStyle(color: Colors.red, fontSize: 12),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
