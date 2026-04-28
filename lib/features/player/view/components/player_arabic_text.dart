import 'package:flutter/material.dart';
import 'package:transcosmos_test/config/app_colours.dart';
import 'package:transcosmos_test/config/app_fonts.dart';
import 'package:transcosmos_test/features/player/models/surah_detail_response_model.dart';
import 'package:just_audio/just_audio.dart';

class PlayerArabicText extends StatelessWidget {
  final SurahDetailModel surah;
  final AudioPlayer audioPlayer;

  const PlayerArabicText({
    super.key,
    required this.surah,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<int?>(
        stream: audioPlayer.currentIndexStream,
        builder: (context, snapshot) {
          final currentIndex = snapshot.data ?? 0;
          final ayahs = surah.ayahs ?? [];
          
          if (ayahs.isEmpty || currentIndex >= ayahs.length) {
            return Center(
              child: Text(
                'Tidak ada teks ayat',
                style: AppFonts.body.copyWith(color: AppColours.textLight),
              ),
            );
          }

          final currentAyah = ayahs[currentIndex];

          return Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentAyah.text ?? '',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: AppFonts.arabicDisplay.copyWith(
                      shadows: [
                        const Shadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
