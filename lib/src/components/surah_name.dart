import 'package:flutter/material.dart';

class SurahName extends StatelessWidget {
  final String text;
  final double? size;

  const SurahName({super.key, required this.text, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontFamily: 'SuraNames', fontSize: size ?? 30));
  }
}
