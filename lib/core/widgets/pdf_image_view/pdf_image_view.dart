import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfImageView extends StatelessWidget {
  final String? fileUrl;
  const PdfImageView({super.key, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    bool isPdf(String? url) {
      if (url == null) return false;
      return url.toLowerCase().endsWith('.pdf');
    }

    if (fileUrl == null) {
      return Text(S.of(context).noFile);
    }

    final isPDF = isPdf(fileUrl);

    return GestureDetector(
      onTap: () {
        if (isPDF) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(title: Text('PDF Viewer')),
                body: SfPdfViewer.network(fileUrl!),
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(leading: CustomBackButton()),
                body: Center(
                  child: PhotoView(
                    imageProvider: NetworkImage(fileUrl!),
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.white),
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/noImage.png',
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
      },
      child: Container(
        height: 80,
        width: 80,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: isPDF
            ? Icon(Icons.picture_as_pdf, color: Colors.red, size: 40)
            : Image.network(
                fileUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/noImage.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
      ),
    );
  }
}
