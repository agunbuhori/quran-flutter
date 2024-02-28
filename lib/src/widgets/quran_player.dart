import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class QuranPlayer extends StatefulWidget {
  final String url;
  final Function onClose;
  final String title;
  final String subtitle;
  const QuranPlayer(
      {super.key,
      required this.url,
      required this.onClose,
      required this.title,
      required this.subtitle});

  @override
  State<QuranPlayer> createState() => _QuranPlayerState();
}

class _QuranPlayerState extends State<QuranPlayer> {
  final player = AudioPlayer();
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    playAudio();
  }

  @override
  void dispose() {
    stopAudio();
    super.dispose();
    widget.onClose();
  }

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

  Future<void> playAudio() async {
    await player.play(UrlSource(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.subtitle)
            ]),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      !isPaused ? pauseAudio() : resumeAudio();
                    },
                    icon: Icon(isPaused ? Icons.play_arrow : Icons.pause)),
                IconButton(
                    onPressed: () {
                      stopAudio();
                      widget.onClose();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.stop_circle)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
