import 'package:flutter/material.dart';
import 'package:quran/src/common/consts/ayah_info_database.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/features/tilawah/components/ayah_highlighter.dart';
import 'package:sqflite/sqflite.dart';

class PressableImage extends StatefulWidget {
  final String imageAssetPath;
  final int page;
  const PressableImage(
      {super.key, required this.imageAssetPath, required this.page});

  @override
  State<PressableImage> createState() => _PressableImage();
}

class _PressableImage extends State<PressableImage> {
  late Widget higlights = const SizedBox();
  // final Function(double x, double y) onTap;

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

  Future<void> searchGlyphs(double x, double y) async {
    Database database = await SQLite.getDatabase(AyahInfoDatabase.dbName);
    List<Map<String, dynamic>> glyphsQuery = await database.rawQuery('''
      SELECT * FROM glyphs
      WHERE page_number = ?
      AND min_x <= ?
      AND min_y <= ?
      AND max_x >= ?
      AND max_y >= ?
    ''', [widget.page, x, y, x, y]);

    if (glyphsQuery.isNotEmpty) {
      searchTheSameGlyphs(
          glyphsQuery.first['sura_number'], glyphsQuery.first['ayah_number']);
    }
  }

  // Function to transform coordinates based on the new MaxX
  List<double> transformCoordinates(double oldX, double oldY, double oldMaxX,
      double oldMaxY, double newMaxX) {
    double scaleX = newMaxX / oldMaxX;
    double newX = oldX * scaleX;
    double newY = oldY * scaleX;

    return [newX, newY];
  }

  double getCalculatedImageHeightByRatio(
      double width, double height, double newWidth) {
    double aspectRatio = width / height;
    double newHeight = newWidth / aspectRatio;

    return newHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTapDown: (details) {
              Image image = Image.asset(widget.imageAssetPath);
              image.image.resolve(ImageConfiguration.empty).addListener(
                ImageStreamListener((ImageInfo info, bool _) {
                  double imageWidth = info.image.width.toDouble();
                  double imageHeight = info.image.height.toDouble();
                  double screenWidth = MediaQuery.of(context).size.width;

                  double x =
                      (details.localPosition.dx / imageWidth) * imageWidth;
                  double y =
                      (details.localPosition.dy / imageHeight) * imageHeight;

                  double resizedImageHeight = getCalculatedImageHeightByRatio(
                      imageWidth, imageHeight, screenWidth);

                  List<double> transformed = transformCoordinates(
                      x, y, screenWidth, resizedImageHeight, 1024);
                  // why 1120?
                  // because on database refer to 1120 width image
                  searchGlyphs(
                      transformed.elementAt(0), transformed.elementAt(1));
                  // onTap(transformed.elementAt(0), transformed.elementAt(1));
                }),
              );
            },
            child: Image.asset(
              widget.imageAssetPath,
              width: MediaQuery.of(context)
                  .size
                  .width, // Lebar gambar mengikuti lebar layar
              fit: BoxFit.fill, // Mengisi gambar ke dalam kontainer
            ),
          ),
          higlights
        ],
      ),
    );
  }
}
