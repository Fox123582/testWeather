import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFFFF9F1C); // Orange for 'K' and accents
  static const Color background = Color(0xFF0F172A);
  static const Color cardBackground = Color(0xFF1E293B);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF94A3B8);
  
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E293B),
      Color(0xFF0F172A),
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6366F1),
      Color(0xFFA855F7),
    ],
  );
}
