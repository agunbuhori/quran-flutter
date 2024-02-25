import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran/src/components/ayah_translation.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/models/ayah.dart';
import 'package:quran/src/models/kalimah.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/screens/read/translation/components/ayah_selector_modal.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sqflite/sqflite.dart';

class TranslationPage extends StatefulWidget {
  final Surah surah;

  const TranslationPage({super.key, required this.surah});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  List<Ayah> ayahs = [];
  List<Kalimah> kalimahs = [];

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  void initState() {
    super.initState();
    loadAyahs();
  }

  Future<void> loadAyahs() async {
    Database database = await SQLite.getDatabase();
    List<Map<String, dynamic>> ayahsQuery = await database.rawQuery('''
          SELECT *, AyahTranslation.* FROM Ayah
          JOIN AyahTranslation
            ON AyahTranslation.ayah_id = Ayah.id
            WHERE surah_id = ${widget.surah.id}
        ''');

    List<Ayah> tempAyahs = ayahsQuery.map((e) => Ayah.fromMap(e)).toList();

    setState(() {
      ayahs = tempAyahs;
    });
  }

  Widget renderAyah(BuildContext context, int index) {
    Ayah ayah = ayahs[index];
    return Column(
      children: [
        AyahTranslation(
          ayah: ayah,
          number: index + 1,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.surah.nameComplex)),
      body: ScrollablePositionedList.builder(
        itemCount: ayahs.length,
        itemBuilder: renderAyah,
        itemScrollController: itemScrollController,
        scrollOffsetController: scrollOffsetController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetListener: scrollOffsetListener,
      ),
    );
  }
}
