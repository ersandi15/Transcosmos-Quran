import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:transcosmos_test/config/app_colours.dart';
import 'package:transcosmos_test/config/app_fonts.dart';
import 'package:transcosmos_test/features/player/controller/player_controller.dart';

class PlayerControls extends StatelessWidget {
  final PlayerController controller;

  const PlayerControls({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          ProgressBar(
            progress: controller.position.value,
            total: controller.duration.value,
            onSeek: controller.seek,
            baseBarColor: AppColours.textLight.withValues(alpha: 0.2),
            progressBarColor: AppColours.textLight,
            thumbColor: AppColours.textLight,
            timeLabelTextStyle: AppFonts.body.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous_rounded),
                color: AppColours.textLight,
                iconSize: 48,
                onPressed: controller.skipPrevious,
              ),
              StreamBuilder<bool>(
                stream: controller.audioPlayer.playingStream,
                builder: (context, snapshot) {
                  final isPlaying = snapshot.data ?? false;
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColours.textLight,
                      boxShadow: [
                        BoxShadow(
                          color: AppColours.textLight.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      ),
                      color: AppColours.primary,
                      iconSize: 56,
                      onPressed: controller.togglePlayPause,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next_rounded),
                color: AppColours.textLight,
                iconSize: 48,
                onPressed: controller.skipNext,
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      );
    });
  }
}
