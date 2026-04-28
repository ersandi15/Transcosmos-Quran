import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:transcosmos_test/features/player/repositories/i_player_repository.dart';
import 'package:transcosmos_test/features/player/models/surah_detail_response_model.dart';

class PlayerController extends GetxController {
  final IPlayerRepository repository;
  PlayerController(this.repository);

  final AudioPlayer audioPlayer = AudioPlayer();
  var isLoading = false.obs;
  
  // Expose model detail surah agar bisa ditampilkan di UI
  var currentSurah = Rxn<SurahDetailModel>();

  // Stream untuk Progress Bar (Position, Buffered, Total)
  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    // Pantau perubahan posisi audio secara real-time
    audioPlayer.positionStream.listen((p) => position.value = p);
    audioPlayer.durationStream.listen((d) => duration.value = d ?? Duration.zero);
  }

  Future<void> playSurah(int surahNumber) async {
    try {
      isLoading(true);
      var detail = await repository.getSurahDetail(surahNumber);
      currentSurah.value = detail;
      
      // Menggabungkan semua link audio ayat menjadi list AudioSource
      final playlistSources = (detail.ayahs ?? [])
          .where((ayah) => ayah.audio != null && ayah.audio!.isNotEmpty)
          .map((ayah) => AudioSource.uri(Uri.parse(ayah.audio!)))
          .toList();

      await audioPlayer.setAudioSources(playlistSources);
      audioPlayer.play();
    } catch (e) {
      Get.snackbar("Playback Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void togglePlayPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  void seek(Duration position) {
    audioPlayer.seek(position);
  }

  void skipNext() {
    if (audioPlayer.hasNext) {
      audioPlayer.seekToNext();
    }
  }

  void skipPrevious() {
    if (audioPlayer.hasPrevious) {
      audioPlayer.seekToPrevious();
    } else {
      audioPlayer.seek(Duration.zero);
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose(); // Penting untuk mencegah memory leak
    super.onClose();
  }
}