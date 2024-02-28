import 'package:flutter/material.dart';
import 'package:quran/src/features/tafseer/tafseer_page.dart';
import 'package:quran/src/models/ayah.dart';
import 'package:quran/src/models/surah.dart';

class AyahOptionModal extends StatefulWidget {
  final Surah surah;
  final Ayah ayah;
  const AyahOptionModal({super.key, required this.surah, required this.ayah});

  @override
  State<AyahOptionModal> createState() => _AyahOptionModalState();
}

class _AyahOptionModalState extends State<AyahOptionModal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  "${widget.surah.nameComplex} ayat ${widget.ayah.ayahNumber}"),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.chrome_reader_mode_rounded),
            title: const Text('Baca Tafsir'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TafseerPage(
                          ayah: widget.ayah,
                          surahName: widget.surah.nameComplex)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_add_rounded),
            title: const Text('Tandai Terakhir Dibaca'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.play_circle),
            title: const Text('Putar Audio'),
            onTap: () {
              // Handle the delete action
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_copy),
            title: const Text('Salin Ayat'),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Sebarkan Ayat'),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
        ],
      ),
    );
  }
}
