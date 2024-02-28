import 'package:quran/src/common/consts/quran_database.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:sqflite/sqflite.dart';

class Surah {
  int id;
  String revelationPlace;
  int revelationOrder;
  int bismillahPre;
  String nameSimple;
  String nameComplex;
  String nameArabic;
  String nameIndonesian;
  int ayahsCount;
  int pageStart;
  int pageEnd;

  Surah({
    required this.id,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.nameIndonesian,
    required this.ayahsCount,
    required this.pageStart,
    required this.pageEnd,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'revelation_place': revelationPlace,
      'revelation_order': revelationOrder,
      'bismillah_pre': bismillahPre,
      'name_simple': nameSimple,
      'name_complex': nameComplex,
      'name_arabic': nameArabic,
      'name_indonesian': nameIndonesian,
      'ayahs_count': ayahsCount,
      'page_start': pageStart,
      'page_end': pageEnd,
    };
  }

  static Surah fromMap(Map<String, dynamic> map) {
    return Surah(
      id: map['id'],
      revelationPlace: map['revelation_place'],
      revelationOrder: map['revelation_order'],
      bismillahPre: map['bismillah_pre'],
      nameSimple: map['name_simple'],
      nameComplex: map['name_complex'],
      nameArabic: map['name_arabic'],
      nameIndonesian: map['name_indonesian'],
      ayahsCount: map['ayahs_count'],
      pageStart: map['page_start'],
      pageEnd: map['page_end'],
    );
  }

  static Future<List<Surah>> getAll() async {
    Database database = await SQLite.getDatabase(QuranDatabase.dbName);
    List<Map<String, dynamic>> query = await database.query('Surah');
    database.close();

    return query.map((e) => Surah.fromMap(e)).toList();
  }
}
