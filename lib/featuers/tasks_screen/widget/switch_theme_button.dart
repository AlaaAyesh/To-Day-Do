import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../busines_logic/theme_provider.dart';

class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return GestureDetector(
          onTap: () {
            themeProvider.toggleTheme();
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    themeProvider.isDarkMode
                        ? const Icon(Icons.nightlight_round)
                        : const Icon(Icons.wb_sunny),
                    const SizedBox(width: 8), // Add space between icon and text
                    Text(
                      themeProvider.isDarkMode ? 'Dark Mode' : 'Light Mode',
                      style: TextStyle(
                        fontSize: 16,
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
