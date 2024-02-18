// database_helper.dart

import 'dart:io';

import 'package:brighter_nepal/models/pdf_models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pdf_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pdfDocuments (
        id INTEGER PRIMARY KEY,
        name TEXT,
        url TEXT
      )
    ''');
  }

  Future<void> insertPdfDocument(Pdf pdfDocument) async {
    final Database db = await database;
    await db.insert(
      'pdfDocuments',
      pdfDocument.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Pdf>> getAllPdfDocuments() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pdfDocuments');

    return List.generate(maps.length, (i) {
      return Pdf(
        id: maps[i]['id'],
        name: maps[i]['title'],
        url: maps[i]['link'],
        type: maps[i]['type'], // Update with your actual column name
        imageUrl: maps[i]['img_url'], // Update with your actual column name
      );
    });
  }

  Future<void> saveAndShowPdfPopup(String name, String pdfUrl, String id,
      String type, String imageUrl) async {
    await _savePdf(name, pdfUrl, id, type, imageUrl);
    await _showPdfPopup();
  }

  Future<void> _savePdf(String name, String pdfUrl, String id, String type,
      String imageUrl) async {
    final response = await http.get(Uri.parse(pdfUrl));

    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.pdf';

    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    final pdfDocument = Pdf(
      id: id,
      name: name,
      url: filePath,
      imageUrl: imageUrl,
      type: type,
    );

    await insertPdfDocument(pdfDocument);
  }

  Future<void> _showPdfPopup() {
    // Display the PDF popup here
    // You can use your preferred method to show a popup
    // E.g., showDialog, BottomSheet, etc.
    // For simplicity, you can print a message for now
    print('PDF Popup Displayed');
    return Future.value();
  }
}
