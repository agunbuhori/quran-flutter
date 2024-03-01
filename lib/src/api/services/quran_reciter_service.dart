import 'package:quran/src/common/consts/quran_reciters.dart';
import 'package:quran/src/models/recitation_times.dart';
import 'package:dio/dio.dart';

class QuranReciterService {
  final Dio _dio = Dio();
  final AbuBakarShatri _abubakarShatri = AbuBakarShatri();

  Future<RecitationTimes> getRecitationTimes(int surahId) async {
    try {
      Response<Map<String, dynamic>> response = await _dio.get(_abubakarShatri
          .timingsUrl
          .replaceAll('{chapter}', surahId.toString()));

      if (response.data != null) {
        return RecitationTimes.fromJson(response.data?['audio_files'][0]);
      } else {
        throw "error";
      }
    } catch (e) {
      rethrow;
    }
  }
}
