class VerseTiming {
  final String verseKey;
  final int timestampFrom;
  final int timestampTo;
  final int duration;
  final List<List<int>> segments;

  VerseTiming({
    required this.verseKey,
    required this.timestampFrom,
    required this.timestampTo,
    required this.duration,
    required this.segments,
  });

  factory VerseTiming.fromJson(Map<String, dynamic> json) {
    List<List<int>> segmentsList = [];
    if (json['segments'] != null) {
      json['segments'].forEach((v) {
        segmentsList.add(List<int>.from(v));
      });
    }
    return VerseTiming(
      verseKey: json['verse_key'],
      timestampFrom: json['timestamp_from'],
      timestampTo: json['timestamp_to'],
      duration: json['duration'],
      segments: segmentsList,
    );
  }
}
