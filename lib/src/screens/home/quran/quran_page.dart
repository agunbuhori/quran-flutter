import 'package:flutter/material.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/screens/home/quran/tabs/juz_tab.dart';
import 'package:quran/src/screens/home/quran/tabs/surah_tab.dart';
import 'package:sqflite/sqflite.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  int index = 0;
  List<Widget> tabs = [
    const SurahTab(),
    const JuzTab(),
    const SurahTab(),
  ];

  @override
  void initState() {
    super.initState();
    loadSurahs();
  }

  Future<void> loadSurahs() async {
    Database conn = await SQLite.getDatabase();
    conn.query("Surah");

    print("Loaded already");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Quran Tadabbur"),
              bottom: const TabBar(tabs: [
                Tab(text: "Surat"),
                Tab(text: "Juz"),
                Tab(text: "Riwayat"),
              ]),
            ),
            body: TabBarView(children: tabs)));
  }
}
