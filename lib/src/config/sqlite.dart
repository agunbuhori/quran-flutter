import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLite {
  static String source = "quran.db";
  static String databaseName = "quran_copy_11.db";

  static Future<String> getDatabasePath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, databaseName);
    return path;
  }

  static Future<void> initialize() async {
    await checkDatabase(source, databaseName);
  }

  static Future<Database> checkDatabase(
      String source, String databaseName) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);

    bool exists = await databaseExists(path);

    if (!exists) {
      ByteData data = await rootBundle.load(join('assets/databases', source));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Database already exists at path $path");
    }

    return await openDatabase(path, readOnly: false);
  }

  static Future<Database> getDatabase() async {
    String path = await getDatabasePath();
    return await openDatabase(path);
  }
}
