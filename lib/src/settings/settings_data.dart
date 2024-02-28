import 'package:get/instance_manager.dart';
import 'package:quran/src/common/consts/quran_database.dart';
import 'package:quran/src/common/consts/getx_tags.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/models/juz.dart';
import 'package:quran/src/models/surah.dart';
import 'package:sqflite/sqflite.dart';

class SettingsData {
  static Future<void> initialize() async {
    await SettingsData.loadSurahs();
    await SettingsData.loadJuzs();
  }

  static Future<void> loadSurahs() async {
    List<Surah> surahs = await Surah.getAll();
    Get.put(surahs, tag: GetxTags.surahs);
  }

  static Future<void> loadJuzs() async {
    Database database = await SQLite.getDatabase(QuranDatabase.dbName);

    List<Juz> tempJuzs = [];

    for (int i = 1; i <= 30; i++) {
      List<Map<String, dynamic>> ayahs = await database.rawQuery('''
        SELECT * FROM Ayah
        JOIN Surah
          ON Ayah.surah_id = Surah.id
        WHERE Ayah.juz_number = $i
        LIMIT 1
      ''');

      if (ayahs.isNotEmpty) {
        Juz juz = Juz(
            number: i,
            startFrom:
                "Mulai dari ${ayahs.first['name_complex']} ayat ${ayahs.first['ayah_number']}");
        tempJuzs.add(juz);
      }

      Get.put(tempJuzs, tag: GetxTags.juzs);
    }
  }
}
