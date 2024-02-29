import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:quran/src/common/consts/getx_tags.dart';
import 'package:quran/src/common/consts/quran_database.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/features/translation/components/bismillah.dart';
import 'package:quran/src/features/translation/components/surah_header.dart';
import 'package:quran/src/models/ayah.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/widgets/ayah_option_modal.dart';
import 'package:quran/src/widgets/custom_modal.dart';
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
  bool audioIsPlaying = false;
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    surah = widget.surah;
    loadAyahs();
  }

  Future<void> loadAyahs() async {
    Database database = await SQLite.getDatabase(QuranDatabase.dbName);

    List<Map<String, dynamic>> ayahsQuery = await database.rawQuery('''
      SELECT *, AyahTranslation.* FROM Ayah
      JOIN AyahTranslation ON AyahTranslation.ayah_id = Ayah.id
      WHERE surah_id = ?
    ''', [surah.id]);

    setState(() {
      ayahs = ayahsQuery.map((e) => Ayah.fromMap(e)).toList();
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

  void openQuranPlayer() async {
    Navigator.of(context).pop();
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return CustomModal(
            child: QuranPlayer(
              title: "${surah.id}. ${surah.nameComplex}",
              subtitle: "Memutar audio",
              onClose: () {
                closeQuranPlayer();
              },
              url:
                  "https://download.quranicaudio.com/qdc/mishari_al_afasy/murattal/${surah.id}.mp3",
            ),
          );
        },
      );
    });
  }

  void closeQuranPlayer() {}

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
        body: ScrollablePositionedList.builder(
          itemCount: ayahs.length + (surah.bismillahPre == 1 ? 2 : 1),
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
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SurahReadingModeModal(
                            surah: surah,
                            ayah: ayah,
                            onPlayAudio: () {
                              openQuranPlayer();
                            });
                      });
                },
                child: AyahTranslation(
                  ayah: ayah,
                  number: index + 1,
                ));
          },
          itemScrollController: itemScrollController,
        ),
      ),
    );
  }
}
