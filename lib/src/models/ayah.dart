import 'package:quran/src/common/consts/quran_database.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/models/kalimah.dart';
import 'package:sqflite/sqflite.dart';

class Ayah {
  final int id;
  final int surahId;
  final int ayahNumber;
  final String ayahKey;
  final int hizbNumber;
  final int rubElHizbNumber;
  final int rukuNumber;
  final int manzilNumber;
  final int? sajdahNumber;
  final int pageNumber;
  final int juzNumber;
  final String textUthmani;
  final String? translation;
  final String? transliteration;
  final List<Kalimah>? kalimahs;

  Ayah(
      {required this.id,
      required this.surahId,
      required this.ayahNumber,
      required this.ayahKey,
      required this.hizbNumber,
      required this.rubElHizbNumber,
      required this.rukuNumber,
      required this.manzilNumber,
      this.sajdahNumber,
      required this.pageNumber,
      required this.juzNumber,
      required this.textUthmani,
      this.translation,
      this.transliteration,
      this.kalimahs});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'surah_id': surahId,
      'ayah_number': ayahNumber,
      'ayah_key': ayahKey,
      'hizb_number': hizbNumber,
      'rub_el_hizb_number': rubElHizbNumber,
      'ruku_number': rukuNumber,
      'manzil_number': manzilNumber,
      'sajdah_number': sajdahNumber,
      'page_number': pageNumber,
      'juz_number': juzNumber,
      'text_uthmani': textUthmani,
      'transliteration': transliteration,
      'translation': translation
    };
  }

  factory Ayah.fromMap(Map<String, dynamic> map) {
    return Ayah(
        id: map['id'],
        surahId: map['surah_id'],
        ayahNumber: map['ayah_number'],
        ayahKey: map['ayah_key'],
        hizbNumber: map['hizb_number'],
        rubElHizbNumber: map['rub_el_hizb_number'],
        rukuNumber: map['ruku_number'],
        manzilNumber: map['manzil_number'],
        sajdahNumber: map['sajdah_number'],
        pageNumber: map['page_number'],
        juzNumber: map['juz_number'],
        textUthmani: map['text_uthmani'],
        transliteration: map['transliteration'],
        translation: map['translation']);
  }

  static Future<List<Ayah>?> getAyahsWithTranslationsBySurahId(
      int surahId) async {
    Database database = await SQLite.getDatabase(QuranDatabase.dbName);

    List<Map<String, dynamic>> ayahsQuery = await database.rawQuery('''
      SELECT * FROM Ayah
      JOIN AyahTranslation
        ON AyahTranslation.ayah_id = Ayah.id
      WHERE Ayah.surah_id = ?
    ''', [surahId]);
    database.close();

    return ayahsQuery.isNotEmpty
        ? ayahsQuery.map((ayah) => Ayah.fromMap(ayah)).toList()
        : null;
  }

  static Future<Ayah?> getAyahWithTranslationById(int ayahId) async {
    Database database = await SQLite.getDatabase(QuranDatabase.dbName);

    List<Map<String, dynamic>> ayahQuery = await database.rawQuery('''
      SELECT * FROM Ayah
      JOIN AyahTranslation
        ON AyahTranslation.ayah_id = Ayah.id
      WHERE Ayah.id = ?
    ''', [ayahId]);
    database.close();

    return ayahQuery.isNotEmpty ? Ayah.fromMap(ayahQuery.first) : null;
  }
}
