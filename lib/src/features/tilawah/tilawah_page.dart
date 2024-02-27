import 'package:flutter/material.dart';
import 'package:quran/src/common/consts/local_assets.dart';
import 'package:quran/src/features/tilawah/components/pressable_image.dart';
import 'package:quran/src/models/surah.dart';

class TilawahPage extends StatefulWidget {
  final Surah surah;
  const TilawahPage({super.key, required this.surah});

  @override
  State<TilawahPage> createState() => _TilawahPageState();
}

class _TilawahPageState extends State<TilawahPage> {
  late PageController pageController =
      PageController(initialPage: widget.surah.pageStart - 1);

  Map<String, dynamic>? findDataByCoordinate(double x, double y) {
    return null; // Jika tidak ada data yang cocok
  }

  Widget renderPage(BuildContext contex, int index) {
    return Container(
      child: Center(
          child: Stack(children: [
        PressableImage(
          imageAssetPath: LocalAssets.getQuranPage(index + 1),
          onTap: (x, y) {
            findDataByCoordinate(x, y);
          },
        ),
      ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Baca")),
        body: PageView.builder(
            controller: pageController,
            reverse: true,
            itemBuilder: renderPage,
            itemCount: 604));
  }
}
