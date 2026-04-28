import 'package:dio/dio.dart';
import '../../../services/dio_service.dart';
import 'i_player_repository.dart';
import '../models/surah_detail_response_model.dart';

class PlayerRepository implements IPlayerRepository {
  // Menggunakan instance dari DioService yang sudah dibuat (Singleton)
  final DioService _dioService = DioService();

  @override
  Future<SurahDetailModel> getSurahDetail(int surahNumber) async {
    try {
      // Endpoint disesuaikan karena baseUrl sudah 'https://api.alquran.cloud/v1'
      final response = await _dioService.get('/surah/$surahNumber/ar.alafasy');
      
      // Parse data JSON ke model Response
      final surahDetailResponse = SurahDetailResponseModel.fromJson(response.data);
      
      if (surahDetailResponse.code == 200 && surahDetailResponse.data != null) {
        return surahDetailResponse.data!;
      } else {
        throw Exception(surahDetailResponse.status ?? 'Gagal memuat data surah');
      }
    } on DioException catch (e) {
      // Menggunakan pesan error yang rapi dari DioService
      throw Exception(DioService.getErrorMessage(e));
    } catch (e) {
      // Tangkap error lainnya (seperti parsing error, dll)
      throw Exception('Terjadi kesalahan tidak terduga: $e');
    }
  }
}
