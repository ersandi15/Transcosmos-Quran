import 'package:dio/dio.dart';
import '../../../services/dio_service.dart';
import '../models/surah_response_model.dart';
import 'i_surah_repository.dart';

class SurahRepository implements ISurahRepository {
  final DioService _dioService = DioService();

  @override
  Future<List<SurahModel>> getSurahs() async {
    try {
      // Endpoint /surah selalu mengembalikan 114 surah sekaligus
      final response = await _dioService.get('/surah');
      
      final surahResponse = SurahResponseModel.fromJson(response.data);
      
      if (surahResponse.code == 200 && surahResponse.data != null) {
        return surahResponse.data!;
      } else {
        throw Exception(surahResponse.status ?? 'Gagal memuat daftar surah');
      }
    } on DioException catch (e) {
      throw Exception('Gagal terhubung ke server: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan tidak terduga: $e');
    }
  }
}
