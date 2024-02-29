import 'package:flutter/material.dart';

class AyahArabic extends StatelessWidget {
  final String text;
  final int ayahNumber;
  const AyahArabic({super.key, required this.text, required this.ayahNumber});

  String westernToArabicIndic(int number) {
    List<String> arabicIndicNumerals = [
      "٠",
      "١",
      "٢",
      "٣",
      "٤",
      "٥",
      "٦",
      "٧",
      "٨",
      "٩"
    ];
    String result = '';

    // Convert each digit of the number
    while (number > 0) {
      int digit = number % 10;
      result = arabicIndicNumerals[digit] + result;
      number ~/= 10; // Integer division to move to the next digit
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.right,
        style: const TextStyle(fontFamily: 'LPMQ', fontSize: 22, height: 2.5));
  }
}
