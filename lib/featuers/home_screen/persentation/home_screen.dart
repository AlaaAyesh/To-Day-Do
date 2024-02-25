import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../busines_logic/task_provider.dart';
import '../../../core/global/colors/app_color.dart';
import '../../news_screen/persentation/news_screen.dart';
import '../widget/drawer_content.dart';
import '../widget/home_app_bar/persentation/home_app_bar.dart';
import '../widget/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final gradientColors =
    isDarkMode ? darkThemeGradientColors : lightThemeGradientColors;
    final fabColor =
    isDarkMode ? AppColors.mainColor2 : AppColors.mainColor3;

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return Scaffold(
          drawer: const DrawerContents(),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeScreenAppBar(auth: auth),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020),
                    const HomeScreenBody(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            onPressed: () {
                              _showAddTaskDialog(context); // Show dialog to add task
                            },
                            child: Image.asset(
                              isDarkMode
                                  ? 'assets/app_images/sticky-notes.png'
                                  : 'assets/app_images/sticky-notes1.png',
                              width: MediaQuery.of(context).size.width * 0.25,
                              height:
                              MediaQuery.of(context).size.height * 0.25,
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          onPressed: () {
                            _showNewsSearchDialog(context); // Show dialog to search news
                          },
                          child: Image.asset(
                            isDarkMode ? 'assets/app_images/search.png' : 'assets/app_images/search1.png',
                            width: MediaQuery.of(context).size.width * 0.10,
                            height: MediaQuery.of(context).size.height * 0.10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        );
      },
    );
  }

  List<Color> get lightThemeGradientColors => [
    AppColors.mainColor1,
    AppColors.mainColor2,
  ];

  List<Color> get darkThemeGradientColors => [
    AppColors.mainColor5,
    AppColors.mainColor4,
  ];

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(
            'Add New Task',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 22,
              fontFamily:
              Theme.of(context).textTheme.bodyLarge?.fontFamily,
            ),
          ),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter task name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add your code to add the new task here
                final taskName = controller.text;
                if (taskName.isNotEmpty) {
                  // Add the new task
                  Provider.of<TaskProvider>(context, listen: false).addTask(taskName);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
  void _showNewsSearchDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewsScreen()),
    );
  }
}
