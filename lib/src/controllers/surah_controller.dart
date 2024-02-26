import 'package:get/state_manager.dart';
import 'package:quran/src/models/surah.dart';

class SurahController extends GetxController {
  RxList<Surah> surahs = <Surah>[].obs;

  @override
  void onInit() {
    fetchSurahs(); // Fetch data when controller is initialized
    super.onInit();
  }

  void fetchSurahs() async {
    surahs.value = Surah.getAll().obs as List<Surah>;
  }
}
