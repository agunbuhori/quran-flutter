import 'package:quran/src/models/verse_timing.dart';

class RecitationTimes {
  final int id;
  final int chapterId;
  final double fileSize;
  final String format;
  final String audioUrl;
  final int duration;
  final List<VerseTiming> verseTimings;

  RecitationTimes({
    required this.id,
    required this.chapterId,
    required this.fileSize,
    required this.format,
    required this.audioUrl,
    required this.duration,
    required this.verseTimings,
  });

  factory RecitationTimes.fromJson(Map<String, dynamic> json) {
    List<VerseTiming> verseTimingsList = [];
    if (json['verse_timings'] != null) {
      json['verse_timings'].forEach((v) {
        verseTimingsList.add(VerseTiming.fromJson(v));
      });
    }
    return RecitationTimes(
      id: json['id'],
      chapterId: json['chapter_id'],
      fileSize: json['file_size'],
      format: json['format'],
      audioUrl: json['audio_url'],
      duration: json['duration'],
      verseTimings: verseTimingsList,
    );
  }
}
