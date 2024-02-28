import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:quran/src/common/consts/getx_tags.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/features/translation/components/bismillah.dart';
import 'package:quran/src/features/translation/components/surah_header.dart';
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
  List<Surah> surahs = Get.find(tag: GetxTags.surahs);
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
    if (index == 0) {
      return SurahHeader(surah: surah);
    }

    late bool hasBismillah = surah.bismillahPre == 1;

    if (hasBismillah && index == 1) {
      return const Bismillah();
    }

    Ayah ayah = ayahs[index - (hasBismillah ? 2 : 1)];
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
            title: const Text("Terjemah"),
            bottom: TabBar(
                isScrollable: true,
                onTap: (value) async {
                  await loadAyahs(114 - value);
                  itemScrollController.scrollTo(
                      index: 0, duration: const Duration(milliseconds: 300));
                },
                tabs: surahs
                    .map((e) => Tab(text: "${e.id}. ${e.nameComplex}"))
                    .toList()
                    .reversed
                    .toList()),
          ),
          body: ScrollablePositionedList.builder(
            itemCount: ayahs.length + (surah.bismillahPre == 1 ? 2 : 1),
            itemBuilder: renderAyah,
            itemScrollController: itemScrollController,
            scrollOffsetController: scrollOffsetController,
            itemPositionsListener: itemPositionsListener,
            scrollOffsetListener: scrollOffsetListener,
          ),
        ));
  }
}
