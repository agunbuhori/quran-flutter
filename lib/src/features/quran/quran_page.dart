import 'package:flutter/material.dart';
import 'package:quran/src/features/quran/components/history_tab.dart';
import 'package:quran/src/features/quran/components/juz_tab.dart';
import 'package:quran/src/features/quran/components/surah_tab.dart';

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
    const HistoryTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Quran Tadabbur"),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
              bottom: const TabBar(tabs: [
                Tab(text: "Surat"),
                Tab(text: "Juz"),
                Tab(text: "Riwayat"),
              ]),
            ),
            body: TabBarView(children: tabs)));
  }
}
