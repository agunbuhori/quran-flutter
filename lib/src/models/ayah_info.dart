class AyahInfo {
  final int glyphId;
  final int pageNumber;
  final int lineNumber;
  final int suraNumber;
  final int ayahNumber;
  final int position;
  final int minX;
  final int maxX;
  final int minY;
  final int maxY;

  AyahInfo({
    required this.glyphId,
    required this.pageNumber,
    required this.lineNumber,
    required this.suraNumber,
    required this.ayahNumber,
    required this.position,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
  });

  factory AyahInfo.fromMap(Map<String, dynamic> map) {
    return AyahInfo(
      glyphId: map['glyph_id'],
      pageNumber: map['page_number'],
      lineNumber: map['line_number'],
      suraNumber: map['sura_number'],
      ayahNumber: map['ayah_number'],
      position: map['position'],
      minX: map['min_x'],
      maxX: map['max_x'],
      minY: map['min_y'],
      maxY: map['max_y'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'glyph_id': glyphId,
      'page_number': pageNumber,
      'line_number': lineNumber,
      'sura_number': suraNumber,
      'ayah_number': ayahNumber,
      'position': position,
      'min_x': minX,
      'max_x': maxX,
      'min_y': minY,
      'max_y': maxY,
    };
  }
}
