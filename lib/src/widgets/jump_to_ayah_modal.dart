import 'package:flutter/material.dart';
import 'package:quran/src/models/surah.dart';

class JumpToAyahModal extends StatefulWidget {
  final Surah surah;

  const JumpToAyahModal({super.key, required this.surah});

  @override
  State<JumpToAyahModal> createState() => _JumpToAyahModalState();
}

class _JumpToAyahModalState extends State<JumpToAyahModal> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }
}
