import 'package:flutter/material.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/widgets/surah_name.dart';
import 'package:quran/src/features/read/tilawah/tilawah_page.dart';
import 'package:quran/src/features/read/translation/translation_page.dart';

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
            leading: const Icon(Icons.import_contacts_outlined),
            contentPadding: EdgeInsets.zero,
            title: const Text("Tilawah"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TilawahPage(surah: surah)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_edu),
            contentPadding: EdgeInsets.zero,
            title: const Text("Terjemahan"),
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
