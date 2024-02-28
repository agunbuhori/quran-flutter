import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:quran/src/models/realm_models.dart';
import 'package:realm/realm.dart';

final config = Configuration.inMemory([
  Verse.schema,
  Chapter.schema,
  ChapterHeader.schema,
  LineFragment.schema,
  Page.schema,
  Part.schema,
  Quarter.schema,
]);

Future<void> copyRealmDatabase() async {
  // Get the path to the documents directory
  Directory documentsDirectory = await getApplicationDocumentsDirectory();

  // Specify the path for the destination file in the local storage
  String destPath = '$documentsDirectory/quran.realm';

  // Check if the database file already exists in the destination path
  if (await File(destPath).exists()) {
    print('Database file already exists in the local storage.');
    return;
  }

  try {
    // Load the database file from the assets
    ByteData data = await rootBundle.load('assets/databases/quran.realm');

    // Write the database file to the destination path
    await File(destPath).writeAsBytes(data.buffer.asUint8List());

    print('Database file copied to local storage successfully.');
  } catch (e) {
    print('Error copying database file: $e');
  }
}

Future<Realm> openExistingRealmDatabase() async {
  return Realm(config);
}
