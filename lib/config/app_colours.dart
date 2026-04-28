import 'package:flutter/material.dart';

class AppColours {
  AppColours._();

  // --- Brand / Primary Colors ---
  static const Color primary = Color(0xFF00695C); // Hijau Emerald (Teal gelap)
  static const Color primaryLight = Color(0xFF26A69A); // Hijau terang
  static const Color primaryDark = Color(0xFF003D33); // Hijau pekat (mendekati hitam)

  // --- Background Colors ---
  static const Color backgroundLight = Color(0xFFF4F9F8); // Abu-abu hijau sangat soft
  static const Color backgroundWhite = Colors.white;

  // --- Gradient Colors (Ikon & Highlight) ---
  static const Color gradientStart = Color(0xFF4ADE80); // Hijau muda cerah
  static const Color gradientEnd = Color(0xFF059669); // Hijau zamrud

  // --- Text Colors ---
  static const Color textDark = Color(0xFF2D3748);
  static const Color textLight = Colors.white;
  static const Color textGrey = Colors.grey;

  // --- Gradients ---
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primary, primaryLight, primaryDark],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );
}
