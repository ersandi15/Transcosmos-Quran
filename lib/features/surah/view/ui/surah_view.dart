import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcosmos_test/config/app_colours.dart';
import 'package:transcosmos_test/config/app_routes.dart';
import '../../controller/surah_controller.dart';
import '../components/surah_header.dart';
import '../components/surah_card.dart';
import '../components/surah_loading_skeleton.dart';
import '../components/surah_empty_state.dart';

class SurahView extends GetView<SurahController> {
  const SurahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.backgroundLight,
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: controller.refreshSurahs,
          color: AppColours.primaryLight,
          child: CustomScrollView(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // --- HEADER COMPONENT ---
              SurahHeader(onSearch: (value) => controller.searchSurah(value)),

              const SliverPadding(padding: EdgeInsets.only(top: 12)),

              // --- KONDISI LOADING / EMPTY / LIST ---
              if (controller.isLoading.value)
                const SurahLoadingSkeleton(itemCount: 8)
              else if (controller.filteredSurahList.isEmpty)
                const SurahEmptyState()
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  sliver: SliverList.builder(
                    itemCount: controller.filteredSurahList.length + 1,
                    itemBuilder: (context, index) {
                      // Indikator Loading untuk Pagination (Item Paling Bawah)
                      if (index == controller.filteredSurahList.length) {
                        return Obx(() {
                          if (controller.isLoadingMore.value) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColours.primaryLight,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        });
                      }

                      final surah = controller.filteredSurahList[index];

                      // --- CARD COMPONENT ---
                      return SurahCard(
                        surah: surah,
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.player,
                            arguments: surah.number,
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
