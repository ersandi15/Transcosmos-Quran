import 'package:flutter/material.dart';
import 'package:transcosmos_test/config/app_colours.dart';
import 'package:transcosmos_test/config/app_fonts.dart';
import 'package:transcosmos_test/features/surah/models/surah_response_model.dart';

class SurahCard extends StatelessWidget {
  final SurahModel surah;
  final VoidCallback onTap;

  const SurahCard({super.key, required this.surah, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final revelation = surah.revelationType == 'Meccan' ? 'Makkiyah' : 'Madaniyah';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColours.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Angka Surah dengan Kotak Gradient
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: AppColours.accentGradient,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColours.gradientStart.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${surah.number}',
                    style: AppFonts.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColours.textLight,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Info Surah
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah.englishName ?? '',
                        style: AppFonts.body.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$revelation • ${surah.numberOfAyahs} Ayat',
                        style: AppFonts.body.copyWith(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Teks Arab
                Text(
                  surah.name ?? '',
                  style: AppFonts.arabicTitle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
