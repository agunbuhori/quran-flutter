import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quran/src/common/consts/ayah_info_database.dart';
import 'package:quran/src/common/consts/local_assets.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/features/tilawah/components/ayah_highlighter.dart';
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
  late Widget higlights = const Stack();

  List<double> convertToScreenCoordinate(
      int minX, int minY, int maxX, int maxY) {
    double imageWidth = 1024;
    double imageHeight = 1657;
    double screenWidth = 393;
    double screenHeight = 636.88;

    // Calculate scaling factors
    double scaleX = screenWidth / imageWidth;
    double scaleY = screenHeight / imageHeight;

    // Scale coordinates
    double scaledMinX = minX * scaleX;
    double scaledMinY = minY * scaleY;
    double scaledMaxX = maxX * scaleX;
    double scaledMaxY = maxY * scaleY;

    return [scaledMinX, scaledMinY, scaledMaxX, scaledMaxY];
  }

  Future<void> searchTheSameGlyphs(int suraNumber, int ayahNumber) async {
    Database database = await SQLite.getDatabase(AyahInfoDatabase.dbName);
    List<Map<String, dynamic>> glyphsQuery = await database.query('glyphs',
        where: "sura_number = ? AND ayah_number = ?",
        whereArgs: [suraNumber, ayahNumber]);

    if (glyphsQuery.isNotEmpty) {
      List<Widget> temps = [];

      for (var g in glyphsQuery) {
        List<double> scaled = convertToScreenCoordinate(
            g['min_x'], g['min_y'], g['max_x'], g['max_y']);

        temps.add(Positioned(
          child: CustomPaint(
            painter: AyahHighlighter(
                minX: scaled[0],
                minY: scaled[1],
                maxX: scaled[2],
                maxY: scaled[3]),
          ),
        ));

        setState(() {
          higlights = Stack(children: temps);
        });
      }
    }
  }

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
      searchTheSameGlyphs(
          glyphsQuery.first['sura_number'], glyphsQuery.first['ayah_number']);
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
              return Center(
                child: Stack(
                  children: [
                    PressableImage(
                        imageAssetPath: LocalAssets.getQuranPage(index + 1),
                        onTap: (x, y) {
                          searchGlyphs(x, y, index + 1);
                        }),
                    Positioned(child: higlights)
                  ],
                ),
              );
            },
            itemCount: 604));
  }
}
