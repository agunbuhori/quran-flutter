import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/models/ayah.dart';
import 'package:quran/src/models/kalimah.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/widgets/ayah_translation.dart';
import 'package:quran/src/widgets/surah_name.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sqflite/sqflite.dart';

class TranslationPage extends StatefulWidget {
  final Surah surah;

  const TranslationPage({super.key, required this.surah});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  late Surah surah = widget.surah;
  List<Surah> surahs = Get.find(tag: 'surahs');
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
    loadAyahs(widget.surah.id);
  }

  Future<void> loadAyahs(int id) async {
    Database database = await SQLite.getDatabase();

    List<Map<String, dynamic>> ayahsQuery = await database.rawQuery('''
          SELECT *, AyahTranslation.* FROM Ayah
          JOIN AyahTranslation
            ON AyahTranslation.ayah_id = Ayah.id
            WHERE surah_id = $id
        ''');

    List<Ayah> tempAyahs = ayahsQuery.map((e) => Ayah.fromMap(e)).toList();

    setState(() {
      ayahs = tempAyahs;
      surah = surahs.where((e) => e.id == id).first;
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
    return DefaultTabController(
        initialIndex: 114 - surah.id,
        length: surahs.length,
        child: Scaffold(
          appBar: AppBar(
            title:
                SurahName(text: "${surah.id.toString().padLeft(3, '0')}surah"),
            bottom: TabBar(
                isScrollable: true,
                onTap: (value) {
                  loadAyahs(114 - value);
                },
                tabs: surahs
                    .map((e) => Tab(text: "${e.id}. ${e.nameComplex}"))
                    .toList()
                    .reversed
                    .toList()),
          ),
          body: ScrollablePositionedList.builder(
            itemCount: ayahs.length,
            itemBuilder: renderAyah,
            itemScrollController: itemScrollController,
            scrollOffsetController: scrollOffsetController,
            itemPositionsListener: itemPositionsListener,
            scrollOffsetListener: scrollOffsetListener,
          ),
        ));
  }
}
