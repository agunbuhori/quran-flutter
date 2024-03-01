import 'package:flutter/material.dart';
import 'package:quran/src/models/ayah.dart';
import 'package:quran/src/widgets/ayah_arabic.dart';
import 'package:quran/src/widgets/clickable_sup_text.dart';
import 'package:quran/src/features/translation/components/ayah_frame.dart';

class AyahTranslation extends StatelessWidget {
  final Ayah ayah;
  final bool? highlight;
  final int number;
  const AyahTranslation(
      {super.key, required this.ayah, required this.number, this.highlight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: highlight == true
              ? Theme.of(context).highlightColor
              : Colors.transparent),
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
                      child: AyahArabic(
                        text: ayah.textUthmani,
                        ayahNumber: ayah.ayahNumber,
                      )),
                  const SizedBox(height: 10),
                  ClickableSupText(
                      text: ayah.translation ?? "", onTap: (id) {}),
                ])),
          ],
        ),
      ),
    );
  }
}
