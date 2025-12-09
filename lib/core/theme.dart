import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color lightBlue = Color(0xFFE0F2FE);
  static const Color background = Colors.white;
  static const Color successGreen = Color(0xFF22C55E);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryBlue,
      primary: primaryBlue,
      secondary: lightBlue,
      // background dihapus karena deprecated, cukup pakai scaffoldBackgroundColor
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: background,
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: primaryBlue,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryBlue, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
    ),
    // 👉 gunakan CardThemeData (bukan CardTheme lagi)
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    ),
  );
}
