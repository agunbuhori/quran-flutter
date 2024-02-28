import 'package:flutter/material.dart';
import 'package:quran/src/common/consts/ayah_info_database.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/features/tilawah/components/ayah_highlighter.dart';
import 'package:quran/src/models/ayah_info.dart';
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
  late Widget highlights = const SizedBox();
  // final Function(double x, double y) onTap;

  List<double> convertToScreenCoordinate(
      int minX, int minY, int maxX, int maxY) {
    double imageWidth = 1024;
    double imageHeight = 1656;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = screenWidth * (imageHeight / imageWidth);

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

  Future<List<AyahInfo>> searchGlyphsByTheSameAyah(
      int suraNumber, int ayahNumber) async {
    Database database = await SQLite.getDatabase(AyahInfoDatabase.dbName);
    List<Map<String, dynamic>> glyphsQuery = await database.query('glyphs',
        where: "sura_number = ? AND ayah_number = ?",
        whereArgs: [suraNumber, ayahNumber]);

    return glyphsQuery.map((e) => AyahInfo.fromMap(e)).toList();
  }

  int findTheHighestY(List<AyahInfo> ayahInfos) {
    int highest = ayahInfos.first.minY;

    for (var ayahInfo in ayahInfos) {
      if (ayahInfo.minY < highest) {
        highest = ayahInfo.minY;
      }
    }

    return highest;
  }

  int findTheNearestX(List<AyahInfo> ayahInfos) {
    int nearest = ayahInfos.first.minX;

    for (var ayahInfo in ayahInfos) {
      if (ayahInfo.minX < nearest) {
        nearest = ayahInfo.minX;
      }
    }

    return nearest;
  }

  int findTheFartestX(List<AyahInfo> ayahInfos) {
    int fartest = ayahInfos.first.maxX;

    for (var ayahInfo in ayahInfos) {
      if (ayahInfo.minX > fartest) {
        fartest = ayahInfo.maxX;
      }
    }

    return fartest;
  }

  int findTheLowestY(List<AyahInfo> ayahInfos) {
    int lowest = ayahInfos.first.maxY;

    for (var ayahInfo in ayahInfos) {
      if (ayahInfo.maxY > lowest) {
        lowest = ayahInfo.maxY;
      }
    }

    return lowest;
  }

  List<List<AyahInfo>> extractLines(List<AyahInfo> ayahInfos) {
    List<List<AyahInfo>> groupedGlyphs = [];

    int lineNumber = -1;
    int index = -1;

    for (var ayahInfo in ayahInfos) {
      if (lineNumber != ayahInfo.lineNumber) {
        index += 1;
        lineNumber = ayahInfo.lineNumber;
        groupedGlyphs.add([]);
        groupedGlyphs[index].add(ayahInfo);
      } else {
        groupedGlyphs[index].add(ayahInfo);
      }
    }

    return groupedGlyphs;
  }

  Widget drawLine(List<AyahInfo> lines) {
    int nearestX = findTheNearestX(lines);
    int fartestX = findTheFartestX(lines);
    int lowestY = findTheLowestY(lines);
    int highestY = findTheHighestY(lines);
    List<double> scaled =
        convertToScreenCoordinate(nearestX, lowestY, fartestX, highestY);
    return Positioned(
        child: CustomPaint(
      painter: AyahHighlighter(
          minX: scaled[0], minY: scaled[1], maxX: scaled[2], maxY: scaled[3]),
    ));
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
      Map<String, dynamic> result = glyphsQuery.first;
      List<List<AyahInfo>> lines = extractLines(await searchGlyphsByTheSameAyah(
          result['sura_number'], result['ayah_number']));

      List<Widget> drawnLines = [];
      for (var line in lines) {
        drawnLines.add(drawLine(line));
      }

      setState(() {
        highlights = Stack(children: drawnLines);
      });
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
              fit: BoxFit.fitWidth, // Mengisi gambar ke dalam kontainer
            ),
          ),
          highlights
        ],
      ),
    );
  }
}
