import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const String dbName = 'pdf_database.db';
  static const String tableName = 'downloaded_pdfs';

  Future<Database> _getDatabase() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    final databasePath = '${appDocumentDirectory.path}/$dbName';
    return openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE $tableName (
          id TEXT PRIMARY KEY,
          name TEXT,
          type TEXT,
          url TEXT,
    
          filePath TEXT
        )
      ''');
    });
  }

  Future<void> insertPDFInfo(String title, String pdfurl, String id,
      String type, String filePath) async {
    final Database db = await _getDatabase();
    await db.insert(tableName, {
      'id': id,
      'name': title,
      'type': type,
      'url': pdfurl,
      'filePath': filePath,
    });
  }

  Future<List<Map<String, dynamic>>> getAllPDFInfo() async {
    final Database db = await _getDatabase();
    return db.query(tableName);
  }
}
