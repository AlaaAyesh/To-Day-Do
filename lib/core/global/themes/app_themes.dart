import 'package:flutter/material.dart';
import 'package:to_day_do/core/global/colors/app_color.dart';

ThemeData lightTheme() => ThemeData(
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              mouseCursor:
                  MaterialStatePropertyAll(MaterialStateMouseCursor.clickable),
              shadowColor: MaterialStatePropertyAll(AppColors.mainColor5),
              textStyle: MaterialStatePropertyAll(TextStyle(
                  color: AppColors.mainColor5,
                  fontFamily: 'Mueda City.ttf',
                  letterSpacing: 1.2)),
              backgroundColor: MaterialStatePropertyAll(AppColors.mainColor3))),
      dividerColor: AppColors.mainColor3,
      cardColor: AppColors.mainColor1,
      backgroundColor: Colors.transparent,
      scaffoldBackgroundColor: AppColors.mainColor1,
      primaryColor: AppColors.mainColor1,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.mainColor4,
          fontFamily: 'Mueda City.ttf',
        ),
      ),
      iconTheme:
          const IconThemeData(color: AppColors.mainColor4), // Light mode color
      actionIconTheme: const ActionIconThemeData(
          // backButtonIconBuilder:
          ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.mainColor4; // color when checkbox is selected
            }
            return AppColors.mainColor1; // color when checkbox is not selected
          },
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
              AppColors.mainColor4), // Light mode color
        ),
      ),


    );

ThemeData darkTheme() => ThemeData.dark().copyWith(
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              mouseCursor:
                  MaterialStatePropertyAll(MaterialStateMouseCursor.clickable),
              shadowColor: MaterialStatePropertyAll(AppColors.mainColor5),
              textStyle: MaterialStatePropertyAll(TextStyle(
                  color: AppColors.mainColor5,
                  fontFamily: 'Mueda City.ttf',
                  letterSpacing: 1.2)),
              backgroundColor: MaterialStatePropertyAll(AppColors.mainColor3))),

      dividerColor: AppColors.mainColor3,
      cardColor: AppColors.mainColor4,
      scaffoldBackgroundColor: AppColors.mainColor5,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.mainColor1,
          fontFamily: 'Mueda City.ttf',
        ),
      ),
      iconTheme:
          const IconThemeData(color: AppColors.mainColor1), // Dark mode color
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.mainColor4;
            }
            return AppColors.mainColor1;
          },
        ),
        fillColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.mainColor1;
            }
            return AppColors.mainColor4;
          },
        ),
      ),
    );
