import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcosmos_test/config/app_colours.dart';
import 'package:transcosmos_test/features/splash_screen/controller/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primary,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: 0.8 + (value * 0.2), // Membesar perlahan dari 0.8 ke 1.0
                child: child,
              ),
            );
          },
          child: Image.asset(
            'assets/icon/ic_app.png',
            width: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
