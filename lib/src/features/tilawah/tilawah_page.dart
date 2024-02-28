import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:quran/src/common/consts/local_assets.dart';
import 'package:quran/src/features/tilawah/components/pressable_image.dart';
import 'package:quran/src/models/ayah.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/widgets/ayah_option_modal.dart';

class TilawahPage extends StatefulWidget {
  final Surah surah;
  const TilawahPage({super.key, required this.surah});

  @override
  State<TilawahPage> createState() => _TilawahPageState();
}

class _TilawahPageState extends State<TilawahPage> {
  late PreloadPageController pageController =
      PreloadPageController(initialPage: widget.surah.pageStart - 1);

  void showAyahOption(Surah surah, Ayah ayah) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Baca")),
        body: PreloadPageView.builder(
            controller: pageController,
            preloadPagesCount: 5,
            reverse: true,
            itemBuilder: (BuildContext context, index) {
              return PressableImage(
                page: index + 1,
                imageAssetPath: LocalAssets.getQuranPage(index + 1),
                onSurahAyahFound: (results) {
                  if (results.isNotEmpty) {
                    showAyahOption(
                        Surah.fromMap(results[0]), Ayah.fromMap(results[1]));
                  }
                },
              );
            },
            itemCount: 604));
  }
}
