import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static final TextStyle titleStyle = GoogleFonts.mukta(
    fontSize: 22.0,
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );
  static final TextStyle subtitleStyle = GoogleFonts.mukta(
    fontSize: 20.0,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );
  static final TextStyle normalStyle = GoogleFonts.mukta(
    fontSize: 18.0,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle generalStyle = GoogleFonts.mukta(
    fontSize: 16.0,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
}
