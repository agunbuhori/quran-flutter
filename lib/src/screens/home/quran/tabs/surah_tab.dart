import 'package:flutter/material.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/components/surah_name.dart';
import 'package:sqflite/sqflite.dart';

class SurahTab extends StatefulWidget {
  const SurahTab({super.key});

  @override
  State<SurahTab> createState() => _SurahTabState();
}

class _SurahTabState extends State<SurahTab> {
  List<Surah> surahs = [];
  List<Surah> filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    loadSurahs();
  }

  Future<void> loadSurahs() async {
    Database conn = await SQLite.getDatabase();

    List<Map<String, dynamic>> result = await conn.query("Surah");

    setState(() {
      surahs = result.map((map) => Surah.fromMap(map)).toList();
      filteredSurahs = [...surahs];
    });
  }

  void searchSurahs(String value) async {
    setState(() {
      filteredSurahs = surahs
          .where((item) =>
              item.nameSimple.toLowerCase().contains(value.toLowerCase()) ||
              item.id.toString() == value)
          .toList();
    });
  }

  Widget renderSurahItem(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            onChanged: searchSurahs,
            decoration: const InputDecoration(
              hintText: 'Cari nama atau nomor surat',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ));
    }

    Surah surah = filteredSurahs[index - 1];

    return InkWell(
        onTap: () {},
        child: Container(
          color: index % 2 == 1
              ? Colors.black.withOpacity(0.1)
              : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SurahFrame(number: surah.id),
                SurahDetail(
                    title: surah.nameComplex, subtitle: surah.nameIndonesian),
                const Spacer(),
                SurahName(text: surah.id.toString().padLeft(3, '0'))
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (surahs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemBuilder: renderSurahItem, itemCount: filteredSurahs.length + 1);
  }
}

class SurahFrame extends StatelessWidget {
  final int number;
  const SurahFrame({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/quran/frame.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Text(
          number.toString(),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        )));
  }
}

class SurahDetail extends StatelessWidget {
  final String title;
  final String subtitle;

  const SurahDetail({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle)
        ],
      ),
    );
  }
}
