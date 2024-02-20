import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_day_do/featuers/home_screen/widget/drawer_profile_info.dart';

import '../../tasks_screen/persentation/tasks_screen.dart';
import '../../tasks_screen/widget/switch_theme_button.dart';
import 'home_app_bar/widget/logout_button.dart';

class DrawerContents extends StatelessWidget {
  const DrawerContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          const DrawerProfileInfo.drawerProfileInfo(),
          Divider(
            height: MediaQuery.of(context).size.height * 0.1,
            color: Colors.orangeAccent,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TasksScreen(),
                ),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.notes),
                Text("TASKS SCREEN"),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.tv),
              Text("NEWS SCREEN"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.note),
              Text("NOTES SCREEN"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Divider(
            height: MediaQuery.of(context).size.height * 0.1,
            color: Colors.orangeAccent,
          ),
          const ThemeToggleSwitch(),
          LogoutButton(auth: FirebaseAuth.instance),
        ],
      ),
    );
  }
}
