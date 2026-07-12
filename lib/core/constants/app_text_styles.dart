import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading([BuildContext? context]) =>
      GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle title([BuildContext? context]) =>
      GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle body([BuildContext? context]) =>
      GoogleFonts.poppins(
        fontSize: 14,
        color: AppColors.textPrimary,
      );

  static TextStyle caption([BuildContext? context]) =>
      GoogleFonts.poppins(
        fontSize: 12,
        color: AppColors.textSecondary,
      );

  static TextStyle button([BuildContext? context]) =>
      GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  static TextStyle cardTitle([BuildContext? context]) =>
      GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle cardValue([BuildContext? context]) =>
      GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );
}