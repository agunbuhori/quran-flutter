import 'package:flutter/material.dart';

class SurahName extends StatelessWidget {
  final String text;
  final double? size = 30;

  const SurahName({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontFamily: 'SuraNames', fontSize: size));
  }
}
