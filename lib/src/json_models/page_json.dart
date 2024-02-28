class QuranVerse {
  final int chapterId;
  final int hizbNumber;
  final int juzNumber;
  final List<QuranWord> words;

  QuranVerse(
      {required this.chapterId,
      required this.hizbNumber,
      required this.juzNumber,
      required this.words});

  factory QuranVerse.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonWords = json['words'];
    List<QuranWord> words =
        jsonWords.map((wordJson) => QuranWord.fromJson(wordJson)).toList();

    return QuranVerse(
      chapterId: json['chapter_id'],
      hizbNumber: json['hizb_number'],
      juzNumber: json['juz_number'],
      words: words,
    );
  }
}

class QuranWord {
  final String codeV2;
  final int pageNumber;
  final int lineNumber;

  QuranWord({
    required this.codeV2,
    required this.pageNumber,
    required this.lineNumber,
  });

  factory QuranWord.fromJson(Map<String, dynamic> json) {
    return QuranWord(
      codeV2: json['code_v2'],
      pageNumber: json['page_number'],
      lineNumber: json['line_number'],
    );
  }
}
