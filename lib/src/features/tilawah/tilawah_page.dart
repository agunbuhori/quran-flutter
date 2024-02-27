import 'package:flutter/material.dart';
import 'package:quran/src/common/consts/local_assets.dart';
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

  Widget renderPage(BuildContext contex, int index) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Stack(children: [
        Image.asset(
          LocalAssets.getQuranPage(index + 1), // Path to your image asset
          fit: BoxFit.cover, // Adjust how the image fits into the container
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
