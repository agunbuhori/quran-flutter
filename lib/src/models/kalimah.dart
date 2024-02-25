import 'package:sqflite/sqflite.dart';

class Kalimah {
  int id;
  int ayahId;
  String ayahKey;
  int position;
  String? audioUrl;
  String location;
  String textUthmani;
  String codeV1;
  String codeV2;
  String qpcUthmaniHafs;
  String charTypeName;
  int pageNumberV1;
  int pageNumberV2;
  int lineNumberV1;
  int lineNumberV2;
  String translation;
  String? transliteration;

  Kalimah({
    required this.id,
    required this.ayahId,
    required this.ayahKey,
    required this.position,
    this.audioUrl,
    required this.location,
    required this.textUthmani,
    required this.codeV1,
    required this.codeV2,
    required this.qpcUthmaniHafs,
    required this.charTypeName,
    required this.pageNumberV1,
    required this.pageNumberV2,
    required this.lineNumberV1,
    required this.lineNumberV2,
    required this.translation,
    this.transliteration,
  });

  // Konversi objek Kalimah menjadi Map untuk penyimpanan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ayah_id': ayahId,
      'ayah_key': ayahKey,
      'position': position,
      'audio_url': audioUrl,
      'location': location,
      'text_uthmani': textUthmani,
      'code_v1': codeV1,
      'code_v2': codeV2,
      'qpc_uthmani_hafs': qpcUthmaniHafs,
      'char_type_name': charTypeName,
      'page_number_v1': pageNumberV1,
      'page_number_v2': pageNumberV2,
      'line_number_v1': lineNumberV1,
      'line_number_v2': lineNumberV2,
      'translation': translation,
      'transliteration': transliteration,
    };
  }

  // Konversi Map menjadi objek Kalimah
  factory Kalimah.fromMap(Map<String, dynamic> map) {
    return Kalimah(
      id: map['id'],
      ayahId: map['ayah_id'],
      ayahKey: map['ayah_key'],
      position: map['position'],
      audioUrl: map['audio_url'],
      location: map['location'],
      textUthmani: map['text_uthmani'],
      codeV1: map['code_v1'],
      codeV2: map['code_v2'],
      qpcUthmaniHafs: map['qpc_uthmani_hafs'],
      charTypeName: map['char_type_name'],
      pageNumberV1: map['page_number_v1'],
      pageNumberV2: map['page_number_v2'],
      lineNumberV1: map['line_number_v1'],
      lineNumberV2: map['line_number_v2'],
      translation: map['translation'],
      transliteration: map['transliteration'],
    );
  }
  // Tambahan operasi CRUD lainnya dapat ditambahkan sesuai kebutuhan
}
