import 'package:flutter/material.dart';
import 'package:transcosmos_test/config/app_colours.dart';
import 'package:transcosmos_test/config/app_fonts.dart';
import 'package:transcosmos_test/features/player/models/surah_detail_response_model.dart';
import 'package:just_audio/just_audio.dart';

class PlayerHeaderInfo extends StatelessWidget {
  final SurahDetailModel surah;
  final AudioPlayer audioPlayer;

  const PlayerHeaderInfo({
    super.key,
    required this.surah,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final type = surah.revelationType == 'Meccan' ? 'Makkiyah' : 'Madaniyah';

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          surah.englishName ?? '',
          style: AppFonts.heading1.copyWith(color: AppColours.textLight),
        ),
        const SizedBox(height: 4),
        Text(
          '${surah.name} • $type',
          style: AppFonts.arabic.copyWith(
            color: Colors.white70,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 16),
        
        // Indikator Ayat
        StreamBuilder<int?>(
          stream: audioPlayer.currentIndexStream,
          builder: (context, snapshot) {
            final currentIndex = snapshot.data ?? 0;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColours.textLight.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Ayat ${currentIndex + 1} dari ${surah.numberOfAyahs}',
                style: AppFonts.body.copyWith(color: AppColours.textLight),
              ),
            );
          },
        ),
      ],
    );
  }
}
