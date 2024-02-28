// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Chapter extends _Chapter with RealmEntity, RealmObjectBase, RealmObject {
  Chapter(
    int index,
    String arabicTitle,
    String englishTitle,
    String topic,
    String searchText,
    String unicode,
    String keywords,
    bool makkiyah,
    double y, {
    ChapterHeader? header,
    Iterable<Verse> verses = const [],
  }) {
    RealmObjectBase.set(this, 'index', index);
    RealmObjectBase.set(this, 'arabicTitle', arabicTitle);
    RealmObjectBase.set(this, 'englishTitle', englishTitle);
    RealmObjectBase.set(this, 'topic', topic);
    RealmObjectBase.set(this, 'searchText', searchText);
    RealmObjectBase.set(this, 'unicode', unicode);
    RealmObjectBase.set(this, 'keywords', keywords);
    RealmObjectBase.set(this, 'makkiyah', makkiyah);
    RealmObjectBase.set(this, 'y', y);
    RealmObjectBase.set(this, 'header', header);
    RealmObjectBase.set<RealmList<Verse>>(
        this, 'verses', RealmList<Verse>(verses));
  }

  Chapter._();

  @override
  int get index => RealmObjectBase.get<int>(this, 'index') as int;
  @override
  set index(int value) => RealmObjectBase.set(this, 'index', value);

  @override
  String get arabicTitle =>
      RealmObjectBase.get<String>(this, 'arabicTitle') as String;
  @override
  set arabicTitle(String value) =>
      RealmObjectBase.set(this, 'arabicTitle', value);

  @override
  String get englishTitle =>
      RealmObjectBase.get<String>(this, 'englishTitle') as String;
  @override
  set englishTitle(String value) =>
      RealmObjectBase.set(this, 'englishTitle', value);

  @override
  String get topic => RealmObjectBase.get<String>(this, 'topic') as String;
  @override
  set topic(String value) => RealmObjectBase.set(this, 'topic', value);

  @override
  String get searchText =>
      RealmObjectBase.get<String>(this, 'searchText') as String;
  @override
  set searchText(String value) =>
      RealmObjectBase.set(this, 'searchText', value);

  @override
  String get unicode => RealmObjectBase.get<String>(this, 'unicode') as String;
  @override
  set unicode(String value) => RealmObjectBase.set(this, 'unicode', value);

  @override
  String get keywords =>
      RealmObjectBase.get<String>(this, 'keywords') as String;
  @override
  set keywords(String value) => RealmObjectBase.set(this, 'keywords', value);

  @override
  bool get makkiyah => RealmObjectBase.get<bool>(this, 'makkiyah') as bool;
  @override
  set makkiyah(bool value) => RealmObjectBase.set(this, 'makkiyah', value);

  @override
  double get y => RealmObjectBase.get<double>(this, 'y') as double;
  @override
  set y(double value) => RealmObjectBase.set(this, 'y', value);

  @override
  RealmList<Verse> get verses =>
      RealmObjectBase.get<Verse>(this, 'verses') as RealmList<Verse>;
  @override
  set verses(covariant RealmList<Verse> value) =>
      throw RealmUnsupportedSetError();

  @override
  ChapterHeader? get header =>
      RealmObjectBase.get<ChapterHeader>(this, 'header') as ChapterHeader?;
  @override
  set header(covariant ChapterHeader? value) =>
      RealmObjectBase.set(this, 'header', value);

  @override
  Stream<RealmObjectChanges<Chapter>> get changes =>
      RealmObjectBase.getChanges<Chapter>(this);

  @override
  Chapter freeze() => RealmObjectBase.freezeObject<Chapter>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Chapter._);
    return const SchemaObject(ObjectType.realmObject, Chapter, 'Chapter', [
      SchemaProperty('index', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('arabicTitle', RealmPropertyType.string),
      SchemaProperty('englishTitle', RealmPropertyType.string),
      SchemaProperty('topic', RealmPropertyType.string),
      SchemaProperty('searchText', RealmPropertyType.string),
      SchemaProperty('unicode', RealmPropertyType.string),
      SchemaProperty('keywords', RealmPropertyType.string),
      SchemaProperty('makkiyah', RealmPropertyType.bool),
      SchemaProperty('y', RealmPropertyType.double),
      SchemaProperty('verses', RealmPropertyType.object,
          linkTarget: 'Verse', collectionType: RealmCollectionType.list),
      SchemaProperty('header', RealmPropertyType.object,
          optional: true, linkTarget: 'ChapterHeader'),
    ]);
  }
}

