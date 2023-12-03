import 'package:flutter/material.dart';
import 'package:to_day_do/core/global/colors/app_color.dart';

ThemeData lightTheme() => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.greenSpringRain,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.greenSpringRain),
      ),
      iconTheme: const IconThemeData(color: AppColors.greenSpringRain),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors
                  .greenSpringRain; // color when checkbox is selected
            }
            return Colors.white; // color when checkbox is not selected
          },
        ),
      ),
    );

ThemeData darkTheme() => ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.chiffon),
      ),
      iconTheme: const IconThemeData(color: AppColors.chiffon),
      checkboxTheme: CheckboxThemeData(
        checkColor:  MaterialStateColor.resolveWith(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.black; // color when checkbox is selected
            }
            return Colors.black; // color when checkbox is not selected
          },
        ),
        fillColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.chiffon; // color when checkbox is selected
            }
            return Colors.black; // color when checkbox is not selected
          },
        ),
      ),
    );
