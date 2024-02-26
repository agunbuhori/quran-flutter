import 'package:flutter/material.dart';
import 'package:quran/src/features/read/translation/components/searchable_dropdown.dart';

class AyahSelectorModal extends StatefulWidget {
  const AyahSelectorModal({super.key});

  @override
  State<AyahSelectorModal> createState() => _AyahSelectorModalState();
}

class _AyahSelectorModalState extends State<AyahSelectorModal> {
  // Sample data for the selectboxes
  final List<String> surahNumbers = ['1', '2', '3']; // Assuming surah numbers
  final List<String> ayahNumbers = ['1', '2', '3']; // Assuming ayah numbers

  String? selectedSurah;
  String? selectedAyah;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Selectbox for Surah
          SearchableDropdown(
            hint: const Text('Select Surah'),
            value: selectedSurah,
            onChanged: (String? value) => setState(() => selectedSurah = value),
            items: surahNumbers
                .map((String number) => DropdownMenuItem<String>(
                      value: number,
                      child: Text('Surah $number'),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10.0),
          // Selectbox for Ayah
          SearchableDropdown(
            hint: const Text('Select Ayah'),
            value: selectedAyah,
            onChanged: (String? value) => setState(() => selectedAyah = value),
            items: ayahNumbers
                .map((String number) => DropdownMenuItem<String>(
                      value: number,
                      child: Text('Ayah $number'),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10.0),
          // Button to close the modal
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
