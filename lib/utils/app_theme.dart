import 'package:flutter/material.dart';

/// فئة تحتوي على الألوان والثيمات - تصميم عصري واحترافي
class AppTheme {
  // الألوان الأساسية - تصميم حديث
  static const Color darkBackground = Color(0xFF121212);      // أسود عميق
  static const Color primaryColor = Color(0xFF00FF41);        // أخضر نيون
  static const Color accentColor = Color(0xFF00FF41);         // أخضر نيون
  static const Color textWhite = Color(0xFFFFFFFF);           // أبيض
  static const Color textGray = Color(0xFF9CA3AF);            // رمادي
  static const Color textDarkGray = Color(0xFF6B7280);        // رمادي غامق
  static const Color cardBackground = Color(0xFF1E1E1E);      // رمادي غامق للكارتات

  // Dark Theme - احترافي
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkBackground,
    useMaterial3: true,

    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: primaryColor),
      titleTextStyle: TextStyle(
        color: textWhite,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardBackground,
      hintStyle: const TextStyle(color: textDarkGray),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: textDarkGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: textDarkGray, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: textWhite,
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
      ),
      headlineSmall: TextStyle(
        color: textWhite,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: TextStyle(
        color: textWhite,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: textGray,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        color: primaryColor,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: darkBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: darkBackground,
        ),
      ),
    ),

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: cardBackground,
      contentTextStyle: TextStyle(color: textWhite),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );

  /// الحصول على لون الفئة (Category Color) - ألوان حديثة
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'flutter':
        return const Color(0xFF3B82F6); // أزرق حديث
      case 'dart':
        return const Color(0xFF06B6D4); // سيان
      case 'firebase':
        return const Color(0xFFF59E0B); // كهرماني
      case 'تصميم':
      case 'design':
        return const Color(0xFFEC4899); // وردي
      case 'أمان':
      case 'security':
        return const Color(0xFFEF4444); // أحمر
      case 'إحصائيات':
      case 'statistics':
        return const Color(0xFF10B981); // أخضر
      default:
        return primaryColor;
    }
  }
}
