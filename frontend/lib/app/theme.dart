import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primaryBlue = Color(0xFF1B2D4F); // Dark blue for headers
  static const Color background = Color(0xFFF8F9FB);  // Light greyish background
  static const Color white = Colors.white;
  static const Color accentYellow = Color(0xFFFFF4E6); // Light orange/yellow for "وفر XP"
  static const Color textBlack = Color(0xFF000000);
  static const Color textGrey = Color(0xFF757575);
  static const Color successGreen = Color(0xFF2E7D32);
  static const Color errorRed = Color(0xFFC62828);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Cairo', // Assuming you use an Arabic-friendly font like Cairo
      
      // Card Theme
      cardTheme: CardTheme(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // Text Theme
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.textBlack),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.textGrey),
      ),
    );
  }
}