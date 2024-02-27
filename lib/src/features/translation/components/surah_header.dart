import 'package:flutter/material.dart';
import 'package:quran/src/models/surah.dart';

class SurahHeader extends StatelessWidget {
  final Surah surah;
  const SurahHeader({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [Text(surah.nameSimple)]),
    );
  }
}