class ChapterHeader extends _ChapterHeader
    with RealmEntity, RealmObjectBase, RealmObject {
  ChapterHeader(
    double x,
    double y,
    double width,
    double height, {
    Chapter? chapter,
    Page? page,
  }) {
    RealmObjectBase.set(this, 'chapter', chapter);
    RealmObjectBase.set(this, 'page', page);
    RealmObjectBase.set(this, 'x', x);
    RealmObjectBase.set(this, 'y', y);
    RealmObjectBase.set(this, 'width', width);
    RealmObjectBase.set(this, 'height', height);
  }

  ChapterHeader._();

  @override
  Chapter? get chapter =>
      RealmObjectBase.get<Chapter>(this, 'chapter') as Chapter?;
  @override
  set chapter(covariant Chapter? value) =>
      RealmObjectBase.set(this, 'chapter', value);

  @override
  Page? get page => RealmObjectBase.get<Page>(this, 'page') as Page?;
  @override
  set page(covariant Page? value) => RealmObjectBase.set(this, 'page', value);

  @override
  double get x => RealmObjectBase.get<double>(this, 'x') as double;
  @override
  set x(double value) => RealmObjectBase.set(this, 'x', value);

  @override
  double get y => RealmObjectBase.get<double>(this, 'y') as double;
  @override
  set y(double value) => RealmObjectBase.set(this, 'y', value);

  @override
  double get width => RealmObjectBase.get<double>(this, 'width') as double;
  @override
  set width(double value) => RealmObjectBase.set(this, 'width', value);

  @override
  double get height => RealmObjectBase.get<double>(this, 'height') as double;
  @override
  set height(double value) => RealmObjectBase.set(this, 'height', value);

  @override
  Stream<RealmObjectChanges<ChapterHeader>> get changes =>
      RealmObjectBase.getChanges<ChapterHeader>(this);

  @override
  ChapterHeader freeze() => RealmObjectBase.freezeObject<ChapterHeader>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ChapterHeader._);
    return const SchemaObject(
        ObjectType.realmObject, ChapterHeader, 'ChapterHeader', [
      SchemaProperty('chapter', RealmPropertyType.object,
          optional: true, linkTarget: 'Chapter'),
      SchemaProperty('page', RealmPropertyType.object,
          optional: true, linkTarget: 'Page'),
      SchemaProperty('x', RealmPropertyType.double),
      SchemaProperty('y', RealmPropertyType.double),
      SchemaProperty('width', RealmPropertyType.double),
      SchemaProperty('height', RealmPropertyType.double),
    ]);
  }
}

