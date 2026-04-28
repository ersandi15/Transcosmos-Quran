import '../models/surah_detail_response_model.dart';

abstract class IPlayerRepository {
  Future<SurahDetailModel> getSurahDetail(int surahNumber);
}