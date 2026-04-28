import 'package:get/get.dart';
import 'package:transcosmos_test/config/app_routes.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startSplashScreen();
  }

  void _startSplashScreen() async {
    // Delay selama 2.5 detik untuk menampilkan logo
    await Future.delayed(const Duration(milliseconds: 2500));
    
    // Pindah ke halaman Surah dan hapus Splash dari stack history
    Get.offAllNamed(AppRoutes.surah);
  }
}
