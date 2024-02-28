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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Baca")),
        body: PageView.builder(
            controller: pageController,
            reverse: true,
            itemBuilder: (BuildContext context, index) {
              return PressableImage(
                  page: index + 1,
                  imageAssetPath: LocalAssets.getQuranPage(index + 1));
            },
            itemCount: 604));
  }
}
