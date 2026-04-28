import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:transcosmos_test/features/surah/models/surah_response_model.dart';
import 'package:transcosmos_test/features/surah/repositories/i_surah_repository.dart';

class SurahController extends GetxController {
  final ISurahRepository repository;
  SurahController(this.repository);

  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  
  List<SurahModel> _allSurahs = []; // Data master dari API (seluruh 114 surah)
  
  var surahList = <SurahModel>[].obs; // Data pagination memori
  var filteredSurahList = <SurahModel>[].obs; // Data untuk ditampilkan

  int currentOffset = 0;
  final int limit = 15;
  bool hasMore = true;
  String currentQuery = '';

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    fetchInitialSurahs();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      loadMoreSurahs();
    }
  }

  Future<void> refreshSurahs() async {
    await fetchInitialSurahs();
  }

  Future<void> fetchInitialSurahs() async {
    try {
      isLoading(true);
      
      // Memberikan jeda buatan (2 detik) agar efek shimmer bisa terlihat dengan jelas
      await Future.delayed(const Duration(seconds: 2));

      // Fetch HANYA SEKALI ke API untuk mengambil seluruh 114 surah
      var result = await repository.getSurahs();
      _allSurahs = result;
      
      currentOffset = 0;
      hasMore = true;
      
      // Ambil 15 surah pertama dari memori lokal (Client-side pagination)
      final paginatedData = _allSurahs.take(limit).toList();
      surahList.assignAll(paginatedData);
      _applyFilter();
      
      if (_allSurahs.length <= limit) {
        hasMore = false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMoreSurahs() async {
    if (isLoadingMore.value || !hasMore || isLoading.value) return;
    
    // Jangan lakukan load more saat sedang mode pencarian
    if (currentQuery.isNotEmpty) return;

    isLoadingMore(true);
    
    // Beri jeda 500ms agar animasi loading UI sempat terlihat karena load dari memori sangat instan
    await Future.delayed(const Duration(milliseconds: 500));
    
    currentOffset += limit;
    
    int end = currentOffset + limit;
    if (end >= _allSurahs.length) {
      end = _allSurahs.length;
      hasMore = false; // Sudah mencapai 114 surah
    }

    // Ambil slice (potongan) data berikutnya
    final nextData = _allSurahs.sublist(currentOffset, end);
    surahList.addAll(nextData);
    _applyFilter();
    
    isLoadingMore(false);
  }

  void searchSurah(String query) {
    currentQuery = query;
    _applyFilter();
  }

  void _applyFilter() {
    if (currentQuery.isEmpty) {
      filteredSurahList.assignAll(surahList);
    } else {
      // PENTING: Saat mencari, gunakan _allSurahs agar hasil pencarian
      // mencakup seluruh 114 surah meskipun belum di-scroll/load more.
      var result = _allSurahs
          .where(
            (surah) =>
                (surah.englishName
                        ?.toLowerCase()
                        .contains(currentQuery.toLowerCase()) ??
                    false) ||
                (surah.name
                        ?.toLowerCase()
                        .contains(currentQuery.toLowerCase()) ??
                    false),
          )
          .toList();
      filteredSurahList.assignAll(result);
    }
  }
}
