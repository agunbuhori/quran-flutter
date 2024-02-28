import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:quran/src/common/helpers/json_loader.dart';
import 'package:quran/src/features/translation/components/bismillah.dart';
import 'package:quran/src/json_models/page_json.dart';
import 'package:quran/src/models/surah.dart';
import 'package:preload_page_view/preload_page_view.dart';

class TilawahPage extends StatefulWidget {
  final Surah surah;
  const TilawahPage({super.key, required this.surah});

  @override
  State<TilawahPage> createState() => _TilawahPageState();
}

class _TilawahPageState extends State<TilawahPage> {
  late PreloadPageController pageController =
      PreloadPageController(initialPage: widget.surah.pageStart - 1);

  Future<List<QuranVerse>> loadSurahs(int page) async {
    List<QuranVerse> result = await loadListDataFromJson<QuranVerse>(
        "assets/json/pages/page_${page}_data.json", (result) {
      return QuranVerse.fromJson(result);
    });

    return result;
  }

  Widget renderPage(BuildContext contex, List<QuranVerse> verses, int page) {
    print("Page $page loaded");
    if (verses.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      late List<Widget> ayahLines = [];

      late List<QuranWord> words = [];

      for (var verse in verses) {
        for (var word in verse.words) {
          words.add(word);
        }
      }

      for (int p = 0; p < 15; p++) {
        List<QuranWord> filteredWords =
            words.where((element) => element.lineNumber == p + 1).toList();

        if (filteredWords.isNotEmpty) {
          String line = words
              .where((element) => element.lineNumber == p + 1)
              .toList()
              .map((e) => e.codeV2)
              .join("");

          ayahLines.add(AutoSizeText(line,
              maxLines: 1,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: "Medina$page",
                  fontSize: 26,
                  height: 1.8,
                  letterSpacing: 3.5)));
        } else {
          ayahLines.add(const Bismillah());
        }
      }

      ayahLines.add(Center(child: Text(page.toString())));

      return Center(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: ayahLines),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Baca")),
        body: PreloadPageView.builder(
            controller: pageController,
            reverse: true,
            itemBuilder: (BuildContext context, index) {
              return FutureBuilder(
                  future: loadSurahs(index + 1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      List<QuranVerse> data = snapshot.data!;
                      return renderPage(context, data, index + 1);
                    }
                  });
            },
            itemCount: 604));
  }
}
