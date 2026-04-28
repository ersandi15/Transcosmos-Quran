import '../models/surah_response_model.dart';

abstract class ISurahRepository {
  Future<List<SurahModel>> getSurahs();
}
