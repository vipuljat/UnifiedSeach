import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

ThemeData getLightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    textTheme: getAppTextTheme(Brightness.light),
    cardTheme: CardTheme(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    // ✅ Instagram-specific Styles
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.instagramPink, // Default button color
    ),
  );
}

ThemeData getDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    textTheme: getAppTextTheme(Brightness.dark),
    cardTheme: CardTheme(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    // ✅ Instagram-specific Styles (Dark Mode)
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.instagramPink, // Keeps Instagram theme consistent
    ),
  );
}
