import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/src/common/consts/getx_tags.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/widgets/surah_name.dart';

class JumpToAyahModal extends StatefulWidget {
  final Surah surah;
  final Function(int surahId, int ayahNumber)? onGo;

  const JumpToAyahModal({super.key, required this.surah, this.onGo});

  @override
  State<JumpToAyahModal> createState() => _JumpToAyahModalState();
}

class _JumpToAyahModalState extends State<JumpToAyahModal> {
  late int selectedSurah = widget.surah.id;
  late int selectedAyahNumber = 1;

  @override
  void initState() {
    super.initState();
  }

  int getSelectedSurah() {
    return Get.find<List<Surah>>(tag: GetxTags.surahs)
        .firstWhere((element) => element.id == selectedSurah)
        .ayahsCount;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Pergi ke ayat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          DropdownButton<int>(
            isExpanded: true,
            value: selectedSurah,
            items: Get.find<List<Surah>>(tag: GetxTags.surahs)
                .map((e) => DropdownMenuItem<int>(
                      value: e.id,
                      child: Row(children: [
                        Text("${e.id}. ${e.nameComplex}"),
                        const Spacer(),
                        SurahName(text: e.id.toString().padLeft(3, '0'))
                      ]),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedSurah = value;
                });
              }
              // Handle onChanged event here
            },
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                selectedAyahNumber = int.parse(value);
              });
            },
            decoration: InputDecoration(hintText: "1 - ${getSelectedSurah()}"),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {
                widget.onGo?.call(selectedSurah, selectedAyahNumber);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                minimumSize: const Size(double.infinity,
                    0), // Set button width to fill available horizontal space
              ),
              child: const Text("Pergi"))
        ],
      ),
    );
  }
}
