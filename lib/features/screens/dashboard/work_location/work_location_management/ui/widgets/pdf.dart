import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;

Future<void> createWorkLocationPDF(
    BuildContext context, int selectedIndex) async {
  final cubit = context.read<WorkLocationCubit>();
  final users = selectedIndex == 0
      ? cubit.areaModel!.data!.data
      : selectedIndex == 1
          ? cubit.cityModel!.data!.data
          : selectedIndex == 2
              ? cubit.organizationModel!.data!.data
              : selectedIndex == 3
                  ? cubit.buildingModel!.data!.data
                  : selectedIndex == 4
                      ? cubit.floorModel!.data!.data
                      : selectedIndex == 5
                          ? cubit.sectionModel!.data!.data
                          : cubit.pointModel!.data!.data ?? [];

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
  final String title = selectedIndex == 0
      ? "Areas"
      : selectedIndex == 1
          ? "Cities"
          : selectedIndex == 2
              ? "Organizations"
              : selectedIndex == 3
                  ? "Buildings"
                  : selectedIndex == 4
                      ? "Floors"
                      : selectedIndex == 5
                          ? "Sections"
                          : "Points";
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
  grid.columns.add(count: 2);
  grid.headers.add(1);
  final PdfGridRow header = grid.headers[0];

  header.cells[0].value = 'Name';
  header.cells[1].value = 'Belong to';

  // ======= Dynamic Rows from API =======
  for (int index = 0; index < users!.length; index++) {
    final row = grid.rows.add();
    row.cells[0].value = selectedIndex == 0
        ? cubit.areaModel!.data!.data![index].name ?? ''
        : selectedIndex == 1
            ? cubit.cityModel!.data!.data![index].name ?? ''
            : selectedIndex == 2
                ? cubit.organizationModel!.data!.data![index].name ?? ''
                : selectedIndex == 3
                    ? cubit.buildingModel!.data!.data![index].name ?? ''
                    : selectedIndex == 4
                        ? cubit.floorModel!.data!.data![index].name ?? ''
                        : selectedIndex == 5
                            ? cubit.sectionModel!.data!.data![index].name ?? ''
                            : cubit.pointModel!.data!.data![index].name ?? '';

    row.cells[1].value = selectedIndex == 0
        ? cubit.areaModel!.data!.data![index].countryName ?? ''
        : selectedIndex == 1
            ? cubit.cityModel!.data!.data![index].areaName ?? ''
            : selectedIndex == 2
                ? cubit.organizationModel!.data!.data![index].cityName ?? ''
                : selectedIndex == 3
                    ? cubit.buildingModel!.data!.data![index]
                            .organizationName ??
                        ''
                    : selectedIndex == 4
                        ? cubit.floorModel!.data!.data![index].buildingName ??
                            ''
                        : selectedIndex == 5
                            ? cubit.sectionModel!.data!.data![index]
                                    .floorName ??
                                ''
                            : cubit.pointModel!.data!.data![index]
                                    .sectionName ??
                                '';
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
  // ======= Save File =======
  final bytes = await document.save();
  document.dispose();

  final directory = await _getDownloadDirectory();
  final fileName = selectedIndex == 0
      ? "areas"
      : selectedIndex == 1
          ? "cities"
          : selectedIndex == 2
              ? "organizations"
              : selectedIndex == 3
                  ? "buildings"
                  : selectedIndex == 4
                      ? "floors"
                      : selectedIndex == 5
                          ? "sections"
                          : "points";

  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final file = File('${directory.path}/${fileName}_$timestamp.pdf');
  await file.writeAsBytes(bytes, flush: true);

  // Show a success toast (without file path)
  toast(text: 'PDF downloaded successfully!', isSuccess: true);
}

Future<Uint8List> readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

Future<Directory> _getDownloadDirectory() async {
  if (Platform.isAndroid) {
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
  return await getApplicationDocumentsDirectory();
}
