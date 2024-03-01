class QuranAudioFilesDTO {
  List<AudioFileDTO> audioFiles;

  QuranAudioFilesDTO({required this.audioFiles});

  factory QuranAudioFilesDTO.fromJson(Map<String, dynamic> json) {
    List<dynamic> audioFilesJson = json['audio_files'] ?? [];
    List<AudioFileDTO> audioFiles = audioFilesJson
        .map((audioFileJson) => AudioFileDTO.fromJson(audioFileJson))
        .toList();
    return QuranAudioFilesDTO(audioFiles: audioFiles);
  }
}

class AudioFileDTO {
  int id;
  int chapterId;
  int fileSize;
  String format;
  String audioUrl;
  int duration;
  List<VerseTimingDTO> verseTimings;

  AudioFileDTO({
    required this.id,
    required this.chapterId,
    required this.fileSize,
    required this.format,
    required this.audioUrl,
    required this.duration,
    required this.verseTimings,
  });

  factory AudioFileDTO.fromJson(Map<String, dynamic> json) {
    List<dynamic> verseTimingsJson = json['verse_timings'] ?? [];
    List<VerseTimingDTO> verseTimings = verseTimingsJson
        .map((verseTimingJson) => VerseTimingDTO.fromJson(verseTimingJson))
        .toList();
    return AudioFileDTO(
      id: json['id'],
      chapterId: json['chapter_id'],
      fileSize: json['file_size'],
      format: json['format'],
      audioUrl: json['audio_url'],
      duration: json['duration'],
      verseTimings: verseTimings,
    );
  }
}

class VerseTimingDTO {
  String verseKey;
  int timestampFrom;
  int timestampTo;
  int duration;
  List<List<int>> segments;

  VerseTimingDTO({
    required this.verseKey,
    required this.timestampFrom,
    required this.timestampTo,
    required this.duration,
    required this.segments,
  });

  factory VerseTimingDTO.fromJson(Map<String, dynamic> json) {
    List<dynamic> segmentsJson = json['segments'] ?? [];
    List<List<int>> segments =
        segmentsJson.map((segmentJson) => List<int>.from(segmentJson)).toList();
    return VerseTimingDTO(
      verseKey: json['verse_key'],
      timestampFrom: json['timestamp_from'],
      timestampTo: json['timestamp_to'],
      duration: json['duration'],
      segments: segments,
    );
  }
}
