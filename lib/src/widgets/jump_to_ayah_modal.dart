import 'package:flutter/material.dart';
import 'package:quran/src/models/surah.dart';

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
