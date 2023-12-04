import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../busines_logic/theme_provider.dart';

class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return GestureDetector(
          onTap: () {
            themeProvider.toggleTheme();
          },
          child: Row(
            mainAxisAlignment: themeProvider.isDarkMode
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: themeProvider.isDarkMode
                    ? const Icon(Icons.sunny)
                    : const Icon(Icons.brightness_2),
              ),
            ],
          ),
        );
      },
    );
  }
}
