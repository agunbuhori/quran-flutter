import 'package:flutter/material.dart';
import 'package:quran/src/features/translation/translation_page.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/widgets/surah_name.dart';
import 'package:quran/src/features/tilawah/tilawah_page.dart';

class ReadSurahOptionModal extends StatelessWidget {
  final Surah surah;
  const ReadSurahOptionModal({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: SurahName(
                  size: 36,
                  text: "${surah.id.toString().padLeft(3, '0')} surah")),
          Text(
            "${surah.id}. ${surah.nameSimple}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
              "${surah.revelationPlace == 'makkah' ? 'Makkiyah' : 'Madaniyah'} . ${surah.ayahsCount} ayat"),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_rounded),
            contentPadding: EdgeInsets.zero,
            title: const Text("Mushaf Madinah"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TilawahPage(surah: surah)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted_rounded),
            contentPadding: EdgeInsets.zero,
            title: const Text("Baca Per-baris"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TranslationPage(surah: surah)));
            },
          ),
        ],
      ),
    );
  }
}
