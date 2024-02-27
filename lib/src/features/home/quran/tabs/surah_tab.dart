import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:quran/src/common/consts/getx_tags.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/widgets/surah_name.dart';
import 'package:quran/src/features/home/quran/components/list_detail.dart';
import 'package:quran/src/features/home/quran/components/number_frame.dart';
import 'package:quran/src/features/home/quran/components/read_surah_option_modal.dart';

class SurahTab extends StatefulWidget {
  const SurahTab({super.key});

  @override
  State<SurahTab> createState() => _SurahTabState();
}

class _SurahTabState extends State<SurahTab> {
  List<Surah> surahs = Get.find(tag: GetxTags.surahs);
  List<Surah> filteredSurahs = Get.find(tag: GetxTags.surahs);

  searchSurahs(String value) async {
    setState(() {
      filteredSurahs = surahs
          .where((item) =>
              item.nameSimple.toLowerCase().contains(value.toLowerCase()) ||
              item.nameIndonesian.toLowerCase().contains(value.toLowerCase()) ||
              item.id.toString() == value)
          .toList();
    });
  }

  void onSurahClicked(Surah surah) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ReadSurahOptionModal(
          surah: surah,
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  Widget renderSurahItem(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            onChanged: searchSurahs,
            decoration: const InputDecoration(
              hintText: 'Cari nama atau nomor surat',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ));
    }

    Surah surah = filteredSurahs[index - 1];

    return InkWell(
        onTap: () {
          onSurahClicked(surah);
        },
        child: Container(
          color: index % 2 == 1
              ? Colors.black.withOpacity(0.1)
              : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NumberFrame(number: surah.id),
                ListDetail(
                    title: surah.nameComplex, subtitle: surah.nameIndonesian),
                const Spacer(),
                SurahName(text: surah.id.toString().padLeft(3, '0'))
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => renderSurahItem(context, index),
      itemCount: filteredSurahs.length + 1,
    );
  }
}
