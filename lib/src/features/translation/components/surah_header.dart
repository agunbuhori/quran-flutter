import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/widgets/surah_name.dart';

class SurahHeader extends StatelessWidget {
  final Surah surah;
  const SurahHeader({super.key, required this.surah});

  double getHeightFromWidth(
      double originalWidth, double originalHeight, double newWidth) {
    double aspectRatio = originalWidth / originalHeight;
    double newHeight = newWidth / aspectRatio;

    return newHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeightFromWidth(
          504, 54, MediaQuery.of(context).size.width.toDouble()),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/quran/surah_frame.svg",
              fit: BoxFit.fitHeight, // Adjust as needed
            ),
          ),
          Center(
            child: SurahName(
              size: 28,
              text: "${surah.id.toString().padLeft(3, '0')}surah",
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
