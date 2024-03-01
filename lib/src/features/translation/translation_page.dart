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

class _TranslationPageState extends State<TranslationPage>
    with SingleTickerProviderStateMixin {
  late Surah _surah;
  List<Ayah> _ayahs = [];
  Ayah? _playAyahAudio;
  int? _highlightedAyahNumber;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _surah = widget.surah;
    _tabController = TabController(
        length: 114, vsync: this, initialIndex: 114 - widget.surah.id);
    loadAyahs();
  }

  void highlightAyah(ayahNumber) {
    if (mounted) {
      setState(() {
        _highlightedAyahNumber = ayahNumber;
      });

      final scrollToIndex = ayahNumber + (_surah.bismillahPre == 1 ? 1 : 0);

      _itemScrollController.jumpTo(index: scrollToIndex);
    }
  }

  Future<void> loadAyahs() async {
    Database database = await SQLite.getDatabase(QuranDatabase.dbName);

    List<Ayah>? ayahsQuery =
        await Ayah.getAyahsWithTranslationsBySurahId(_surah.id);

    setState(() {
      _ayahs = ayahsQuery ?? [];
      if (_playAyahAudio != null) {
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
          surah: _surah,
          onGo: (surahId, ayahNumber) async {
            if (surahId == _surah.id) {
              _itemScrollController.jumpTo(index: ayahNumber + 1);
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
              _surah = Get.find<List<Surah>>(tag: GetxTags.surahs)
                  .firstWhere((e) => e.id == surahId);
              _tabController.animateTo(114 - surahId);

              loadAyahs();

              Future.delayed(const Duration(microseconds: 1000), () {
                _itemScrollController.jumpTo(index: ayahNumber + 1);
              });
            }
          },
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
      _playAyahAudio = ayah;
    });
  }

  void closeQuranPlayer() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        return setState(() {
          _playAyahAudio = null;
          _highlightedAyahNumber = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          controller: _tabController,
          isScrollable: true,
          onTap: (value) async {
            _surah = Get.find<List<Surah>>(tag: GetxTags.surahs)
                .firstWhere((e) => e.id == 114 - value);

            await loadAyahs();
            _itemScrollController.scrollTo(
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
      body: Column(
        children: [
          Expanded(
            child: ScrollablePositionedList.builder(
              itemCount: _ayahs.length + (_surah.bismillahPre == 1 ? 2 : 1),
              itemPositionsListener: _itemPositionsListener,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SurahHeader(surah: _surah);
                }

                bool hasBismillah = _surah.bismillahPre == 1;

                if (hasBismillah && index == 1) {
                  return const Bismillah();
                }

                Ayah ayah = _ayahs[index - (hasBismillah ? 2 : 1)];
                return InkWell(
                    onTap: () {
                      if (_highlightedAyahNumber == null) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return AyahOptionModal(
                                  surah: _surah,
                                  ayah: ayah,
                                  onPlayAudio: () {
                                    openQuranPlayer(ayah);
                                  });
                            });
                      }
                    },
                    child: AyahTranslation(
                      highlight: _highlightedAyahNumber == ayah.ayahNumber,
                      ayah: ayah,
                      number: index + 1,
                    ));
              },
              itemScrollController: _itemScrollController,
            ),
          ),
          if (_playAyahAudio != null)
            QuranPlayer(
                surah: _surah,
                onAyahCaptured: (ayahNumber) {
                  highlightAyah(ayahNumber);
                },
                onClose: () {
                  closeQuranPlayer();
                },
                title: "${_surah.id}. ${_surah.nameComplex}",
                subtitle: "Ayat $_highlightedAyahNumber/${_surah.ayahsCount}")
        ],
      ),
    );
  }
}
