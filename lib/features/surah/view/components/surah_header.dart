import 'package:flutter/material.dart';
import 'package:transcosmos_test/config/app_colours.dart';
import 'package:transcosmos_test/config/app_fonts.dart';

class SurahHeader extends StatelessWidget {
  final Function(String) onSearch;

  const SurahHeader({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColours.primary,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColours.backgroundWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              onChanged: onSearch,
              style: AppFonts.body,
              decoration: InputDecoration(
                hintText: 'Cari nama surah...',
                hintStyle: AppFonts.body.copyWith(
                  color: Colors.grey[400],
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColours.primaryLight,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                ),
              ),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 24, bottom: 100),
        title: Text(
          'Al-Quran',
          style: AppFonts.heading2.copyWith(
            color: AppColours.textLight,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppColours.primaryGradient,
          ),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                top: -0,
                child: Icon(
                  Icons.menu_book_rounded,
                  size: 160,
                  color: AppColours.textLight.withValues(alpha: 0.1),
                ),
              ),
              Positioned(
                left: 24,
                top: 40,
                child: Text(
                  'Bacaan Murottal',
                  style: AppFonts.subtitle.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
