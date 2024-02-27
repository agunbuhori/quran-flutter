import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:quran/src/common/consts/getx_tags.dart';
import 'package:quran/src/models/juz.dart';
import 'package:quran/src/features/home/quran/components/list_detail.dart';
import 'package:quran/src/features/home/quran/components/number_frame.dart';

class JuzTab extends StatefulWidget {
  const JuzTab({super.key});

  @override
  State<JuzTab> createState() => _JuzTabState();
}

class _JuzTabState extends State<JuzTab> {
  List<Juz> juzs = Get.find(tag: GetxTags.juzs);

  Widget juzBuilder(BuildContext context, int index) {
    Juz juz = juzs[index];
    return InkWell(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              NumberFrame(number: juz.number),
              ListDetail(title: "Juz ${juz.number}", subtitle: juz.startFrom)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: juzBuilder, itemCount: juzs.length);
  }
}
