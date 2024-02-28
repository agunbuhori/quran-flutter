import 'package:flutter/material.dart';
import 'package:quran/src/common/consts/ayah_info_database.dart';
import 'package:quran/src/common/consts/local_assets.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/features/tilawah/components/pressable_image.dart';
import 'package:quran/src/models/surah.dart';
import 'package:sqflite/sqflite.dart';

class TilawahPage extends StatefulWidget {
  final Surah surah;
  const TilawahPage({super.key, required this.surah});

  @override
  State<TilawahPage> createState() => _TilawahPageState();
}

class _TilawahPageState extends State<TilawahPage> {
  late PageController pageController =
      PageController(initialPage: widget.surah.pageStart - 1);

  Future<void> searchGlyphs(double x, double y, int page) async {
    Database database = await SQLite.getDatabase(AyahInfoDatabase.dbName);
    List<Map<String, dynamic>> glyphsQuery = await database.rawQuery('''
      SELECT * FROM glyphs
      WHERE page_number = ?
      AND min_x <= ?
      AND min_y <= ?
      AND max_x >= ?
      AND max_y >= ?
    ''', [page, x, y, x, y]);

    if (glyphsQuery.isNotEmpty) {
      print(glyphsQuery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Baca")),
        body: PageView.builder(
            controller: pageController,
            reverse: true,
            itemBuilder: (BuildContext context, index) {
              return PressableImage(
                  imageAssetPath: LocalAssets.getQuranPage(index + 1),
                  onTap: (x, y) {
                    searchGlyphs(x, y, index + 1);
                  });
            },
            itemCount: 604));
  }
}
