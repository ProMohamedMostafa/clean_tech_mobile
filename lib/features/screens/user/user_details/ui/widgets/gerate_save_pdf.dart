// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // To load assets
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';

// Future<pw.Font> loadFontFromAssets(String assetPath) async {
//   final byteData = await rootBundle.load(assetPath);
//   final fontData = byteData.buffer.asByteData();
//   return pw.Font.ttf(fontData);
// }

// void generateAndSavePDF(BuildContext context) async {
//   try {
//     final userModel = context.read<UserManagementCubit>().userDetailsModel!;
//     final pdf = pw.Document();

//     final font = await loadFontFromAssets('assets/fonts/Poppins.ttf');

//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text(
//                 "User Details",
//                 style: pw.TextStyle(
//                     fontSize: 20, fontWeight: pw.FontWeight.bold, font: font),
//               ),
//               pw.SizedBox(height: 10),
//               buildDetailRow("Username", userModel.data!.userName!, font),
//               buildDetailRow("First Name", userModel.data!.firstName!, font),
//               buildDetailRow("Last Name", userModel.data!.lastName!, font),
//               buildDetailRow("Email", userModel.data!.email!, font),
//               buildDetailRow("Phone", userModel.data!.phoneNumber!, font),
//               buildDetailRow("Birthdate", userModel.data!.birthdate!, font),
//               buildDetailRow("ID Number", userModel.data!.idNumber!, font),
//               buildDetailRow(
//                   "Nationality", userModel.data!.nationalityName!, font),
//               buildDetailRow("Country", userModel.data!.countryName!, font),
//               buildDetailRow("Gender", userModel.data!.gender!, font),
//               buildDetailRow("Role", userModel.data!.role!, font),
//               buildDetailRow(
//                   "Manager", userModel.data!.managerName ?? 'No Manager', font),
//               buildDetailRow("Provider",
//                   userModel.data!.providerName ?? 'No provider', font),
//             ],
//           );
//         },
//       ),
//     );

//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/user_details.pdf');
//     await file.writeAsBytes(await pdf.save());

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('PDF saved to ${file.path}')),
//     );
//   } catch (e) {
//     print("Error generating PDF: $e");
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text('Error generating PDF')));
//   }
// }

// pw.Widget buildDetailRow(String label, String value, pw.Font font) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.only(bottom: 8.0),
//     child: pw.Row(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text(
//           "$label: ",
//           style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font),
//         ),
//         pw.Flexible(
//           child: pw.Text(value, style: pw.TextStyle(font: font)),
//         ),
//       ],
//     ),
//   );
// }

// class UserManagementScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('User Management')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             print("Button Pressed");
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Generating PDF...')),
//             );
//             generateAndSavePDF(context);
//           },
//           child: Text('Generate PDF'),
//         ),
//       ),
//     );
//   }
// }
