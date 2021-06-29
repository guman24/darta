import 'package:flutter/material.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBlue,
    accentColor: AppColors.primaryBlue,
    backgroundColor: AppColors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

List<Color> categoryColorList = [
  Color(0xFFF47181),
  Color(0xFF7F5B53),
  Color(0xFF2488FF),
  Color(0xFF2488FF),
  Color(0xFF7F5B53),
  Color(0xFFF47181)
];

List<Color> noticesColorList = [
  Color(0xFFD8D6FD),
  Color(0xFFFCEFC1),
  Color(0xFFC6F2E8),
  Color(0xFFFCD3C3)
];
