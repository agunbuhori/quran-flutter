import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quran/src/api/services/quran_reciter_service.dart';
import 'package:quran/src/common/consts/quran_reciters.dart';
import 'package:quran/src/models/verse_timing.dart';

class QuranPlayer extends StatefulWidget {
  final int surahId;
  final Function onClose;
  final Function(Duration duration)? onPositionChanged;
  final Function(int ayahId)? onAyahCaptured;
  final String title;
  final String subtitle;

  const QuranPlayer(
      {super.key,
      required this.onClose,
      required this.title,
      required this.subtitle,
      this.onPositionChanged,
      required this.surahId,
      this.onAyahCaptured});

  @override
  State<QuranPlayer> createState() => _QuranPlayerState();
}

class _QuranPlayerState extends State<QuranPlayer> {
  final player = AudioPlayer();
  bool isPaused = false;
  QuranReciterService quranReciterService = QuranReciterService();
  final AbuBakarShatri _abuBakarShatri = AbuBakarShatri();
  late String currentVerseKey = "${widget.surahId}:1";

  @override
  void initState() {
    super.initState();
    playAudio();
  }

  // @override
  // void dispose() {
  //   stopAudio();
  //   super.dispose();
  //   widget.onClose();
  // }

  void stopAudio() {
    player.stop();
  }

  void pauseAudio() {
    player.pause();
    setState(() {
      isPaused = true;
    });
  }

  void resumeAudio() {
    player.resume();
    setState(() {
      isPaused = false;
    });
  }

  int getAyahId(String verseKey) {
    return int.parse(verseKey.split(':').elementAt(1));
  }

  void searchVerseByTimestamp(List<VerseTiming> verseTimings, int timestamp) {
    VerseTiming verseTiming = verseTimings.firstWhere((verseTiming) =>
        verseTiming.timestampFrom <= timestamp &&
        verseTiming.timestampTo >= timestamp);

    if (verseTiming.verseKey != currentVerseKey) {
      setState(() {
        currentVerseKey = verseTiming.verseKey;
      });
      widget.onAyahCaptured?.call(getAyahId(verseTiming.verseKey));
    }
  }

  Future<void> playAudio() async {
    quranReciterService.getRecitationTimes(widget.surahId).then((value) async {
      await player.play(UrlSource(_abuBakarShatri.audioUrl
          .replaceAll("{chapter}", widget.surahId.toString())));

      widget.onAyahCaptured?.call(getAyahId(currentVerseKey));

      player.onPositionChanged.listen((Duration position) {
        searchVerseByTimestamp(value.verseTimings, position.inMilliseconds);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          maxHeight: 200), // Adjust the maxHeight as needed
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.subtitle),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            !isPaused ? pauseAudio() : resumeAudio();
                          },
                          icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                        ),
                        IconButton(
                          onPressed: () {
                            stopAudio();
                            widget.onClose();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
