import 'package:flutter/material.dart';
import 'package:quran/src/components/clickable_sup_text.dart';
import 'package:quran/src/models/ayah.dart';

class AyahTranslation extends StatelessWidget {
  final Ayah ayah;
  final int number;
  const AyahTranslation({super.key, required this.ayah, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color:
          ayah.id % 2 == 0 ? Colors.black.withOpacity(0.2) : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 30, child: Text(ayah.ayahNumber.toString())),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  Text(
                    ayah.textUthmani,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 26,
                        fontFamily: 'Hafs',
                        height: 1.85),
                  ),
                  const SizedBox(height: 10),
                  ClickableSupText(
                      text: ayah.translation ?? "", onFootnotePressed: (id) {}),
                ])),
          ],
        ),
      ),
    );
  }
}
