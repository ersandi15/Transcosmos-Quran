import 'package:flutter/material.dart';
import 'package:transcosmos_test/config/app_fonts.dart';

class SurahEmptyState extends StatelessWidget {
  const SurahEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Surah tidak ditemukan',
              style: AppFonts.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
