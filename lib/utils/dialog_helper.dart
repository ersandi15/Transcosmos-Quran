import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcosmos_test/config/app_colours.dart';
import 'package:transcosmos_test/config/app_fonts.dart';

class DialogHelper {
  static void showError({String title = 'Terjadi Kesalahan', required String description}) {
    // Hindari menumpuk dialog jika sudah ada
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColours.backgroundWhite,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.redAccent,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: AppFonts.heading2.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: AppFonts.body.copyWith(color: AppColours.textGrey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColours.primary,
                    foregroundColor: AppColours.textLight,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (Get.isDialogOpen ?? false) {
                      Get.back();
                    }
                  },
                  child: Text(
                    'Tutup',
                    style: AppFonts.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColours.textLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
