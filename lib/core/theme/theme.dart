import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

ThemeData getAppDarkThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),
      displayMedium:
          GoogleFonts.lato(fontSize: 16.sp, color: AppColors.textColor),
      displaySmall:
          GoogleFonts.lato(fontSize: 16.sp, color: AppColors.textColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
  );
}

ThemeData getAppLightThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.textColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.backgroundColor,
      ),
      displayMedium:
          GoogleFonts.lato(fontSize: 16.sp, color: AppColors.backgroundColor),
      displaySmall:
          GoogleFonts.lato(fontSize: 16.sp, color: AppColors.backgroundColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          4.r,
        )),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black),
      labelStyle: TextStyle(color: Colors.black),
    )
  );
}
