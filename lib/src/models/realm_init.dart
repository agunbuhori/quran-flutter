import 'package:quran/src/models/realm_models.dart';
import 'package:realm/realm.dart';

Future<Realm> getRealm() async {
  final config = Configuration.local([
    Verse.schema,
    Chapter.schema,
    ChapterHeader.schema,
    LineFragment.schema,
    Page.schema,
    Part.schema,
    Quarter.schema,
  ]);

  return Realm(config);
}
