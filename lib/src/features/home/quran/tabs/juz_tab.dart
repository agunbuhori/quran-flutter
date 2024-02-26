import 'package:flutter/material.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/models/juz.dart';
import 'package:quran/src/features/home/quran/components/list_detail.dart';
import 'package:quran/src/features/home/quran/components/number_frame.dart';
import 'package:sqflite/sqflite.dart';

class JuzTab extends StatefulWidget {
  const JuzTab({super.key});

  @override
  State<JuzTab> createState() => _JuzTabState();
}

class _JuzTabState extends State<JuzTab> {
  List<Juz> juzs = [];

  @override
  initState() {
    super.initState();
    fetchJuzs();
  }

  Future<void> fetchJuzs() async {
    Database database = await SQLite.getDatabase();

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
                "Mulai dari ${ayahs.first['name_simple']} ayat ${ayahs.first['ayah_number']}");
        tempJuzs.add(juz);
      }

      setState(() {
        juzs = tempJuzs;
      });
    }
  }

  Widget juzBuilder(BuildContext context, int index) {
    Juz juz = juzs[index];
    return InkWell(
      child: Container(
        color:
            index % 2 == 1 ? Colors.black.withOpacity(0.1) : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              NumberFrame(number: juz.number),
              ListDetail(title: "Juz ${juz.number}", subtitle: juz.startFrom)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: juzBuilder, itemCount: juzs.length);
  }
}
