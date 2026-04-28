import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transcosmos_test/features/surah/controller/surah_controller.dart';
import 'package:transcosmos_test/features/surah/repositories/i_surah_repository.dart';
import 'package:transcosmos_test/features/surah/models/surah_response_model.dart';
import 'package:get/get.dart';

// 1. MOCKING (Membuat objek palsu)
// Kita membuat tiruan dari ISurahRepository agar saat ditest, 
// kita tidak perlu menembak API asli (menghemat waktu & kuota, serta menghindari error server).
class MockSurahRepository extends Mock implements ISurahRepository {}

void main() {
  late SurahController controller;
  late MockSurahRepository mockRepository;

  // 2. SETUP (Persiapan sebelum setiap test)
  setUp(() {
    // Inisialisasi repository palsu
    mockRepository = MockSurahRepository();
    
    // Beritahu GetX bahwa ini adalah mode testing (menghindari error rendering dialog)
    Get.testMode = true; 
    
    // Suntikkan (Inject) repository palsu ke dalam controller
    controller = SurahController(mockRepository);
  });

  // 3. GROUP (Mengelompokkan test-test yang sejenis)
  group('SurahController Unit Test', () {
    
    test('State awal saat baru diinisialisasi harus benar', () {
      // Pastikan saat awal, loading bernilai true dan list kosong
      expect(controller.isLoading.value, true);
      expect(controller.surahList.isEmpty, true);
    });

    test('fetchInitialSurahs() harus sukses mengisi list dari API', () async {
      // --- ARRANGE (Persiapan Data) ---
      // Buat data dummy seolah-olah ini adalah balasan dari API asli
      final dummySurahs = [
        SurahModel(number: 1, name: 'Al-Fatihah', englishName: 'Al-Faatiha', numberOfAyahs: 7, revelationType: 'Meccan'),
        SurahModel(number: 2, name: 'Al-Baqarah', englishName: 'Al-Baqara', numberOfAyahs: 286, revelationType: 'Medinan'),
      ];
      
      // Ajari mockRepository: "Kalau nanti kamu disuruh getSurahs(), tolong langsung jawab pakai dummySurahs ya!"
      when(() => mockRepository.getSurahs()).thenAnswer((_) async => dummySurahs);

      // --- ACT (Aksi / Menjalankan Fungsi) ---
      await controller.fetchInitialSurahs();

      // --- ASSERT (Verifikasi / Pembuktian) ---
      expect(controller.isLoading.value, false); // Loading harus mati
      expect(controller.surahList.length, 2); // List di memori harus berisi 2
      expect(controller.filteredSurahList.length, 2); // List di UI harus berisi 2
      expect(controller.filteredSurahList.first.name, 'Al-Fatihah'); // Urutan pertama harus Al-Fatihah
      
      // Pastikan bahwa fungsi getSurahs di repository benar-benar cuma dipanggil 1 kali (tidak bocor/berulang)
      verify(() => mockRepository.getSurahs()).called(1);
    });

    test('searchSurah() harus bisa menyaring list dengan benar berdasarkan kata kunci', () async {
      // --- ARRANGE ---
      final dummySurahs = [
        SurahModel(number: 1, name: 'Al-Fatihah', englishName: 'Al-Faatiha'),
        SurahModel(number: 2, name: 'Al-Baqarah', englishName: 'Al-Baqara'),
        SurahModel(number: 3, name: 'Ali Imran', englishName: 'Aal-e-Imran'),
      ];
      when(() => mockRepository.getSurahs()).thenAnswer((_) async => dummySurahs);
      
      // Tarik data awal terlebih dahulu
      await controller.fetchInitialSurahs();

      // --- ACT ---
      // User mengetik 'Baqara' di kolom pencarian
      controller.searchSurah('Baqara');

      // --- ASSERT ---
      // Pastikan hasil filter sekarang tersisa 1 (Al-Baqarah)
      expect(controller.filteredSurahList.length, 1);
      expect(controller.filteredSurahList.first.englishName, 'Al-Baqara');

      // --- ACT 2 ---
      // User menghapus teks pencarian (kosong)
      controller.searchSurah('');

      // --- ASSERT 2 ---
      // Pastikan data kembali jadi 3 utuh
      expect(controller.filteredSurahList.length, 3);
    });
  });
}
