import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day_do/to_day_do_app.dart';

import 'busines_logic/news_provider.dart';
import 'busines_logic/task_provider.dart';
import 'busines_logic/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'busines_logic/user_provider.dart';
import 'firebase_options.dart';
void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => NewsProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const ToDayDo(),
    ),
  );
}
