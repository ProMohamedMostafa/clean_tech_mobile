import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;

Future<void> createPDF(BuildContext context) async {
  final cubit = context.read<UserManagementCubit>();
  final users = cubit.usersModel?.data?.users ?? [];

  final document = PdfDocument();
  final page = document.pages.add();
  final pageSize = page.getClientSize();

  // ======= Background =======
  final backgroundImage = PdfBitmap(await readImageData('background.png'));
  page.graphics.drawImage(
      backgroundImage, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));

  // ======= Logo =======
  final PdfBitmap leftLogo = PdfBitmap(await readImageData('pdf_logo.png'));
  const double logoWidth = 120;
  const double logoHeight = 60;
  page.graphics.drawImage(leftLogo, Rect.fromLTWH(0, 0, logoWidth, logoHeight));

  // ======= Title =======
  const double titleTop = logoHeight;
  const String title = "Users";
  final PdfFont titleFont =
      PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold);
  final Size titleSize = titleFont.measureString(title);
  final double titleLeft = (pageSize.width - titleSize.width) / 2;
  page.graphics.drawString(
    title,
    titleFont,
    bounds:
        Rect.fromLTWH(titleLeft, titleTop, titleSize.width, titleSize.height),
  );

  // ======= Table Setup =======
  final PdfGrid grid = PdfGrid();
  grid.columns.add(count: 6);
  grid.headers.add(1);
  final PdfGridRow header = grid.headers[0];

  header.cells[0].value = 'Username';
  header.cells[1].value = 'Email';
  header.cells[2].value = 'Phone';
  header.cells[3].value = 'Nationality';
  header.cells[4].value = 'Gender';
  header.cells[5].value = 'Role';

  // ======= Dynamic Rows from API =======
  for (final user in users) {
    final row = grid.rows.add();
    row.cells[0].value = user.userName ?? '';
    row.cells[1].value = user.email ?? '';
    row.cells[2].value = user.phoneNumber ?? '';
    row.cells[3].value = user.nationalityName ?? '';
    row.cells[4].value = user.gender ?? '';
    row.cells[5].value = user.role ?? '';
  }

  // ======= Style and Draw Table =======
  grid.style = PdfGridStyle(
    font: PdfStandardFont(PdfFontFamily.helvetica, 10),
    cellPadding: PdfPaddings(left: 4, top: 4, right: 4, bottom: 4),
  );

  const double tableTop = titleTop + 40;
  const double horizontalMargin = 20;
  grid.draw(
    page: page,
    bounds: Rect.fromLTWH(
      horizontalMargin,
      tableTop,
      pageSize.width - 2 * horizontalMargin,
      pageSize.height - tableTop,
    ),
  );

  // ======= Save File =======
  final bytes = await document.save();
  document.dispose();

  final directory = await _getDownloadDirectory();
  final fileName = 'users_${DateTime.now().millisecondsSinceEpoch}.pdf';
  final file = File('${directory.path}/$fileName');
  await file.writeAsBytes(bytes);
  // Show a simple success toast (without file path)
  toast(text: 'PDF downloaded successfully!', isSuccess: true);
}

Future<Uint8List> readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

Future<Directory> _getDownloadDirectory() async {
  if (Platform.isAndroid) {
    // Try multiple possible download paths for Android
    final possiblePaths = [
      '/storage/emulated/0/Download',
      '/sdcard/Download',
      '/storage/self/primary/Download',
      '/data/media/0/Download',
    ];

    for (final path in possiblePaths) {
      final dir = Directory(path);
      if (await dir.exists()) return dir;
    }

    // Fallback to external storage
    try {
      final external = await getExternalStorageDirectory();
      if (external != null) {
        return Directory('${external.path}/Download')
          ..createSync(recursive: true);
      }
    } catch (e) {
      debugPrint('Error accessing external storage: $e');
    }
  }

  // For iOS and fallback
  return await getApplicationDocumentsDirectory();
}
