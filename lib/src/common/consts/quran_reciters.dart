abstract class QuranReciter {
  String get name;
  String get audioUrl;
  String get timingsUrl;
}

class AbuBakarShatri implements QuranReciter {
  @override
  String get name => "Abu Bakr As-Shatri";

  @override
  String get audioUrl =>
      "https://download.quranicaudio.com/qdc/abu_bakr_shatri/murattal/{chapter}.mp3";

  @override
  String get timingsUrl =>
      "https://api.qurancdn.com/api/qdc/audio/reciters/4/audio_files?chapter={chapter}&segments=true";
}