class LineFragment extends _LineFragment
    with RealmEntity, RealmObjectBase, RealmObject {
  LineFragment(
    double x,
    double y,
    double width,
    double height, {
    Verse? verse,
  }) {
    RealmObjectBase.set(this, 'verse', verse);
    RealmObjectBase.set(this, 'x', x);
    RealmObjectBase.set(this, 'y', y);
    RealmObjectBase.set(this, 'width', width);
    RealmObjectBase.set(this, 'height', height);
  }

  LineFragment._();

  @override
  Verse? get verse => RealmObjectBase.get<Verse>(this, 'verse') as Verse?;
  @override
  set verse(covariant Verse? value) =>
      RealmObjectBase.set(this, 'verse', value);

  @override
  double get x => RealmObjectBase.get<double>(this, 'x') as double;
  @override
  set x(double value) => RealmObjectBase.set(this, 'x', value);

  @override
  double get y => RealmObjectBase.get<double>(this, 'y') as double;
  @override
  set y(double value) => RealmObjectBase.set(this, 'y', value);

  @override
  double get width => RealmObjectBase.get<double>(this, 'width') as double;
  @override
  set width(double value) => RealmObjectBase.set(this, 'width', value);

  @override
  double get height => RealmObjectBase.get<double>(this, 'height') as double;
  @override
  set height(double value) => RealmObjectBase.set(this, 'height', value);

  @override
  Stream<RealmObjectChanges<LineFragment>> get changes =>
      RealmObjectBase.getChanges<LineFragment>(this);

  @override
  LineFragment freeze() => RealmObjectBase.freezeObject<LineFragment>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(LineFragment._);
    return const SchemaObject(
        ObjectType.realmObject, LineFragment, 'LineFragment', [
      SchemaProperty('verse', RealmPropertyType.object,
          optional: true, linkTarget: 'Verse'),
      SchemaProperty('x', RealmPropertyType.double),
      SchemaProperty('y', RealmPropertyType.double),
      SchemaProperty('width', RealmPropertyType.double),
      SchemaProperty('height', RealmPropertyType.double),
    ]);
  }
}

class Page extends _Page with RealmEntity, RealmObjectBase, RealmObject {
  Page(
    int index,
    String lessons, {
    Part? part,
    Quarter? quarter,
    Iterable<Verse> verses = const [],
    Iterable<Chapter> chapters = const [],
    Iterable<ChapterHeader> chapterHeaders = const [],
  }) {
    RealmObjectBase.set(this, 'index', index);
    RealmObjectBase.set(this, 'lessons', lessons);
    RealmObjectBase.set(this, 'part', part);
    RealmObjectBase.set(this, 'quarter', quarter);
    RealmObjectBase.set<RealmList<Verse>>(
        this, 'verses', RealmList<Verse>(verses));
    RealmObjectBase.set<RealmList<Chapter>>(
        this, 'chapters', RealmList<Chapter>(chapters));
    RealmObjectBase.set<RealmList<ChapterHeader>>(
        this, 'chapterHeaders', RealmList<ChapterHeader>(chapterHeaders));
  }

  Page._();

  @override
  int get index => RealmObjectBase.get<int>(this, 'index') as int;
  @override
  set index(int value) => RealmObjectBase.set(this, 'index', value);

  @override
  String get lessons => RealmObjectBase.get<String>(this, 'lessons') as String;
  @override
  set lessons(String value) => RealmObjectBase.set(this, 'lessons', value);

