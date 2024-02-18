import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:brighter_nepal/models/pdf_models.dart';
import 'package:brighter_nepal/widgets/utils/save_pdf.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  final String title;
  final String id;
  final String description;

  const PdfViewerScreen({
    super.key,
    required this.pdfUrl,
    required this.title,
    required this.id,
    required this.description,
  });

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'BookMark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
          IconButton(
            onPressed: () async {
              try {
                if (PdfModal.PdfList.isNotEmpty) {
                  await downloadAndSavePdf(
                    widget.title,
                    widget.pdfUrl,
                    widget.id,
                    widget.description,
                  );
                  AwesomeSnackbarContent(
                    contentType: ContentType.warning,
                    message:
                        'This Doccument Have Been Saved . To View It Go to Home Page and Open Navigation Drawer and Click on Downloads.',
                    title: "Documment Saved Successfully",
                  );
                } else {
                  AwesomeSnackbarContent(
                    contentType: ContentType.warning,
                    message:
                        'Notifications and Banners documents cannot be saved.',
                    title: "Pdf From notification and Banners Can't be saved.",
                  );
                }
              } on Exception catch (e) {
                print(e);
              }
            },
            icon: const Icon(Icons.download),
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildPdfViewer(),
        ],
      ),
    );
  }

  Widget _buildPdfViewer() {
    if (widget.pdfUrl.startsWith('http') || widget.pdfUrl.startsWith('https')) {
      // Online PDF
      return SfPdfViewer.network(
        widget.pdfUrl,
        key: _pdfViewerKey,
      );
    } else {
      File file = File(widget.pdfUrl);
      // Local PDF
      return SfPdfViewer.file(
        file,
        key: _pdfViewerKey,
      );
    }
  }
}
