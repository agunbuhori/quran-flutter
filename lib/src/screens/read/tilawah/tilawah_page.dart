import 'package:flutter/material.dart';
import 'package:quran/src/models/surah.dart';

class TilawahPage extends StatefulWidget {
  final Surah surah;
  const TilawahPage({super.key, required this.surah});

  @override
  State<TilawahPage> createState() => _TilawahPageState();
}

class _TilawahPageState extends State<TilawahPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.surah.nameSimple)),
    );
  }
}
