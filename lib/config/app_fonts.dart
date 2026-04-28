import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colours.dart';

class AppFonts {
  AppFonts._();

  // Font utama aplikasi (Latin)
  static TextStyle get primary => GoogleFonts.inter(
        color: AppColours.textDark,
      );

  // Font khusus bahasa Arab
  static TextStyle get arabic => GoogleFonts.amiri(
        color: AppColours.textDark,
      );

  // --- Preset Teks Latin ---
  static TextStyle get heading1 => primary.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get heading2 => primary.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get subtitle => primary.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.grey[600],
      );

  static TextStyle get body => primary.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );

  // --- Preset Teks Arab ---
  static TextStyle get arabicDisplay => arabic.copyWith(
        fontSize: 38,
        height: 2.2, // Jarak antar baris lebar agar mudah dibaca
        color: AppColours.textLight,
      );

  static TextStyle get arabicTitle => arabic.copyWith(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: AppColours.primary,
      );
}
