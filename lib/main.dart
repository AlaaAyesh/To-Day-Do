import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day_do/to_day_do_app.dart';

import 'busines_logic/task_provider.dart';
import 'busines_logic/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const ToDayDo(),
    ),
  );
}