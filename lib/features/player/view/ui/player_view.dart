import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcosmos_test/config/app_colours.dart';
import 'package:transcosmos_test/config/app_fonts.dart';
import '../../controller/player_controller.dart';
import '../components/player_header_info.dart';
import '../components/player_arabic_text.dart';
import '../components/player_controls.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  final PlayerController controller = Get.find<PlayerController>();
  late int surahNumber;

  @override
  void initState() {
    super.initState();
    surahNumber = Get.arguments ?? 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.playSurah(surahNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColours.textLight,
            size: 36,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColours.darkGradient,
        ),
        child: Obx(() {
          if (controller.isLoading.value ||
              controller.currentSurah.value == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: AppColours.textLight),
                  const SizedBox(height: 20),
                  Text(
                    'Menyiapkan Murottal...',
                    style: AppFonts.body.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          final surah = controller.currentSurah.value!;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // --- HEADER INFO COMPONENT ---
                  PlayerHeaderInfo(
                    surah: surah,
                    audioPlayer: controller.audioPlayer,
                  ),

                  // --- AREA TEKS ARAB COMPONENT ---
                  PlayerArabicText(
                    surah: surah,
                    audioPlayer: controller.audioPlayer,
                  ),

                  // --- AREA CONTROLS & PROGRESS BAR COMPONENT ---
                  PlayerControls(
                    controller: controller,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
