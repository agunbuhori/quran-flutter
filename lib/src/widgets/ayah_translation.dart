import 'package:flutter/material.dart';
import 'package:quran/src/models/ayah.dart';
import 'package:quran/src/widgets/clickable_sup_text.dart';
import 'package:quran/src/features/translation/components/ayah_frame.dart';

class AyahTranslation extends StatelessWidget {
  final Ayah ayah;
  final int number;
  const AyahTranslation({super.key, required this.ayah, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ayah.ayahNumber % 2 == 0
          ? Colors.black.withOpacity(0.2)
          : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AyahFrame(number: ayah.ayahNumber),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        ayah.textUthmani,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                            fontSize: 26, height: 1.85, fontFamily: 'Hafs'),
                      )),
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
