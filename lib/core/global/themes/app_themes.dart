import 'package:flutter/material.dart';
import 'package:to_day_do/core/global/colors/app_color.dart';

ThemeData lightTheme() => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.greenSpringRain,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.greenSpringRain),
      ),
      iconTheme: const IconThemeData(color: AppColors.greenSpringRain),
    );

ThemeData darkTheme() => ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.greenSpringRain),
      ),
      iconTheme: const IconThemeData(color: AppColors.greenSpringRain),
    );
