import 'package:flutter/material.dart';

class SurahDetailHeader extends StatelessWidget {
  final String text;

  const SurahDetailHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600));
  }
}
