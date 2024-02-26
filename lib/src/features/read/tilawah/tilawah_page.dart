import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          child: Image.asset(
        'assets/images/quran/tilawah/page${(index + 1).toString().padLeft(3, '0')}.png', // Path to your image asset
        fit: BoxFit.cover, // Adjust how the image fits into the container
      )),
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
