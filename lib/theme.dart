import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFFFA45B);     // orange pastel
  static const Color background = Color(0xFFFFF6EE);  // krem lembut
  static const Color pink = Color(0xFFFF92C2);        // pink pastel
  static const Color yellow = Color(0xFFFFE39A);      // kuning pastel
}

ThemeData buildAppTheme() {
  final baseScheme = ColorScheme.fromSeed(seedColor: AppColors.primary);
  final fredoka = GoogleFonts.fredokaTextTheme(); // semua teks pakai Fredoka

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: baseScheme.copyWith(
      surface: AppColors.background,
    ),
    textTheme: fredoka,

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.black87,
      titleTextStyle: fredoka.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: fredoka.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: fredoka.labelSmall,
    ),

    // Tombol & elemen lainnya
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: fredoka.labelLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
