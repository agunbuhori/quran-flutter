import 'package:realm/realm.dart';

part 'realm_models.g.dart';

@RealmModel()
class _Chapter {
  // Chapter model definition
  @PrimaryKey()
  @MapTo('index')
  late int index;

  late String arabicTitle;

  late String englishTitle;

  late String topic;

  late String searchText;

  late String unicode;

  late String keywords;

  late bool makkiyah;

  late double y;

  late List<_Verse> verses;

  late _ChapterHeader? header;
}

@RealmModel()
class _ChapterHeader {
  // ChapterHeader model definition
  late _Chapter? chapter;

  late _Page? page;

  late double x;

  late double y;

  late double width;

  late double height;
}

@RealmModel()
class _LineFragment {
  // LineFragment model definition
  late _Verse? verse;

  late double x;

  late double y;

  late double width;

  late double height;
}

@RealmModel()
class _Page {
  // Page model definition
  @PrimaryKey()
  @MapTo('index')
  late int index;

  late String lessons;

  late List<_Verse> verses;

  late List<_Chapter> chapters;

  late _Part? part;

  late _Quarter? quarter;

  late List<_ChapterHeader> chapterHeaders;
}

@RealmModel()
class _Part {
  // Part model definition
  @PrimaryKey()
  @MapTo('index')
  late int index;

  late String arabicTitle;

  late List<_Verse> verses;

  late List<_Chapter> chapters;

  late List<_Quarter> quarters;
}

@RealmModel()
class _Quarter {
  // Quarter model definition
  @PrimaryKey()
  @MapTo('index')
  late int index;

  late String arabicTitle;

  late String englishTitle;

  late String unicode;

  late List<_Verse> verses;
}

@RealmModel()
class _Verse {
  // Verse model definition
  @PrimaryKey()
  @MapTo('index')
  late int index;

  late int numberInChapter;

  late String uthmanicText;

  late String text;

  late String cleanText;

  late String searchText;

  late String unicode;

  late String numberInChapterUnicode;

  late _Page? page;

  late _Chapter? chapter;

  late _Quarter? quarter;

  late _Part? part;

  late int section;

  late double x;

  late double y;

  late List<_LineFragment> lineFragments;
}
