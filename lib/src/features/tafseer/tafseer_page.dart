import 'package:flutter/material.dart';
import 'package:quran/src/common/consts/quran_database.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/models/ayah.dart';
import 'package:quran/src/widgets/ayah_arabic.dart';
import 'package:quran/src/widgets/clickable_sup_text.dart';
import 'package:sqflite/sqflite.dart';

class TafseerPage extends StatefulWidget {
  final Ayah ayah;
  final String surahName;
  const TafseerPage({super.key, required this.ayah, required this.surahName});

  @override
  State<TafseerPage> createState() => _TafseerPageState();
}

class _TafseerPageState extends State<TafseerPage> {
  late Ayah ayah;
  late String surahName;

  @override
  void initState() {
    super.initState();
    ayah = widget.ayah;
    surahName = widget.surahName;
  }

  Future<void> moveAyah(int ayahId) async {
    Database database = await SQLite.getDatabase(QuranDatabase.dbName);
    List<Map<String, dynamic>> ayahQuery = await database.rawQuery('''
          SELECT *, Surah.name_complex as surah_name FROM Ayah
          JOIN Surah
            ON Surah.id = Ayah.surah_id
          JOIN AyahTranslation
            ON AyahTranslation.ayah_id = Ayah.id
          WHERE Ayah.id = ?
        ''', [ayahId]);

    if (ayahQuery.isNotEmpty) {
      setState(() {
        surahName = ayahQuery.first['surah_name'];
        ayah = Ayah.fromMap(ayahQuery.first);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Baca Tafsir")),
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey, // warna border
                width: 1.0, // lebar border
              ),
            ),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
              icon: const Icon(Icons.chevron_left_outlined),
              onPressed: () {
                if (ayah.id < 6236) {
                  moveAyah(ayah.id + 1);
                }
              },
            ),
            Text("$surahName ${ayah.ayahNumber}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.chevron_right_outlined),
              onPressed: () {
                if (ayah.id > 1) {
                  moveAyah(ayah.id - 1);
                }
              },
            ),
          ]),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AyahArabic(
                    text: ayah.textUthmani,
                    ayahNumber: ayah.ayahNumber,
                  ),
                  const SizedBox(height: 18),
                  ClickableSupText(text: ayah.translation ?? ""),
                ],
              )),
        ))
      ]),
    );
  }
}
