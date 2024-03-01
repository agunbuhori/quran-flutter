import 'package:flutter/material.dart';
import 'package:quran/src/features/translation/translation_page.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/widgets/surah_name.dart';
import 'package:quran/src/features/tilawah/tilawah_page.dart';

class JumpToAyahModal extends StatelessWidget {
  final Surah surah;

  const JumpToAyahModal({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Column(
        children: [],
      ),
    );
  }
}
