import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../busines_logic/user_provider.dart';
import '../../user_info_screen/persentation/profile_screen.dart';
import 'home_app_bar/widget/app_bar_profile_image.dart';

class DrawerProfileInfo extends StatefulWidget {
  const DrawerProfileInfo.drawerProfileInfo({super.key});

  @override
  State<DrawerProfileInfo> createState() => _DrawerProfileInfoState();
}

class _DrawerProfileInfoState extends State<DrawerProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
            if (result == true) {
              setState(() {});
            }
          },
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipOval(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ProfileImage(
                          imageUrl: userProvider.imageUrl,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}