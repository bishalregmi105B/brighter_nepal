import 'dart:io';
import 'package:brighter_nepal/widgets/utils/db_helper.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<void> downloadAndSavePdf(
    String title, String pdfurl, String id, String type) async {
  final response = await http.get(Uri.parse(pdfurl));

  if (response.statusCode == 200) {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${appDocumentDirectory.path}/$title.pdf';

    await File(filePath).writeAsBytes(response.bodyBytes);

    print('PDF downloaded and saved at: $filePath');

    // Save information in the database
    final dbHelper = DBHelper();
    await dbHelper.insertPDFInfo(title, pdfurl, id, type, filePath);
  } else {
    throw Exception('Failed to download PDF');
  }
}
