import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:quran/src/common/consts/databases.dart';
import 'package:quran/src/common/consts/getx_tags.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/features/translation/components/bismillah.dart';
import 'package:quran/src/features/translation/components/surah_header.dart';
import 'package:quran/src/models/ayah.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/widgets/ayah_option_modal.dart';
import 'package:quran/src/widgets/jump_to_ayah_modal.dart';
import 'package:quran/src/widgets/ayah_translation.dart';
import 'package:quran/src/widgets/quran_player.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sqflite/sqflite.dart';

class TranslationPage extends StatefulWidget {
  final Surah surah;

  const TranslationPage({super.key, required this.surah});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  late Surah surah;
  List<Ayah> ayahs = [];
  Ayah? playAyahAudio;
  int? highlightedAyahNumber;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    surah = widget.surah;
    loadAyahs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void highlightAyah(ayahNumber) {
    if (mounted) {
      setState(() {
        highlightedAyahNumber = ayahNumber;
      });

      final scrollToIndex = ayahNumber + (surah.bismillahPre == 1 ? 1 : 0);

      itemScrollController.scrollTo(
          index: scrollToIndex, duration: const Duration(milliseconds: 300));
    }
  }

  Future<void> loadAyahs() async {
    Database database = await SQLite.getDatabase(QuranDatabase.dbName);

    List<Ayah>? ayahsQuery =
        await Ayah.getAyahsWithTranslationsBySurahId(surah.id);

    setState(() {
      ayahs = ayahsQuery ?? [];
      if (playAyahAudio != null) {
        closeQuranPlayer();
      }
    });

    database.close();
  }

  void jumpToAyah() {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return JumpToAyahModal(
          surah: surah,
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  void openQuranPlayer(Ayah ayah) async {
    Navigator.of(context).pop();
    setState(() {
      playAyahAudio = ayah;
    });
  }

  void closeQuranPlayer() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        return setState(() {
          playAyahAudio = null;
          highlightedAyahNumber = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 114 - surah.id,
      length: Get.find<List<Surah>>(tag: GetxTags.surahs).length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Terjemah"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.move_down_outlined),
              onPressed: () {
                jumpToAyah();
                // Perform action when search icon is pressed
              },
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            onTap: (value) async {
              surah = Get.find<List<Surah>>(tag: GetxTags.surahs)
                  .firstWhere((e) => e.id == 114 - value);

              await loadAyahs();
              itemScrollController.scrollTo(
                index: 0,
                duration: const Duration(milliseconds: 300),
              );
            },
            tabs: Get.find<List<Surah>>(tag: GetxTags.surahs)
                .map((e) => Tab(text: "${e.id}. ${e.nameComplex}"))
                .toList()
                .reversed
                .toList(),
          ),
        ),
        body: Stack(
          children: [
            ScrollablePositionedList.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: ayahs.length + (surah.bismillahPre == 1 ? 2 : 1),
              itemPositionsListener: itemPositionsListener,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SurahHeader(surah: surah);
                }

                bool hasBismillah = surah.bismillahPre == 1;

                if (hasBismillah && index == 1) {
                  return const Bismillah();
                }

                Ayah ayah = ayahs[index - (hasBismillah ? 2 : 1)];
                return InkWell(
                    onTap: () {
                      if (highlightedAyahNumber == null) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return AyahOptionModal(
                                  surah: surah,
                                  ayah: ayah,
                                  onPlayAudio: () {
                                    openQuranPlayer(ayah);
                                  });
                            });
                      }
                    },
                    child: AyahTranslation(
                      highlight: highlightedAyahNumber == ayah.ayahNumber,
                      ayah: ayah,
                      number: index + 1,
                    ));
              },
              itemScrollController: itemScrollController,
            ),
            if (playAyahAudio != null)
              Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: QuranPlayer(
                      surah: surah,
                      onAyahCaptured: (ayahNumber) {
                        highlightAyah(ayahNumber);
                      },
                      onClose: () {
                        closeQuranPlayer();
                      },
                      title: "${surah.id}. ${surah.nameComplex}",
                      subtitle:
                          "Ayat $highlightedAyahNumber/${surah.ayahsCount}"))
          ],
        ),
      ),
    );
  }
}
