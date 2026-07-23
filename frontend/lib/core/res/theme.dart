import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF1B2D4F);
  static const Color background = Color(0xFFF8F9FB);
  static const Color white = Colors.white;
  static const Color accentYellow = Color(0xFFFFF4E6);
  static const Color textBlack = Color(0xFF000000);
  static const Color textGrey = Color(0xFF757575);
  static const Color successGreen = Color(0xFF2E7D32);
  static const Color errorRed = Color(0xFFC62828);
}

// Added helper for consistent design
class AppDimens {
  static const double borderRadius = 20.0;
  static const double padding = 20.0;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Cairo',

      cardTheme: const CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.borderRadius),
          ),
        ),
      ),

      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryBlue,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.textBlack),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.textGrey),
      ),
    );
  }
}
