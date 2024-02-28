import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLite {
  static String prefix = "copy_";

  static Future<String> getDatabasePath(String database) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "$prefix$database");
    return path;
  }

  static Future<void> initialize(List<String> databases) async {
    databases.forEach((db) async {
      await checkDatabase(db, "$prefix$db");
    });
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

  static Future<Database> getDatabase(String database) async {
    String path = await getDatabasePath(database);
    return await openDatabase(path);
  }
}
