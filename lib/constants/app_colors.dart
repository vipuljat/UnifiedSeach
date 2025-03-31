import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color youtubeRed = Color(0xFFFF0000);
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color redditOrange = Color(0xFFFF4500);

  // ✅ Add Instagram Colors
  static const Color instagramPink = Color(0xFFC13584); 
  static const LinearGradient instagramGradient = LinearGradient(
    colors: [
      Color(0xFFF58529), // Orange
      Color(0xFFDD2A7B), // Pink
      Color(0xFF8134AF), // Purple
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
