import 'package:get/get.dart';
import 'package:transcosmos_test/config/app_routes.dart';
import 'package:transcosmos_test/features/player/view/ui/player_view.dart';

// Import Views
import 'package:transcosmos_test/features/splash_screen/view/ui/splash_screen_view.dart';
import 'package:transcosmos_test/features/surah/view/ui/surah_view.dart';

// Import Controllers
import 'package:transcosmos_test/features/splash_screen/controller/splash_screen_controller.dart';
import 'package:transcosmos_test/features/surah/controller/surah_controller.dart';
import 'package:transcosmos_test/features/player/controller/player_controller.dart';

// Import Repositories
import 'package:transcosmos_test/features/surah/repositories/i_surah_repository.dart';
import 'package:transcosmos_test/features/surah/repositories/surah_repository.dart';
import 'package:transcosmos_test/features/player/repositories/i_player_repository.dart';
import 'package:transcosmos_test/features/player/repositories/player_repository.dart';

class AppPages {
  AppPages._();

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: AppRoutes.splash,
        page: () => const SplashScreenView(),
        binding: BindingsBuilder(() {
          Get.put(SplashScreenController());
        }),
      ),
      GetPage(
        name: AppRoutes.surah,
        page: () => const SurahView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ISurahRepository>(() => SurahRepository());
          Get.lazyPut<SurahController>(() => SurahController(Get.find()));
        }),
      ),
      GetPage(
        name: AppRoutes.player,
        page: () => const PlayerView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<IPlayerRepository>(() => PlayerRepository());
          Get.lazyPut<PlayerController>(() => PlayerController(Get.find()));
        }),
      ),
    ];
  }
}