  @override
  RealmList<Verse> get verses =>
      RealmObjectBase.get<Verse>(this, 'verses') as RealmList<Verse>;
  @override
  set verses(covariant RealmList<Verse> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<Chapter> get chapters =>
      RealmObjectBase.get<Chapter>(this, 'chapters') as RealmList<Chapter>;
  @override
  set chapters(covariant RealmList<Chapter> value) =>
      throw RealmUnsupportedSetError();

  @override
  Part? get part => RealmObjectBase.get<Part>(this, 'part') as Part?;
  @override
  set part(covariant Part? value) => RealmObjectBase.set(this, 'part', value);

  @override
  Quarter? get quarter =>
      RealmObjectBase.get<Quarter>(this, 'quarter') as Quarter?;
  @override
  set quarter(covariant Quarter? value) =>
      RealmObjectBase.set(this, 'quarter', value);

  @override
  RealmList<ChapterHeader> get chapterHeaders =>
      RealmObjectBase.get<ChapterHeader>(this, 'chapterHeaders')
          as RealmList<ChapterHeader>;
  @override
  set chapterHeaders(covariant RealmList<ChapterHeader> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Page>> get changes =>
      RealmObjectBase.getChanges<Page>(this);

  @override
  Page freeze() => RealmObjectBase.freezeObject<Page>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Page._);
    return const SchemaObject(ObjectType.realmObject, Page, 'Page', [
      SchemaProperty('index', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('lessons', RealmPropertyType.string),
      SchemaProperty('verses', RealmPropertyType.object,
          linkTarget: 'Verse', collectionType: RealmCollectionType.list),
      SchemaProperty('chapters', RealmPropertyType.object,
          linkTarget: 'Chapter', collectionType: RealmCollectionType.list),
      SchemaProperty('part', RealmPropertyType.object,
          optional: true, linkTarget: 'Part'),
      SchemaProperty('quarter', RealmPropertyType.object,
          optional: true, linkTarget: 'Quarter'),
      SchemaProperty('chapterHeaders', RealmPropertyType.object,
          linkTarget: 'ChapterHeader',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class Part extends _Part with RealmEntity, RealmObjectBase, RealmObject {
  Part(
    int index,
    String arabicTitle, {
    Iterable<Verse> verses = const [],
    Iterable<Chapter> chapters = const [],
    Iterable<Quarter> quarters = const [],
  }) {
    RealmObjectBase.set(this, 'index', index);
    RealmObjectBase.set(this, 'arabicTitle', arabicTitle);
    RealmObjectBase.set<RealmList<Verse>>(
        this, 'verses', RealmList<Verse>(verses));
    RealmObjectBase.set<RealmList<Chapter>>(
        this, 'chapters', RealmList<Chapter>(chapters));
    RealmObjectBase.set<RealmList<Quarter>>(
        this, 'quarters', RealmList<Quarter>(quarters));
  }

  Part._();

  @override
  int get index => RealmObjectBase.get<int>(this, 'index') as int;
  @override
  set index(int value) => RealmObjectBase.set(this, 'index', value);

  @override
  String get arabicTitle =>
      RealmObjectBase.get<String>(this, 'arabicTitle') as String;
  @override
  set arabicTitle(String value) =>
      RealmObjectBase.set(this, 'arabicTitle', value);

  @override
  RealmList<Verse> get verses =>
      RealmObjectBase.get<Verse>(this, 'verses') as RealmList<Verse>;
  @override
  set verses(covariant RealmList<Verse> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<Chapter> get chapters =>
      RealmObjectBase.get<Chapter>(this, 'chapters') as RealmList<Chapter>;
  @override
  set chapters(covariant RealmList<Chapter> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<Quarter> get quarters =>
      RealmObjectBase.get<Quarter>(this, 'quarters') as RealmList<Quarter>;
  @override
  set quarters(covariant RealmList<Quarter> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Part>> get changes =>
      RealmObjectBase.getChanges<Part>(this);

  @override
  Part freeze() => RealmObjectBase.freezeObject<Part>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Part._);
    return const SchemaObject(ObjectType.realmObject, Part, 'Part', [
      SchemaProperty('index', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('arabicTitle', RealmPropertyType.string),
      SchemaProperty('verses', RealmPropertyType.object,
          linkTarget: 'Verse', collectionType: RealmCollectionType.list),
      SchemaProperty('chapters', RealmPropertyType.object,
          linkTarget: 'Chapter', collectionType: RealmCollectionType.list),
      SchemaProperty('quarters', RealmPropertyType.object,
          linkTarget: 'Quarter', collectionType: RealmCollectionType.list),
    ]);
  }
}

class Quarter extends _Quarter with RealmEntity, RealmObjectBase, RealmObject {
  Quarter(
    int index,
    String arabicTitle,
    String englishTitle,
    String unicode, {
    Iterable<Verse> verses = const [],
  }) {
    RealmObjectBase.set(this, 'index', index);
    RealmObjectBase.set(this, 'arabicTitle', arabicTitle);
    RealmObjectBase.set(this, 'englishTitle', englishTitle);
    RealmObjectBase.set(this, 'unicode', unicode);
    RealmObjectBase.set<RealmList<Verse>>(
        this, 'verses', RealmList<Verse>(verses));
  }

  Quarter._();

  @override
  int get index => RealmObjectBase.get<int>(this, 'index') as int;
  @override
  set index(int value) => RealmObjectBase.set(this, 'index', value);

  @override
  String get arabicTitle =>
      RealmObjectBase.get<String>(this, 'arabicTitle') as String;
  @override
  set arabicTitle(String value) =>
      RealmObjectBase.set(this, 'arabicTitle', value);

  @override
  String get englishTitle =>
      RealmObjectBase.get<String>(this, 'englishTitle') as String;
  @override
  set englishTitle(String value) =>
      RealmObjectBase.set(this, 'englishTitle', value);

  @override
  String get unicode => RealmObjectBase.get<String>(this, 'unicode') as String;
  @override
  set unicode(String value) => RealmObjectBase.set(this, 'unicode', value);

  @override
  RealmList<Verse> get verses =>
      RealmObjectBase.get<Verse>(this, 'verses') as RealmList<Verse>;
  @override
  set verses(covariant RealmList<Verse> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Quarter>> get changes =>
      RealmObjectBase.getChanges<Quarter>(this);

  @override
  Quarter freeze() => RealmObjectBase.freezeObject<Quarter>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Quarter._);
    return const SchemaObject(ObjectType.realmObject, Quarter, 'Quarter', [
      SchemaProperty('index', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('arabicTitle', RealmPropertyType.string),
      SchemaProperty('englishTitle', RealmPropertyType.string),
      SchemaProperty('unicode', RealmPropertyType.string),
      SchemaProperty('verses', RealmPropertyType.object,
          linkTarget: 'Verse', collectionType: RealmCollectionType.list),
    ]);
  }
}

class Verse extends _Verse with RealmEntity, RealmObjectBase, RealmObject {
  Verse(
    int index,
    int numberInChapter,
    String uthmanicText,
    String text,
    String cleanText,
    String searchText,
    String unicode,
    String numberInChapterUnicode,
    int section,
    double x,
    double y, {
    Page? page,
    Chapter? chapter,
    Quarter? quarter,
    Part? part,
    Iterable<LineFragment> lineFragments = const [],
  }) {
    RealmObjectBase.set(this, 'index', index);
    RealmObjectBase.set(this, 'numberInChapter', numberInChapter);
    RealmObjectBase.set(this, 'uthmanicText', uthmanicText);
    RealmObjectBase.set(this, 'text', text);
    RealmObjectBase.set(this, 'cleanText', cleanText);
    RealmObjectBase.set(this, 'searchText', searchText);
    RealmObjectBase.set(this, 'unicode', unicode);
    RealmObjectBase.set(this, 'numberInChapterUnicode', numberInChapterUnicode);
    RealmObjectBase.set(this, 'page', page);
    RealmObjectBase.set(this, 'chapter', chapter);
    RealmObjectBase.set(this, 'quarter', quarter);
    RealmObjectBase.set(this, 'part', part);
    RealmObjectBase.set(this, 'section', section);
    RealmObjectBase.set(this, 'x', x);
    RealmObjectBase.set(this, 'y', y);
    RealmObjectBase.set<RealmList<LineFragment>>(
        this, 'lineFragments', RealmList<LineFragment>(lineFragments));
  }

  Verse._();

  @override
  int get index => RealmObjectBase.get<int>(this, 'index') as int;
  @override
  set index(int value) => RealmObjectBase.set(this, 'index', value);

  @override
  int get numberInChapter =>
      RealmObjectBase.get<int>(this, 'numberInChapter') as int;
  @override
  set numberInChapter(int value) =>
      RealmObjectBase.set(this, 'numberInChapter', value);

  @override
  String get uthmanicText =>
      RealmObjectBase.get<String>(this, 'uthmanicText') as String;
  @override
  set uthmanicText(String value) =>
      RealmObjectBase.set(this, 'uthmanicText', value);

  @override
  String get text => RealmObjectBase.get<String>(this, 'text') as String;
  @override
  set text(String value) => RealmObjectBase.set(this, 'text', value);

  @override
  String get cleanText =>
      RealmObjectBase.get<String>(this, 'cleanText') as String;
  @override
  set cleanText(String value) => RealmObjectBase.set(this, 'cleanText', value);

  @override
  String get searchText =>
      RealmObjectBase.get<String>(this, 'searchText') as String;
  @override
  set searchText(String value) =>
      RealmObjectBase.set(this, 'searchText', value);

  @override
  String get unicode => RealmObjectBase.get<String>(this, 'unicode') as String;
  @override
  set unicode(String value) => RealmObjectBase.set(this, 'unicode', value);

  @override
  String get numberInChapterUnicode =>
      RealmObjectBase.get<String>(this, 'numberInChapterUnicode') as String;
  @override
  set numberInChapterUnicode(String value) =>
      RealmObjectBase.set(this, 'numberInChapterUnicode', value);

  @override
  Page? get page => RealmObjectBase.get<Page>(this, 'page') as Page?;
  @override
  set page(covariant Page? value) => RealmObjectBase.set(this, 'page', value);

  @override
  Chapter? get chapter =>
      RealmObjectBase.get<Chapter>(this, 'chapter') as Chapter?;
  @override
  set chapter(covariant Chapter? value) =>
      RealmObjectBase.set(this, 'chapter', value);

  @override
  Quarter? get quarter =>
      RealmObjectBase.get<Quarter>(this, 'quarter') as Quarter?;
  @override
  set quarter(covariant Quarter? value) =>
      RealmObjectBase.set(this, 'quarter', value);

  @override
  Part? get part => RealmObjectBase.get<Part>(this, 'part') as Part?;
  @override
  set part(covariant Part? value) => RealmObjectBase.set(this, 'part', value);

  @override
  int get section => RealmObjectBase.get<int>(this, 'section') as int;
  @override
  set section(int value) => RealmObjectBase.set(this, 'section', value);

  @override
  double get x => RealmObjectBase.get<double>(this, 'x') as double;
  @override
  set x(double value) => RealmObjectBase.set(this, 'x', value);

  @override
  double get y => RealmObjectBase.get<double>(this, 'y') as double;
  @override
  set y(double value) => RealmObjectBase.set(this, 'y', value);

  @override
  RealmList<LineFragment> get lineFragments =>
      RealmObjectBase.get<LineFragment>(this, 'lineFragments')
          as RealmList<LineFragment>;
  @override
  set lineFragments(covariant RealmList<LineFragment> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Verse>> get changes =>
      RealmObjectBase.getChanges<Verse>(this);

  @override
  Verse freeze() => RealmObjectBase.freezeObject<Verse>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Verse._);
    return const SchemaObject(ObjectType.realmObject, Verse, 'Verse', [
      SchemaProperty('index', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('numberInChapter', RealmPropertyType.int),
      SchemaProperty('uthmanicText', RealmPropertyType.string),
      SchemaProperty('text', RealmPropertyType.string),
      SchemaProperty('cleanText', RealmPropertyType.string),
      SchemaProperty('searchText', RealmPropertyType.string),
      SchemaProperty('unicode', RealmPropertyType.string),
      SchemaProperty('numberInChapterUnicode', RealmPropertyType.string),
      SchemaProperty('page', RealmPropertyType.object,
          optional: true, linkTarget: 'Page'),
      SchemaProperty('chapter', RealmPropertyType.object,
          optional: true, linkTarget: 'Chapter'),
      SchemaProperty('quarter', RealmPropertyType.object,
          optional: true, linkTarget: 'Quarter'),
      SchemaProperty('part', RealmPropertyType.object,
          optional: true, linkTarget: 'Part'),
      SchemaProperty('section', RealmPropertyType.int),
      SchemaProperty('x', RealmPropertyType.double),
      SchemaProperty('y', RealmPropertyType.double),
      SchemaProperty('lineFragments', RealmPropertyType.object,
          linkTarget: 'LineFragment', collectionType: RealmCollectionType.list),
    ]);
  }
}
